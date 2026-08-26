import 'package:flutter/material.dart';

/// HARVESTPRO TYPOGRAPHY
/// Exact text styles enforcing Section 4.3 of the blueprint.
///
/// Families:
/// - Baloo (Display, H2)
/// - Mukta (Body, Caption)

abstract class HarvestTypography {
  static const String _baloo = 'Baloo';
  static const String _mukta = 'Mukta';

  /// Display: 32sp / line-height 40sp (1.25x) / weight 700 / Baloo
  static const TextStyle display = TextStyle(
    fontFamily: _baloo,
    fontSize: 32.0,
    height: 1.25, // 40 / 32
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
  );

  /// Display-small: 28sp / line-height 36sp (1.28x) / weight 700 / Baloo
  static const TextStyle displaySmall = TextStyle(
    fontFamily: _baloo,
    fontSize: 28.0,
    height: 1.2857, // 36 / 28
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
  );

  /// H2: 20sp / line-height 28sp (1.4x) / weight 600 / Baloo
  static const TextStyle h2 = TextStyle(
    fontFamily: _baloo,
    fontSize: 20.0,
    height: 1.4, // 28 / 20
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
  );

  /// H2-small: 18sp / line-height 26sp (1.44x) / weight 600 / Baloo
  static const TextStyle h2Small = TextStyle(
    fontFamily: _baloo,
    fontSize: 18.0,
    height: 1.4444, // 26 / 18
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
  );

  /// Body: 15sp / line-height 22sp (1.47x) / weight 400 / Mukta
  static const TextStyle body = TextStyle(
    fontFamily: _mukta,
    fontSize: 15.0,
    height: 1.4667, // 22 / 15
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1, // Aids low-literacy reading
  );

  /// Body-small: 14sp / line-height 21sp (1.5x) / weight 400 / Mukta
  static const TextStyle bodySmall = TextStyle(
    fontFamily: _mukta,
    fontSize: 14.0,
    height: 1.5, // 21 / 14
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
  );

  /// Caption: 12sp / line-height 16sp (1.33x) / weight 500 / Mukta
  static const TextStyle caption = TextStyle(
    fontFamily: _mukta,
    fontSize: 12.0,
    height: 1.3333, // 16 / 12
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2, // Small text needs more breathing room
  );

  /// Caption-small: 11sp / line-height 14sp (1.27x) / weight 500 / Mukta
  static const TextStyle captionSmall = TextStyle(
    fontFamily: _mukta,
    fontSize: 11.0,
    height: 1.2727, // 14 / 11
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  /// Generates the standard TextTheme colored correctly for light/dark
  static TextTheme createTextTheme(Color ink) {
    return TextTheme(
      displayLarge: display.copyWith(color: ink),
      displayMedium: displaySmall.copyWith(color: ink),
      headlineLarge: h2.copyWith(color: ink),
      headlineMedium: h2Small.copyWith(color: ink),
      bodyLarge: body.copyWith(color: ink),
      bodyMedium: bodySmall.copyWith(color: ink),
      labelLarge: caption.copyWith(color: ink),
      labelSmall: captionSmall.copyWith(color: ink),
    );
  }
}
