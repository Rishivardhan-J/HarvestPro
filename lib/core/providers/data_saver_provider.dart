import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/hive_box_manager.dart';

class DataSaverNotifier extends StateNotifier<bool> {
  DataSaverNotifier() : super(false) {
    _init();
  }

  Future<void> _init() async {
    final enabled = await HiveBoxManager().getSetting('dataSaverEnabled');
    if (enabled != null) {
      state = enabled as bool;
    } else {
      state = false; // Default to false
    }
  }

  Future<void> toggle() async {
    await HiveBoxManager().putSetting('dataSaverEnabled', !state);
    state = !state;
  }
}

final dataSaverEnabledProvider = StateNotifierProvider<DataSaverNotifier, bool>((ref) {
  return DataSaverNotifier();
});
