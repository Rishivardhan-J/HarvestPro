import 'package:flutter/material.dart';

/// HARVESTPRO DESIGN SYSTEM
/// The single source of truth for all spacing, radius, elevation, and color tokens.

// -----------------------------------------------------------------------------
// TYPE-SAFE COLOR SEPARATION (Gap 1 enforcement)
// -----------------------------------------------------------------------------

/// Represents interactive elements (buttons, links, active nav)
sealed class InteractiveColor {
  const InteractiveColor();
  static const InteractiveColor accent = InteractiveAccent();
}
class InteractiveAccent extends InteractiveColor { const InteractiveAccent(); }

/// Represents health/status (gauge, badge, chip background)
sealed class StatusColor {
  const StatusColor();
  static const StatusColor good = StatusGood();
  static const StatusColor caution = StatusCaution();
  static const StatusColor critical = StatusCritical();
}
class StatusGood extends StatusColor { const StatusGood(); }
class StatusCaution extends StatusColor { const StatusCaution(); }
class StatusCritical extends StatusColor { const StatusCritical(); }

// -----------------------------------------------------------------------------
// SPACING SCALE (4dp base unit)
// -----------------------------------------------------------------------------
abstract class HarvestSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 48.0;
}

// -----------------------------------------------------------------------------
// RADIUS SCALE
// -----------------------------------------------------------------------------
abstract class HarvestRadius {
  static const BorderRadius sm = BorderRadius.all(Radius.circular(8.0));
  static const BorderRadius md = BorderRadius.all(Radius.circular(16.0));
  static const BorderRadius lg = BorderRadius.all(Radius.circular(24.0));
  static const BorderRadius full = BorderRadius.all(Radius.circular(999.0));
}

// -----------------------------------------------------------------------------
// COLORS (Exact Hex Values)
// -----------------------------------------------------------------------------
abstract class HarvestColors {
  // Light Mode Tokens
  static const Color bgLight = Color(0xFFF6F2E8);
  static const Color surfaceLight = Color(0xFFDCE6E4);
  static const Color inkLight = Color(0xFF1D2624);
  static const Color inkSoftLight = Color(0xFF54615D);

  // Dark Mode Tokens
  static const Color bgDark = Color(0xFF171C1A);
  static const Color surfaceDark = Color(0xFF233633);
  static const Color inkDark = Color(0xFFF1EFE6);
  static const Color inkSoftDark = Color(0xFFAEBAB5);

  // Shared Tokens
  static const Color accent = Color(0xFFE4A430);
  static const Color statusGood = Color(0xFF5B8C3E);
  static const Color statusCaution = Color(0xFFB8631F);
  static const Color statusCritical = Color(0xFFC1442E);

  // Derived Tokens
  static const Color overlayScrim = Color(0x66000000); // #000000 at 40%

  /// Returns ink-soft at 16% opacity based on current brightness
  static Color divider(Brightness brightness) {
    final color = brightness == Brightness.light ? inkSoftLight : inkSoftDark;
    return color.withAlpha((255 * 0.16).round());
  }

  /// Blends bg toward surface by 8%
  static Color surfaceAlt(Brightness brightness) {
    final bg = brightness == Brightness.light ? bgLight : bgDark;
    final surface = brightness == Brightness.light ? surfaceLight : surfaceDark;
    return Color.lerp(bg, surface, 0.08)!;
  }

  /// Helper to get the actual Color from a StatusColor
  static Color resolveStatusColor(StatusColor status) {
    return switch (status) {
      StatusGood() => statusGood,
      StatusCaution() => statusCaution,
      StatusCritical() => statusCritical,
    };
  }

  /// Helper to get the actual Color from an InteractiveColor
  static Color resolveInteractiveColor(InteractiveColor interactive) {
    return switch (interactive) {
      InteractiveAccent() => accent,
    };
  }

  /// Returns status color at 12% opacity over `surface`
  static Color statusBg(StatusColor status, Brightness brightness) {
    final baseColor = resolveStatusColor(status);
    final surface = brightness == Brightness.light ? surfaceLight : surfaceDark;
    final transparentColor = baseColor.withAlpha((255 * 0.12).round());
    return Color.alphaBlend(transparentColor, surface);
  }
}

// -----------------------------------------------------------------------------
// ELEVATION
// -----------------------------------------------------------------------------
abstract class HarvestElevation {
  static const List<BoxShadow> level0 = [];

  static List<BoxShadow> level1(Brightness brightness) {
    final ink = brightness == Brightness.light ? HarvestColors.inkLight : HarvestColors.inkDark;
    return [
      BoxShadow(
        color: ink.withAlpha((255 * 0.08).round()),
        offset: const Offset(0, 2),
        blurRadius: 8.0,
      )
    ];
  }

  static List<BoxShadow> level2(Brightness brightness) {
    final ink = brightness == Brightness.light ? HarvestColors.inkLight : HarvestColors.inkDark;
    return [
      BoxShadow(
        color: ink.withAlpha((255 * 0.12).round()),
        offset: const Offset(0, 4),
        blurRadius: 16.0,
      )
    ];
  }
}
