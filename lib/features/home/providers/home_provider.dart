import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/providers/repositories_provider.dart';
import '../../../core/storage/hive_box_manager.dart';
import '../../../data/models/yield_prediction.dart';
import '../../../data/repositories/mock_yield_repository.dart';

// Debug Scenario: 0=Random, 1=Good, 2=Caution, 3=Critical
final debugScenarioProvider = StateProvider<int>((ref) => 0);

final voiceNarrationEnabledProvider = StateNotifierProvider<VoiceNarrationNotifier, bool>((ref) {
  return VoiceNarrationNotifier();
});

class VoiceNarrationNotifier extends StateNotifier<bool> {
  VoiceNarrationNotifier() : super(true) {
    _init();
  }

  Future<void> _init() async {
    final enabled = await HiveBoxManager().getSetting('voiceNarrationEnabled');
    if (enabled != null) {
      state = enabled as bool;
    } else {
      state = true;
    }
  }

  Future<void> toggle() async {
    await HiveBoxManager().putSetting('voiceNarrationEnabled', !state);
    state = !state;
  }
}

final homeYieldPredictionProvider = FutureProvider<YieldPrediction?>((ref) async {
  final activeProfile = ref.watch(activeFarmerProfileProvider);
  final profile = activeProfile.value;
  if (profile == null) {
    return null;
  }

  final repository = ref.watch(yieldRepositoryProvider);
  final scenario = ref.watch(debugScenarioProvider);
  
  if (repository is MockYieldRepository) {
    repository.debugScenario = scenario;
  }

  return repository.getLatest(profile.id);
});
