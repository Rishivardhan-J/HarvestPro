import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppConnectivityState { online, offline }

class ConnectivityNotifier extends StateNotifier<AppConnectivityState> {
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _debounceTimer;
  
  ConnectivityNotifier(this._connectivity) : super(AppConnectivityState.online) {
    _init();
  }
  
  Future<void> _init() async {
    final results = await _connectivity.checkConnectivity();
    _handleConnectivityChange(results);
    
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(seconds: 2), () {
        _handleConnectivityChange(results);
      });
    });
  }
  
  void _handleConnectivityChange(List<ConnectivityResult> results) {
    final isOffline = results.contains(ConnectivityResult.none) || results.isEmpty;
    final newState = isOffline ? AppConnectivityState.offline : AppConnectivityState.online;
    
    if (state != newState) {
      state = newState;
    }
  }
  
  @override
  void dispose() {
    _subscription?.cancel();
    _debounceTimer?.cancel();
    super.dispose();
  }
}

final connectivityProvider = StateNotifierProvider<ConnectivityNotifier, AppConnectivityState>((ref) {
  return ConnectivityNotifier(Connectivity());
});
