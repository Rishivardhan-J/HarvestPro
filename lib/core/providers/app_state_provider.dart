import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/farmer_profile.dart';
import '../../data/repositories/farmer_profile_repository.dart';
import 'repositories_provider.dart';

enum OnboardingStep { language, identity, consent, manualEntry, complete }

class OnboardingStateNotifier extends StateNotifier<OnboardingStep?> {
  OnboardingStateNotifier() : super(null) {
    _loadState();
  }

  void _loadState() {
    final box = Hive.box('app_settings');
    final stepStr = box.get('onboardingStep');
    if (stepStr != null) {
      state = OnboardingStep.values.firstWhere(
        (e) => e.toString() == stepStr,
        orElse: () => OnboardingStep.complete,
      );
    } else {
      // Phase 2 legacy mapping: if locale is set but no step recorded
      final locale = box.get('locale');
      if (locale != null) {
        state = OnboardingStep.identity;
      }
    }
  }

  Future<void> setStep(OnboardingStep step) async {
    final box = Hive.box('app_settings');
    await box.put('onboardingStep', step.toString());
    state = step;
  }
}

final onboardingStateProvider = StateNotifierProvider<OnboardingStateNotifier, OnboardingStep?>((ref) {
  return OnboardingStateNotifier();
});

class ActiveFarmerProfileNotifier extends StateNotifier<AsyncValue<FarmerProfile?>> {
  final FarmerProfileRepository _repository;
  
  ActiveFarmerProfileNotifier(this._repository) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    try {
      final profiles = await _repository.getAllProfiles();
      if (profiles.isEmpty) {
        state = const AsyncValue.data(null);
        return;
      }
      
      final box = Hive.box('app_settings');
      final activeId = box.get('activeProfileId');
      
      if (activeId != null) {
        try {
          final profile = profiles.firstWhere((p) => p.id == activeId);
          state = AsyncValue.data(profile);
        } catch (_) {
          state = AsyncValue.data(profiles.first);
          await box.put('activeProfileId', profiles.first.id);
        }
      } else {
        state = AsyncValue.data(profiles.first);
        await box.put('activeProfileId', profiles.first.id);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> setActiveProfile(String id) async {
    final box = Hive.box('app_settings');
    await box.put('activeProfileId', id);
    await _init();
  }
}

final activeFarmerProfileProvider = StateNotifierProvider<ActiveFarmerProfileNotifier, AsyncValue<FarmerProfile?>>((ref) {
  final repo = ref.watch(farmerProfileRepositoryProvider);
  return ActiveFarmerProfileNotifier(repo);
});
