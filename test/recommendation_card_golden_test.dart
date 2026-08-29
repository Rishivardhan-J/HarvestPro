import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/core/theme/app_theme.dart';
import 'package:harvestpro/shared_widgets/action_card.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: AppTheme.getLightTheme(),
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }

  testWidgets('ActionCard handles extremely long text without collision', (WidgetTester tester) async {
    // We use a very long pseudo-localized string that forces wrapping
    const longHeadline = '[šÞřįñĝ] This is an artificially lengthened headline string designed to test multi-line wrapping and ensure it does not collide with the top right widget!';
    const longBody = '[šÞřįñĝ] This is an artificially lengthened description body string designed to test multi-line wrapping in the body of the recommendation card. It should truncate gracefully at 3 lines.';

    await tester.pumpWidget(
      buildTestWidget(
        ActionCard(
          icon: Icons.science,
          headline: longHeadline,
          body: longBody,
          topRightWidget: Chip(
            label: const Text('FERTILIZER'),
            backgroundColor: Colors.blue.withAlpha(25),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify layout structure
    final headlineFinder = find.text(longHeadline);
    expect(headlineFinder, findsOneWidget);

    // Get render boxes to ensure no overlap
    final headlineBox = tester.renderObject<RenderBox>(headlineFinder);
    final chipBox = tester.renderObject<RenderBox>(find.byType(Chip));

    final headlineRect = headlineBox.localToGlobal(Offset.zero) & headlineBox.size;
    final chipRect = chipBox.localToGlobal(Offset.zero) & chipBox.size;

    // The headline should be strictly below the chip's bottom (or at least, they should not intersect)
    // Actually, in our new layout, they don't even share the same vertical space.
    expect(headlineRect.overlaps(chipRect), isFalse, reason: 'Headline overlaps with the Chip!');
    
    // Ensure headline is below the chip
    expect(headlineRect.top >= chipRect.bottom, isTrue, reason: 'Headline is not below the Chip!');
  });
}
