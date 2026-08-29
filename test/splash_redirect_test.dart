import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/core/providers/app_state_provider.dart';
import 'package:harvestpro/core/router/splash_redirect.dart';

void main() {
  group('splashRedirectLogic', () {
    test('Fresh install (null state) redirects to language selection', () {
      expect(splashRedirectLogic(isSplashRoute: true, currentRoute: '/splash', onboardingStep: null, activeProfilesCount: 0), '/onboarding/language');
    });

    test('Incomplete onboarding (identity) redirects to identity', () {
      final target = splashRedirectLogic(isSplashRoute: true, currentRoute: '/splash', onboardingStep: OnboardingStep.identityChoice, activeProfilesCount: 0);
      expect(target, '/onboarding/identity-choice');
    });

    test('Complete onboarding but 0 profiles redirects to language (broken state repair)', () {
      expect(splashRedirectLogic(isSplashRoute: true, currentRoute: '/splash', onboardingStep: OnboardingStep.complete, activeProfilesCount: 0), '/onboarding/language');
    });

    test('Complete onboarding with profiles redirects to home', () {
      expect(splashRedirectLogic(isSplashRoute: true, currentRoute: '/splash', onboardingStep: OnboardingStep.complete, activeProfilesCount: 1), '/home');
    });

    test('Complete onboarding trying to access onboarding redirects to home', () {
      expect(splashRedirectLogic(isSplashRoute: false, currentRoute: '/onboarding/language', onboardingStep: OnboardingStep.complete, activeProfilesCount: 1), '/home');
    });

    test('No redirect needed if already on the correct route', () {
      expect(splashRedirectLogic(isSplashRoute: false, currentRoute: '/home', onboardingStep: OnboardingStep.complete, activeProfilesCount: 1), null);
    });

    test('Exhaustive test over all OnboardingStep values', () {
      final expectedRoutes = {
        OnboardingStep.languageSelection: '/onboarding/language',
        OnboardingStep.identityChoice: '/onboarding/identity-choice',
        OnboardingStep.identityVerifying: '/onboarding/identity-verifying',
        OnboardingStep.consent: '/onboarding/consent',
        OnboardingStep.identityManualEntry: '/onboarding/manual-entry',
        OnboardingStep.complete: '/home', // With active profiles
      };

      for (final step in OnboardingStep.values) {
        final target = splashRedirectLogic(
          isSplashRoute: true,
          currentRoute: '/splash',
          onboardingStep: step,
          activeProfilesCount: 1, // Assumes a healthy profile state
        );
        expect(target, expectedRoutes[step], reason: 'Failed for $step');
      }
    });
  });
}
