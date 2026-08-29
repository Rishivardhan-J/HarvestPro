import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harvestpro/l10n/app_localizations.dart';

import 'core/localization/locale_provider.dart';
import 'core/router/app_router.dart';
import 'core/storage/hive_box_manager.dart';
import 'core/theme/app_theme.dart';

Future<void> initHive() async {
  await HiveBoxManager().initBootstrapBoxes();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  
  runApp(
    const ProviderScope(
      child: HarvestProApp(),
    ),
  );
}

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
      routerConfig: ref.watch(appRouterProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}
