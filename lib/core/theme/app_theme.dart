import 'package:flutter/material.dart';
import 'design_tokens.dart';
import 'typography.dart';

/// AppTheme builds the light and dark ThemeData using exact tokens.
class AppTheme {
  static ThemeData getLightTheme([Locale? locale]) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: HarvestColors.bgLight,
      canvasColor: HarvestColors.surfaceLight,
      colorScheme: const ColorScheme.light(
        surface: HarvestColors.surfaceLight,
        primary: HarvestColors.accent,
        onSurface: HarvestColors.inkLight,
      ),
      textTheme: HarvestTypography.createTextTheme(HarvestColors.inkLight, locale),
      dividerColor: HarvestColors.divider(Brightness.light),
    );
  }

  static ThemeData getDarkTheme([Locale? locale]) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: HarvestColors.bgDark,
      canvasColor: HarvestColors.surfaceDark,
      colorScheme: const ColorScheme.dark(
        surface: HarvestColors.surfaceDark,
        primary: HarvestColors.accent,
        onSurface: HarvestColors.inkDark,
      ),
      textTheme: HarvestTypography.createTextTheme(HarvestColors.inkDark, locale),
      dividerColor: HarvestColors.divider(Brightness.dark),
    );
  }
}

/// Extension for convenient access to theme tokens without lookup guessing
extension HarvestThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  Brightness get brightness => theme.brightness;
  
  // Quick token accessors
  Color get surfaceAlt => HarvestColors.surfaceAlt(brightness);
  Color get dividerColor => HarvestColors.divider(brightness);
}
