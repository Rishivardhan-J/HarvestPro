import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:harvestpro/l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/localization/locale_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  
  const secureStorage = FlutterSecureStorage();
  final containsEncryptionKey = await secureStorage.containsKey(key: 'hive_key');
  if (!containsEncryptionKey) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(key: 'hive_key', value: base64UrlEncode(key));
  }
  final key = await secureStorage.read(key: 'hive_key');
  final encryptionKeyUint8List = base64Url.decode(key!);
  
  await Hive.openBox('app_settings', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
  await Hive.openBox('profiles', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
  await Hive.openBox('yield_predictions', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
  await Hive.openBox('recommendations', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
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
