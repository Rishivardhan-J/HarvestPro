import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harvestpro/l10n/app_localizations.dart';
import '../storage/hive_box_manager.dart';

List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

class LocaleNotifier extends StateNotifier<Locale> {
  static const _key = 'locale';

  LocaleNotifier() : super(const Locale('en')) {
    _init();
  }

  Future<void> _init() async {
    final savedCode = await HiveBoxManager().getSetting(_key);
    
    if (savedCode != null) {
      final savedLocale = Locale(savedCode);
      if (supportedLocales.contains(savedLocale)) {
        state = savedLocale;
        return;
      }
    }
    
    // First launch detection
    final systemLocale = PlatformDispatcher.instance.locale;
    final supportedCodes = supportedLocales.map((l) => l.languageCode);
    if (supportedCodes.contains(systemLocale.languageCode)) {
      state = Locale(systemLocale.languageCode);
    } else {
      state = const Locale('en');
    }
  }

  Future<void> setLocale(Locale newLocale) async {
    previewLocale(newLocale);
    await persistLocale();
  }

  void previewLocale(Locale newLocale) {
    if (supportedLocales.contains(newLocale)) {
      state = newLocale;
    }
  }

  Future<void> persistLocale() async {
    await HiveBoxManager().putSetting(_key, state.languageCode);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});
