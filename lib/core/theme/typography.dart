import 'package:flutter/material.dart';

/// HARVESTPRO TYPOGRAPHY
/// Exact text styles enforcing Section 4.3 of the blueprint.
///
/// Families:
/// - Baloo (Display, H2)
/// - Mukta (Body, Caption)
/// Includes regional overrides per Phase 2.

abstract class HarvestTypography {
  static const String _defaultBaloo = 'Baloo';
  static const String _defaultMukta = 'Mukta';

  static String _getDisplayFamily(Locale? locale) {
    switch (locale?.languageCode) {
      case 'pa': return 'Baloo Paaji 2';
      case 'ta': return 'Baloo Thambi 2';
      case 'te': return 'Baloo Tammudu 2';
      default: return _defaultBaloo;
    }
  }

  static String _getBodyFamily(Locale? locale) {
    switch (locale?.languageCode) {
      case 'pa': return 'Mukta Mahee';
      case 'ta': return 'Mukta Malar';
      case 'te': return 'Noto Sans Telugu';
      default: return _defaultMukta;
    }
  }

  static double _getLineHeightMultiplier(Locale? locale) {
    if (locale?.languageCode == 'ta' || locale?.languageCode == 'te') {
      return 1.10; // +10%
    }
    return 1.0;
  }

  static TextStyle display(Locale? locale) => TextStyle(
    fontFamily: _getDisplayFamily(locale),
    fontSize: 32.0,
    height: 1.25 * _getLineHeightMultiplier(locale),
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
  );

  static TextStyle displaySmall(Locale? locale) => TextStyle(
    fontFamily: _getDisplayFamily(locale),
    fontSize: 28.0,
    height: 1.2857 * _getLineHeightMultiplier(locale),
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
  );

  static TextStyle h2(Locale? locale) => TextStyle(
    fontFamily: _getDisplayFamily(locale),
    fontSize: 20.0,
    height: 1.4 * _getLineHeightMultiplier(locale),
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
  );

  static TextStyle h2Small(Locale? locale) => TextStyle(
    fontFamily: _getDisplayFamily(locale),
    fontSize: 18.0,
    height: 1.4444 * _getLineHeightMultiplier(locale),
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
  );

  static TextStyle body(Locale? locale) => TextStyle(
    fontFamily: _getBodyFamily(locale),
    fontSize: 15.0,
    height: 1.4667 * _getLineHeightMultiplier(locale),
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
  );

  static TextStyle bodySmall(Locale? locale) => TextStyle(
    fontFamily: _getBodyFamily(locale),
    fontSize: 14.0,
    height: 1.5 * _getLineHeightMultiplier(locale),
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
  );

  static TextStyle caption(Locale? locale) => TextStyle(
    fontFamily: _getBodyFamily(locale),
    fontSize: 12.0,
    height: 1.3333 * _getLineHeightMultiplier(locale),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  static TextStyle captionSmall(Locale? locale) => TextStyle(
    fontFamily: _getBodyFamily(locale),
    fontSize: 11.0,
    height: 1.2727 * _getLineHeightMultiplier(locale),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  /// Generates the standard TextTheme colored correctly for light/dark
  static TextTheme createTextTheme(Color ink, [Locale? locale]) {
    return TextTheme(
      displayLarge: display(locale).copyWith(color: ink),
      displayMedium: displaySmall(locale).copyWith(color: ink),
      headlineLarge: h2(locale).copyWith(color: ink),
      headlineMedium: h2Small(locale).copyWith(color: ink),
      bodyLarge: body(locale).copyWith(color: ink),
      bodyMedium: bodySmall(locale).copyWith(color: ink),
      labelLarge: caption(locale).copyWith(color: ink),
      labelSmall: captionSmall(locale).copyWith(color: ink),
    );
  }
}
