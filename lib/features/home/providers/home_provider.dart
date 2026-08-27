import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/providers/repositories_provider.dart';
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

  void _init() {
    final box = Hive.box('app_settings');
    final enabled = box.get('voiceNarrationEnabled', defaultValue: true);
    state = enabled as bool;
  }

  Future<void> toggle() async {
    final box = Hive.box('app_settings');
    await box.put('voiceNarrationEnabled', !state);
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
