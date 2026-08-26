import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/design_showcase_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: HarvestProApp(),
    ),
  );
}

final _router = GoRouter(
  initialLocation: '/debug/design-system',
  routes: [
    GoRoute(
      path: '/debug/design-system',
      builder: (context, state) => const DesignShowcaseScreen(),
    ),
  ],
);

class HarvestProApp extends StatelessWidget {
  const HarvestProApp({super.key});

  @override
  Widget build(BuildContext context) {
    // For the showcase, we could force one theme or let the system decide. 
    // The showcase screen renders both side-by-side using Theme wrappers anyway.
    return MaterialApp.router(
      title: 'HarvestPro',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
