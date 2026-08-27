import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/capture/screens/capture_screen.dart';
import '../../features/capture/screens/daily_checkin_screen.dart';
import '../../features/community/screens/community_screen.dart';
import '../../features/community/screens/post_detail_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/onboarding/screens/consent_screen.dart';
import '../../features/onboarding/screens/identity_choice_screen.dart';
import '../../features/onboarding/screens/identity_verifying_screen.dart';
import '../../features/onboarding/screens/language_selection_screen.dart';
import '../../features/onboarding/screens/manual_entry_screen.dart';
import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/recommendations/screens/recommendations_screen.dart';
import '../../features/settings/design_showcase_screen.dart';
import '../../features/settings/screens/data_screen.dart';
import '../../features/settings/screens/profiles_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../shared_widgets/app_bottom_nav.dart';
import '../../shared_widgets/fade_indexed_stack.dart';
import '../providers/app_state_provider.dart';
import '../providers/scroll_signal_provider.dart';
import '../theme/motion_tokens.dart';
import 'error_screen.dart';
import 'splash_redirect.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKeyHome = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final shellNavigatorKeyCapture = GlobalKey<NavigatorState>(debugLabel: 'shellCapture');
final shellNavigatorKeyRecs = GlobalKey<NavigatorState>(debugLabel: 'shellRecs');
final shellNavigatorKeyCommunity = GlobalKey<NavigatorState>(debugLabel: 'shellCommunity');

// Shared Axis Horizontal Transition for nested tab pushes
CustomTransitionPage<void> sharedAxisHorizontalPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: MotionTokens.durationFor(context, MotionTokens.durationStandard),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.horizontal,
        child: child,
      );
    },
  );
}

// Shared Axis Vertical Transition for full screen pushes (outside shell)
CustomTransitionPage<void> sharedAxisVerticalPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: MotionTokens.durationFor(context, MotionTokens.durationStandard),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.vertical,
        child: child,
      );
    },
  );
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final onboardingStep = ref.watch(onboardingStateProvider);
  final activeProfileAsync = ref.watch(activeFarmerProfileProvider);

  // Rebuild router when these states change so redirect re-evaluates
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
    redirect: (context, state) {
      // Don't redirect while profile is loading to prevent flash
      if (activeProfileAsync.isLoading) {
        return null;
      }
      
      final activeProfilesCount = activeProfileAsync.valueOrNull != null ? 1 : 0;
      final redirectPath = splashRedirectLogic(
        isSplashRoute: state.uri.path == '/splash',
        currentRoute: state.uri.path,
        onboardingStep: onboardingStep,
        activeProfilesCount: activeProfilesCount,
      );
      
      return redirectPath;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding/language',
        pageBuilder: (context, state) => sharedAxisVerticalPage(context, state, const LanguageSelectionScreen()),
      ),
      GoRoute(
        path: '/onboarding/identity-choice',
        pageBuilder: (context, state) => sharedAxisVerticalPage(context, state, const IdentityChoiceScreen()),
      ),
      GoRoute(
        path: '/onboarding/identity-verifying',
        pageBuilder: (context, state) => sharedAxisVerticalPage(context, state, const IdentityVerifyingScreen()),
      ),
      GoRoute(
        path: '/onboarding/consent',
        pageBuilder: (context, state) => sharedAxisVerticalPage(context, state, const ConsentScreen()),
      ),
      GoRoute(
        path: '/onboarding/manual-entry',
        pageBuilder: (context, state) => sharedAxisVerticalPage(context, state, const ManualEntryScreen()),
      ),
      GoRoute(
        path: '/settings',
        pageBuilder: (context, state) => sharedAxisVerticalPage(context, state, const SettingsScreen()),
        routes: [
          GoRoute(
            path: 'profiles',
            pageBuilder: (context, state) => sharedAxisVerticalPage(context, state, const ProfilesScreen()),
          ),
          GoRoute(
            path: 'data',
            pageBuilder: (context, state) => sharedAxisVerticalPage(context, state, const DataScreen()),
          ),
        ],
      ),
      GoRoute(
        path: '/debug/design-system',
        builder: (context, state) => const DesignShowcaseScreen(),
      ),
      StatefulShellRoute(
        builder: (context, state, navigationShell) {
          return ScaffoldWithBottomNav(navigationShell: navigationShell);
        },
        navigatorContainerBuilder: (context, navigationShell, children) {
          return FadeIndexedStack(
            index: navigationShell.currentIndex,
            duration: MotionTokens.durationFor(context, MotionTokens.durationMicro),
            children: children,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: shellNavigatorKeyHome,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorKeyCapture,
            routes: [
              GoRoute(
                path: '/capture',
                builder: (context, state) => const CaptureScreen(),
                routes: [
                  GoRoute(
                    path: 'daily-checkin',
                    pageBuilder: (context, state) => sharedAxisHorizontalPage(context, state, const DailyCheckinScreen()),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorKeyRecs,
            routes: [
              GoRoute(
                path: '/recommendations',
                builder: (context, state) => const RecommendationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorKeyCommunity,
            routes: [
              GoRoute(
                path: '/community',
                builder: (context, state) => const CommunityScreen(),
                routes: [
                  GoRoute(
                    path: 'post/:postId',
                    pageBuilder: (context, state) => sharedAxisHorizontalPage(context, state, PostDetailScreen(postId: state.pathParameters['postId']!)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class ScaffoldWithBottomNav extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithBottomNav({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNav(
        currentIndex: navigationShell.currentIndex,
        items: const [
          AppBottomNavItem(outlineIcon: Icons.home_outlined, filledIcon: Icons.home, label: 'Home'),
          AppBottomNavItem(outlineIcon: Icons.camera_alt_outlined, filledIcon: Icons.camera_alt, label: 'Capture'),
          AppBottomNavItem(outlineIcon: Icons.lightbulb_outline, filledIcon: Icons.lightbulb, label: 'Advisory', hasNotification: true), // Placeholder badge
          AppBottomNavItem(outlineIcon: Icons.people_outline, filledIcon: Icons.people, label: 'Community'),
        ],
        onItemSelected: (index) {
          HapticFeedback.selectionClick();
          if (index == navigationShell.currentIndex) {
            ref.read(scrollToTopSignalProvider(index).notifier).state = DateTime.now();
          } else {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          }
        },
      ),
    );
  }
}
