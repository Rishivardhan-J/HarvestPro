import '../providers/app_state_provider.dart';

/// Pure unit-testable redirect logic.
/// Returns the route string to redirect to, or null if no redirect is needed.
String? splashRedirectLogic({
  required bool isSplashRoute,
  required String currentRoute,
  required OnboardingStep? onboardingStep,
  required int activeProfilesCount,
}) {
  if (onboardingStep == null) {
    // 1. Fresh install
    return currentRoute == '/onboarding/language' ? null : '/onboarding/language';
  } else {
    // 2. Incomplete onboarding or Complete
    String target;
    switch (onboardingStep) {
      case OnboardingStep.languageSelection:
        target = '/onboarding/language';
        break;
      case OnboardingStep.identityChoice:
        target = '/onboarding/identity-choice';
        break;
      case OnboardingStep.identityVerifying:
        target = '/onboarding/identity-verifying';
        break;
      case OnboardingStep.consent:
        target = '/onboarding/consent';
        break;
      case OnboardingStep.identityManualEntry:
        target = '/onboarding/manual-entry';
        break;
      case OnboardingStep.complete:
        // 3 & 4. Onboarding complete
        if (activeProfilesCount == 0) {
          // 4. Broken state (zero profiles)
          // We log this in a real scenario
          target = '/onboarding/language';
        } else {
          // 3. Normal start
          if (isSplashRoute || currentRoute.startsWith('/onboarding')) {
            target = '/home'; // Redirect to home if they land on splash or try to go to onboarding
          } else {
            return null;
          }
        }
        break;
    }
    return currentRoute == target ? null : target;
  }
}
