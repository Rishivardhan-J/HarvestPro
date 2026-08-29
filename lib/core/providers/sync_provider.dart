import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'connectivity_provider.dart';
import 'repositories_provider.dart';

final syncProvider = Provider<SyncManager>((ref) {
  final manager = SyncManager(ref);
  ref.listen<AppConnectivityState>(connectivityProvider, (previous, next) {
    if (previous == AppConnectivityState.offline && next == AppConnectivityState.online) {
      manager.triggerSync();
    }
  });
  return manager;
});

class SyncManager {
  final Ref ref;
  bool _isSyncing = false;

  SyncManager(this.ref);

  Future<void> triggerSync() async {
    if (_isSyncing) {
      return;
    }
    _isSyncing = true;

    try {
      // The capture_repository is read but currently not used since it's mock
      ref.read(captureRepositoryProvider);
      
      // Since we don't have a backend, we simulate the sync process.
      // We will read all artifacts directly.
      // However, the capture_repository doesn't expose getAllArtifacts directly across profiles,
      // but we can just use the mock delay.
      
      // In a real app we'd fetch pending items. For now we simulate delay.
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate success and show confirmation
      _showSyncConfirmation();
    } catch (e) {
      debugPrint('Sync failed: $e');
    } finally {
      _isSyncing = false;
    }
  }

  void _showSyncConfirmation() {
    // ScaffoldMessenger relies on a root context or a global key.
    // Instead of a global key, we can use a clever trick if we have the router.
    // But standard Flutter requires a GlobalKey<ScaffoldMessengerState> for this without context.
    
    // We will assume the root app has a scaffold messenger key if needed,
    // or we can dispatch it via a provider that the UI listens to.
    
    // For simplicity, we expose a state that UI can listen to.
    ref.read(syncConfirmationProvider.notifier).state = DateTime.now();
  }
}

// A simple provider to trigger the toast in the UI layer (e.g. from HomeScreen or a root wrapper)
final syncConfirmationProvider = StateProvider<DateTime?>((ref) => null);
