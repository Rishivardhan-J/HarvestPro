import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cameraControllerProvider = StateNotifierProvider<CameraControllerNotifier, CameraController?>((ref) {
  return CameraControllerNotifier();
});

class CameraControllerNotifier extends StateNotifier<CameraController?> {
  CameraControllerNotifier() : super(null);

  bool _isInitializing = false;

  Future<void> preWarmCamera() async {
    if (state != null || _isInitializing) {
      return;
    }
    _isInitializing = true;
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        return;
      }
      
      final controller = CameraController(
        cameras.first, 
        ResolutionPreset.high,
        enableAudio: false, // We use a separate mic plugin
      );
      
      await controller.initialize();
      state = controller;
    } catch (e) {
      debugPrint('Camera init failed: $e');
    } finally {
      _isInitializing = false;
    }
  }

  void disposeCamera() {
    state?.dispose();
    state = null;
  }
}
