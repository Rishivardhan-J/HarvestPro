import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:harvestpro/l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/localization/locale_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/design_showcase_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
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

class HarvestProApp extends ConsumerWidget {
  const HarvestProApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    // For the showcase, we could force one theme or let the system decide. 
    // The showcase screen renders both side-by-side using Theme wrappers anyway.
    return MaterialApp.router(
      title: 'HarvestPro',
      theme: AppTheme.getLightTheme(locale),
      darkTheme: AppTheme.getDarkTheme(locale),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
