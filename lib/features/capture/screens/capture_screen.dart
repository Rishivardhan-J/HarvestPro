import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../../core/permissions/jit_permission_flow.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/theme/motion_tokens.dart';
import '../../../data/models/capture_artifact.dart';
import '../../../data/repositories/capture_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared_widgets/offline_banner.dart';
import '../../home/providers/home_provider.dart';
import '../providers/camera_provider.dart';
import '../utils/image_processor.dart';
import '../widgets/text_note_fallback.dart';
import '../widgets/voice_note_overlay.dart';

class CaptureScreen extends ConsumerStatefulWidget {
  const CaptureScreen({super.key});

  @override
  ConsumerState<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends ConsumerState<CaptureScreen> {
  bool _cameraPermissionPermanentlyDenied = false;
  bool _micPermissionPermanentlyDenied = false;
  bool _permissionCheckDone = false;
  
  bool _isProcessing = false;
  String? _capturedImagePath;
  bool _flashVisible = false;
  bool _voiceMode = false;
  bool _hasNarrated = false;
  final FlutterTts _tts = FlutterTts();

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_checkPermissionsAndInit());
      _checkNarration();
    });
  }
  
  Future<void> _checkPermissionsAndInit() async {
    final cameraStatus = await Permission.camera.status;
    final micStatus = await Permission.microphone.status;
    
    if (cameraStatus.isPermanentlyDenied) {
      _cameraPermissionPermanentlyDenied = true;
    }
    if (micStatus.isPermanentlyDenied) {
      _micPermissionPermanentlyDenied = true;
    }
    
    // We already pre-warm in app_router.dart, but we call it here to ensure it's triggered if user navigates directly.
    if (!cameraStatus.isPermanentlyDenied) {
      unawaited(ref.read(cameraControllerProvider.notifier).preWarmCamera());
    }
    
    setState(() => _permissionCheckDone = true);
  }

  void _checkNarration() {
    if (_hasNarrated) {
      return;
    }
    
    final l10n = AppLocalizations.of(context)!;
    final voiceEnabled = ref.read(voiceNarrationEnabledProvider);
    if (voiceEnabled) {
      unawaited(_tts.speak(l10n.capture_instructionPhoto));
      _hasNarrated = true;
    }
  }

  Future<void> _takePhoto(CameraController controller) async {
    final l10n = AppLocalizations.of(context)!;
    // Check permission JIT
    final status = await JitPermissionFlow.requestWithRationale(
      context, 
      Permission.camera, 
      rationaleMessage: l10n.capture_cameraRationale, 
      icon: Icons.camera_alt,
    );
    
    if (!status.isGranted) {
      if (status.isPermanentlyDenied) {
        setState(() => _cameraPermissionPermanentlyDenied = true);
        if (mounted) {
          unawaited(JitPermissionFlow.showSettingsDialog(context, message: l10n.capture_permissionDeniedText));
        }
      }
      return;
    }

    try {
      setState(() => _flashVisible = true);
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          setState(() => _flashVisible = false);
        }
      });
      
      final file = await controller.takePicture();
      setState(() => _capturedImagePath = file.path);
    } catch (e) {
      debugPrint('Take photo failed: $e');
    }
  }

  Future<void> _usePhoto() async {
    if (_capturedImagePath == null) {
      return;
    }
    setState(() => _isProcessing = true);
    try {
      final processedPath = await ImageProcessor.processAndSaveImage(_capturedImagePath!);
      
      final profile = ref.read(activeFarmerProfileProvider).valueOrNull;
      if (profile != null) {
        final artifact = CaptureArtifact(
          id: const Uuid().v4(),
          farmerProfileId: profile.id,
          type: CaptureType.photo,
          localFilePath: processedPath,
          createdAt: DateTime.now(),
        );
        await ref.read(captureRepositoryProvider).saveArtifact(artifact);
        
        // Go back to home after capture
        if (mounted) {
          context.go('/home');
        }
      }
    } catch (e) {
      debugPrint('Process photo failed: $e');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_permissionCheckDone) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    final l10n = AppLocalizations.of(context)!;

    // Part F: Dual-Denial Fallback
    if (_cameraPermissionPermanentlyDenied && _micPermissionPermanentlyDenied) {
      return Scaffold(
        appBar: AppBar(title: const Text('Capture Note')),
        body: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: TextNoteFallback(
                onSubmitted: () => context.go('/home'),
              ),
            ),
          ],
        ),
      );
    }
    
    if (_voiceMode) {
      return Scaffold(
        body: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: VoiceNoteOverlay(
                onCancel: () => setState(() => _voiceMode = false),
                onSubmitted: () => context.go('/home'),
              ),
            ),
          ],
        ),
      );
    }

    final cameraController = ref.watch(cameraControllerProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Base layer: Camera Preview or Review Image
                if (_capturedImagePath != null)
                  Image.network(
                    'file://$_capturedImagePath', // Mock for file loading in preview
                    fit: BoxFit.cover,
                  )
                else if (cameraController != null && cameraController.value.isInitialized)
                  CameraPreview(cameraController)
                else if (_cameraPermissionPermanentlyDenied)
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.videocam_off, size: 64, color: Colors.white54),
                        const SizedBox(height: HarvestSpacing.md),
                        const Text('Camera Access Denied', style: TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () => JitPermissionFlow.showSettingsDialog(context, message: l10n.capture_permissionDeniedText),
                          child: const Text('Open Settings'),
                        ),
                      ],
                    ),
                  )
                else
                  const Center(child: CircularProgressIndicator(color: Colors.white)),
                
                // Flash overlay
                AnimatedOpacity(
                  opacity: _flashVisible ? 1.0 : 0.0,
                  duration: MotionTokens.durationFor(context, MotionTokens.durationMicro),
                  child: Container(color: Colors.white),
                ),
                
                // Top Instruction Bar
                if (_capturedImagePath == null)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + HarvestSpacing.md,
                        bottom: HarvestSpacing.md,
                        left: HarvestSpacing.lg,
                        right: HarvestSpacing.lg,
                      ),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black54, Colors.transparent],
                        ),
                      ),
                      child: Text(
                        l10n.capture_instructionPhoto,
                        style: context.textTheme.titleMedium?.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                
                // Bottom Controls
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + HarvestSpacing.xl,
                      top: HarvestSpacing.xl,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black87, Colors.transparent],
                      ),
                    ),
                    child: _capturedImagePath != null ? _buildReviewControls(l10n) : _buildLiveControls(cameraController),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildReviewControls(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HarvestSpacing.lg),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => setState(() => _capturedImagePath = null),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
                padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md),
              ),
              child: Text(l10n.capture_retakeButton),
            ),
          ),
          const SizedBox(width: HarvestSpacing.lg),
          Expanded(
            child: ElevatedButton(
              onPressed: _isProcessing ? null : _usePhoto,
              style: ElevatedButton.styleFrom(
                backgroundColor: HarvestColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md),
              ),
              child: _isProcessing 
                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white))
                  : Text(l10n.capture_usePhotoButton),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLiveControls(CameraController? controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HarvestSpacing.xxl),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Voice Note Toggle
          Positioned(
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.mic, color: Colors.white, size: 32),
              onPressed: () => setState(() => _voiceMode = true),
            ),
          ),
          // Shutter Button
          _ShutterButton(
            onTap: () {
              if (controller != null && controller.value.isInitialized) {
                unawaited(_takePhoto(controller));
              }
            },
          ),
        ],
      ),
    );
  }
}

class _ShutterButton extends StatefulWidget {
  final VoidCallback onTap;
  const _ShutterButton({required this.onTap});

  @override
  State<_ShutterButton> createState() => _ShutterButtonState();
}

class _ShutterButtonState extends State<_ShutterButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        // We simulate HapticFeedback in Flutter but usually it's `HapticFeedback.mediumImpact()`
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: MotionTokens.durationFor(context, MotionTokens.durationMicro),
        curve: MotionTokens.curveStandard,
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: HarvestColors.accent, width: 4),
          ),
          child: Center(
            child: Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
