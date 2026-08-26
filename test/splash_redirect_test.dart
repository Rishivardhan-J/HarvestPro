import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/core/providers/app_state_provider.dart';
import 'package:harvestpro/core/router/splash_redirect.dart';

void main() {
  group('splashRedirectLogic', () {
    test('Fresh install (null state) redirects to language selection', () {
      expect(splashRedirectLogic(isSplashRoute: true, currentRoute: '/splash', onboardingStep: null, activeProfilesCount: 0), '/onboarding/language');
    });

    test('Incomplete onboarding (identity) redirects to identity', () {
      expect(splashRedirectLogic(isSplashRoute: true, currentRoute: '/splash', onboardingStep: OnboardingStep.identity, activeProfilesCount: 0), '/onboarding/identity');
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
  });
}
