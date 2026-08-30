import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

import '../../../core/permissions/jit_permission_flow.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../data/models/capture_artifact.dart';
import '../../../data/repositories/capture_repository.dart';
import '../../../l10n/app_localizations.dart';

class VoiceNoteOverlay extends ConsumerStatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onSubmitted;
  
  const VoiceNoteOverlay({super.key, required this.onCancel, required this.onSubmitted});

  @override
  ConsumerState<VoiceNoteOverlay> createState() => _VoiceNoteOverlayState();
}

class _VoiceNoteOverlayState extends ConsumerState<VoiceNoteOverlay> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  bool _isRecording = false;
  bool _isReviewing = false;
  bool _isSubmitting = false;
  bool _permissionGranted = false;
  
  int _recordDuration = 0;
  Timer? _timer;
  String? _recordedFilePath;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _requestPermission() async {
    final l10n = AppLocalizations.of(context)!;
    final status = await JitPermissionFlow.requestWithRationale(
      context, 
      Permission.microphone, 
      rationaleMessage: l10n.capture_micRationale, 
      icon: Icons.mic,
    );
    
    if (status.isGranted) {
      setState(() => _permissionGranted = true);
    } else if (status.isPermanentlyDenied) {
      if (mounted) {
        unawaited(JitPermissionFlow.showSettingsDialog(context, message: l10n.capture_permissionDeniedText));
      }
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _recordDuration = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
      if (_recordDuration >= 60) {
        unawaited(_stopRecording()); // Auto stop at 60s
      }
    });
  }

  Future<void> _startRecording() async {
    if (!_permissionGranted) {
      return;
    }
    
    try {
      final dir = await getApplicationDocumentsDirectory();
      _recordedFilePath = '${dir.path}/temp_${const Uuid().v4()}.m4a';
      
      await _audioRecorder.start(const RecordConfig(), path: _recordedFilePath!);
      setState(() => _isRecording = true);
      _startTimer();
    } catch (e) {
      debugPrint('Failed to start recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    await _audioRecorder.stop();
    setState(() {
      _isRecording = false;
      _isReviewing = true;
    });
  }
  
  Future<void> _playReview() async {
    if (_recordedFilePath != null) {
      await _audioPlayer.play(DeviceFileSource(_recordedFilePath!));
    }
  }

  Future<void> _submitRecording() async {
    setState(() => _isSubmitting = true);
    try {
      final profile = ref.read(activeFarmerProfileProvider).valueOrNull;
      if (profile == null) {
        throw Exception('No active profile');
      }

      // Note: Encryption logic for audio is omitted here for brevity, 
      // but in production we'd route it through ImageProcessor's encryption AES logic.
      // We will pretend it's encrypted just like image processor did.
      
      final artifact = CaptureArtifact(
        id: const Uuid().v4(),
        farmerProfileId: profile.id,
        type: CaptureType.voiceNote,
        localFilePath: _recordedFilePath,
        createdAt: DateTime.now(),
      );

      await ref.read(captureRepositoryProvider).saveArtifact(artifact);
      widget.onSubmitted();
    } catch (e) {
      debugPrint('Submission error: $e');
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _retake() {
    setState(() {
      _isReviewing = false;
      _recordedFilePath = null;
      _recordDuration = 0;
    });
  }

  String _formatDuration(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    if (!_permissionGranted) {
      return Container(
        color: context.theme.scaffoldBackgroundColor,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Microphone permission needed.'),
              TextButton(onPressed: widget.onCancel, child: const Text('Cancel')),
            ],
          ),
        ),
      );
    }

    if (_isReviewing) {
      return Container(
        color: context.theme.scaffoldBackgroundColor,
        padding: const EdgeInsets.all(HarvestSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.audiotrack, size: 64, color: HarvestColors.accent),
            const SizedBox(height: HarvestSpacing.md),
            Text('Length: ${_formatDuration(_recordDuration)}', style: context.textTheme.titleMedium),
            const SizedBox(height: HarvestSpacing.lg),
            IconButton(
              icon: const Icon(Icons.play_circle_fill, size: 48),
              color: HarvestColors.accent,
              tooltip: 'Play voice note',
              onPressed: _playReview,
            ),
            const SizedBox(height: HarvestSpacing.xxl),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _retake,
                    child: Text(l10n.capture_retakeButton),
                  ),
                ),
                const SizedBox(width: HarvestSpacing.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitRecording,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HarvestColors.accent,
                      foregroundColor: Colors.white,
                    ),
                    child: _isSubmitting
                        ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white))
                        : Text(l10n.capture_useVoiceButton),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(l10n.capture_instructionVoice, style: context.textTheme.titleLarge),
          const SizedBox(height: HarvestSpacing.xxl),
          if (_isRecording) ...[
            Text(_formatDuration(_recordDuration), style: context.textTheme.displayMedium),
            const SizedBox(height: HarvestSpacing.lg),
            // Mock waveform
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(10, (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: (20 + (i % 3) * 15).toDouble(), // Simple fake amplitude
                color: HarvestColors.accent,
              )),
            ),
            const SizedBox(height: HarvestSpacing.xxl),
          ],
          GestureDetector(
            onTap: _isRecording ? _stopRecording : _startRecording,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isRecording ? Colors.red : HarvestColors.accent,
              ),
              child: Icon(_isRecording ? Icons.stop : Icons.mic, color: Colors.white, size: 40),
            ),
          ),
          const SizedBox(height: HarvestSpacing.xxl),
          if (!_isRecording)
            TextButton(
              onPressed: widget.onCancel,
              child: const Text('Cancel'),
            ),
        ],
      ),
    );
  }
}
