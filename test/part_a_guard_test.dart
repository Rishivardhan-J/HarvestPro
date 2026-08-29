import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/core/providers/app_state_provider.dart';
import 'package:harvestpro/core/router/splash_redirect.dart';

void main() {
  test('Part A: splashRedirectLogic in isolation', () {
    // 1. Fresh install
    expect(
      splashRedirectLogic(isSplashRoute: true, currentRoute: '/splash', onboardingStep: null, activeProfilesCount: 0),
      '/onboarding/language',
    );
    
    // 2. Incomplete onboarding steps
    final Map<OnboardingStep, String> expectedRoutes = {
      OnboardingStep.languageSelection: '/onboarding/language',
      OnboardingStep.identityChoice: '/onboarding/identity-choice',
      OnboardingStep.identityVerifying: '/onboarding/identity-verifying',
      OnboardingStep.consent: '/onboarding/consent',
      OnboardingStep.identityManualEntry: '/onboarding/manual-entry',
    };
    
    for (final entry in expectedRoutes.entries) {
      expect(
        splashRedirectLogic(
          isSplashRoute: true,
          currentRoute: '/splash',
          onboardingStep: entry.key,
          activeProfilesCount: 0,
        ),
        entry.value,
        reason: 'Failed for step ${entry.key}',
      );
    }
    
    // 3. Onboarding complete with profile
    expect(
      splashRedirectLogic(
        isSplashRoute: true,
        currentRoute: '/splash',
        onboardingStep: OnboardingStep.complete,
        activeProfilesCount: 1,
      ),
      '/home',
    );
    
    // 4. Onboarding complete WITHOUT profile (Broken state)
    expect(
      splashRedirectLogic(
        isSplashRoute: true,
        currentRoute: '/splash',
        onboardingStep: OnboardingStep.complete,
        activeProfilesCount: 0,
      ),
      '/onboarding/language',
    );

    debugPrint('Part A completed successfully: splashRedirectLogic is correct for all states.');
  });
}
