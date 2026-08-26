# HarvestPro Theme & Design Tokens

This package contains the single source of truth for HarvestPro's design system, including exact color values, spacing (4dp scale), typography (Baloo/Mukta), and elevations.

## Gap 1 Enforcement: Accent vs Status Colors

A critical architectural rule derived from the product blueprint is the strict type-safe separation of **Interactive Colors** and **Status Colors**.

- **Interactive Colors** (e.g., `InteractiveColor.accent`): Used exclusively for tappable/interactive affordances such as buttons, links, and active navigation states.
- **Status Colors** (e.g., `StatusColor.good`, `StatusColor.caution`, `StatusColor.critical`): Used exclusively to indicate health or status (such as the YieldGauge, StatusBadge, or ReasonChip backgrounds).

**Rule:** You cannot pass an interactive color into a status parameter or vice-versa. 

We enforce this at compile time using Dart 3 sealed classes:
```dart
sealed class InteractiveColor { ... }
sealed class StatusColor { ... }
```
If a widget expects a `StatusColor` to render health feedback, attempting to pass `InteractiveColor.accent` will result in a compile error. This prevents developers from accidentally diluting the primary meaning of status colors.
