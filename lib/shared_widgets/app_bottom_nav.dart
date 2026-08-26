import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/design_tokens.dart';

class AppBottomNavItem {
  final IconData outlineIcon;
  final IconData filledIcon;
  final String label;

  const AppBottomNavItem({
    required this.outlineIcon,
    required this.filledIcon,
    required this.label,
  });
}

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;
  final List<AppBottomNavItem> items;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
    required this.items,
  }) : assert(items.length == 4, 'AppBottomNav requires exactly 4 slots');

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    
    return Container(
      height: 64.0 + bottomInset,
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: BoxDecoration(
        color: context.theme.canvasColor, // surface
        border: Border(
          top: BorderSide(color: context.dividerColor),
        ),
        boxShadow: HarvestElevation.level1(context.brightness),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isActive = index == currentIndex;
          
          final color = isActive 
              ? HarvestColors.resolveInteractiveColor(const InteractiveAccent())
              : (context.brightness == Brightness.light ? HarvestColors.inkSoftLight : HarvestColors.inkSoftDark);
              
          final textStyle = context.textTheme.labelSmall?.copyWith(
            color: color,
          );

          return Expanded(
            child: InkWell(
              onTap: () => onItemSelected(index),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isActive ? item.filledIcon : item.outlineIcon,
                        size: 24.0,
                        color: color,
                      ),
                      const SizedBox(height: 2.0),
                      Text(item.label, style: textStyle),
                    ],
                  ),
                  // Active indicator dot
                  if (isActive)
                    Positioned(
                      top: 4.0, // 4dp above icon (approx, tweaking position to look right relative to 64dp height)
                      child: Container(
                        width: 4.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: HarvestColors.resolveInteractiveColor(const InteractiveAccent()),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
