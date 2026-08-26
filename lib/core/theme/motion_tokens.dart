import 'package:flutter/material.dart';

class MotionTokens {
  static const Duration durationMicro = Duration(milliseconds: 150);
  static const Duration durationStandard = Duration(milliseconds: 250);
  static const Duration durationEmphasis = Duration(milliseconds: 500);
  static const Duration durationHero = Duration(milliseconds: 900);

  static const Curve curveStandard = Curves.easeOutCubic;
  static const Curve curveExit = Curves.easeInCubic;
  static const Curve curveEmphasis = Curves.easeInOutCubic;

  /// Returns Duration.zero if the platform reduce-motion accessibility setting is active.
  static Duration durationFor(BuildContext context, Duration base) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return Duration.zero;
    }
    return base;
  }
}
