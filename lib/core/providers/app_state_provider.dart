import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/farmer_profile.dart';
import '../../data/repositories/farmer_profile_repository.dart';
import '../storage/hive_box_manager.dart';
import 'repositories_provider.dart';

enum OnboardingStep { 
  languageSelection, 
  identityChoice, 
  identityVerifying, 
  identityManualEntry, 
  consent, 
  complete 
}

class OnboardingStateNotifier extends StateNotifier<OnboardingStep?> {
  OnboardingStateNotifier() : super(null) {
    _loadState();
  }

  Future<void> _loadState() async {
    final stepStr = await HiveBoxManager().getSetting('onboardingStep');
    if (stepStr != null) {
      state = OnboardingStep.values.firstWhere(
        (e) => e.toString() == stepStr,
        orElse: () => OnboardingStep.complete,
      );
    } else {
      // Phase 2 legacy mapping fallback:
      final locale = await HiveBoxManager().getSetting('locale');
      if (locale != null) {
        state = OnboardingStep.identityChoice;
      }
    }
  }

  Future<void> _persistAndSet(OnboardingStep step) async {
    await HiveBoxManager().putSetting('onboardingStep', step.toString());
    state = step;
  }

  Future<void> advanceToIdentityChoice() async {
    if (state != null && state != OnboardingStep.languageSelection && state != OnboardingStep.complete) {
      throw StateError('Cannot advance to identityChoice from $state');
    }
    await _persistAndSet(OnboardingStep.identityChoice);
  }

  Future<void> advanceToIdentityVerifying() async {
    if (state != OnboardingStep.identityChoice && state != OnboardingStep.identityVerifying) {
      throw StateError('Cannot advance to identityVerifying from $state');
    }
    await _persistAndSet(OnboardingStep.identityVerifying);
  }

  Future<void> advanceToManualEntry() async {
    if (state != OnboardingStep.identityChoice && state != OnboardingStep.consent && state != OnboardingStep.identityVerifying) {
      throw StateError('Cannot advance to manualEntry from $state');
    }
    await _persistAndSet(OnboardingStep.identityManualEntry);
  }

  Future<void> advanceToConsent() async {
    if (state != OnboardingStep.identityChoice && state != OnboardingStep.identityVerifying && state != OnboardingStep.identityManualEntry) {
      throw StateError('Cannot advance to consent from $state');
    }
    await _persistAndSet(OnboardingStep.consent);
  }

  Future<void> advanceToComplete() async {
    if (state != OnboardingStep.consent && state != OnboardingStep.identityVerifying && state != OnboardingStep.identityManualEntry) {
      throw StateError('Cannot advance to complete from $state');
    }
    await _persistAndSet(OnboardingStep.complete);
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
      
      final activeId = await HiveBoxManager().getSetting('activeProfileId');
      
      if (activeId != null) {
        try {
          final profile = profiles.firstWhere((p) => p.id == activeId);
          state = AsyncValue.data(profile);
        } catch (_) {
          state = AsyncValue.data(profiles.first);
          await HiveBoxManager().putSetting('activeProfileId', profiles.first.id);
        }
      } else {
        state = AsyncValue.data(profiles.first);
        await HiveBoxManager().putSetting('activeProfileId', profiles.first.id);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> setActiveProfile(String id) async {
    await HiveBoxManager().putSetting('activeProfileId', id);
    await _init();
  }
}

final activeFarmerProfileProvider = StateNotifierProvider<ActiveFarmerProfileNotifier, AsyncValue<FarmerProfile?>>((ref) {
  final repo = ref.watch(farmerProfileRepositoryProvider);
  return ActiveFarmerProfileNotifier(repo);
});
