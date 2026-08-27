import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harvestpro/l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

class LocaleNotifier extends StateNotifier<Locale> {
  static const _boxName = 'app_settings';
  static const _key = 'locale';
  Box? _box;

  LocaleNotifier() : super(const Locale('en')) {
    _init();
  }

  Future<void> _init() async {
    _box = await Hive.openBox(_boxName);
    final savedCode = _box!.get(_key) as String?;
    
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
    if (supportedLocales.contains(newLocale)) {
      state = newLocale;
      if (_box != null) {
        await _box!.put(_key, newLocale.languageCode);
      }
    }
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});
