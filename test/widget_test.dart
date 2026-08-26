import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/core/theme/design_tokens.dart';
import 'package:harvestpro/shared_widgets/reason_chip.dart';
import 'package:harvestpro/shared_widgets/status_badge.dart';
import 'package:harvestpro/shared_widgets/yield_gauge.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: child),
      ),
    );
  }

  group('ReasonChip Tests', () {
    testWidgets('Renders label, icon, and has 48dp min tap target', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        ReasonChip(
          label: 'Test Chip',
          contribution: 0.5, // positive -> Good status
          onTap: () {},
        ),
      ));

      // Verify label
      expect(find.text('Test Chip'), findsOneWidget);
      
      // Verify icon presence (trending_up for positive)
      expect(find.byIcon(Icons.trending_up), findsOneWidget);

      // Verify tap target minimum 48dp
      final gestureDetector = find.byType(GestureDetector);
      expect(gestureDetector, findsOneWidget);
      final size = tester.getSize(gestureDetector);
      expect(size.height, greaterThanOrEqualTo(48.0));
    });

    testWidgets('Negative contribution renders critical down icon', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        ReasonChip(
          label: 'Bad',
          contribution: -0.5,
          onTap: () {},
        ),
      ));

      expect(find.byIcon(Icons.trending_down), findsOneWidget);
    });
  });

  group('StatusBadge Tests', () {
    testWidgets('Renders correct icon and label for Good', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        const StatusBadge(status: StatusGood(), label: 'Good'),
      ));

      expect(find.text('Good'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    });

    testWidgets('Renders correct icon and label for Caution', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        const StatusBadge(status: StatusCaution(), label: 'Caution'),
      ));

      expect(find.text('Caution'), findsOneWidget);
      expect(find.byIcon(Icons.warning_amber_outlined), findsOneWidget);
    });

    testWidgets('Renders correct icon and label for Critical', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        const StatusBadge(status: StatusCritical(), label: 'Critical'),
      ));

      expect(find.text('Critical'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });

  group('YieldGauge Tests', () {
    testWidgets('Renders percentage and badge', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        const YieldGauge(
          value: 0.82,
          status: StatusGood(),
          statusLabel: 'Great',
        ),
      ));
      
      // Need to pump a few times because of animation
      await tester.pumpAndSettle();

      expect(find.text('82%'), findsOneWidget);
      expect(find.text('Great'), findsOneWidget);
      expect(find.byType(StatusBadge), findsOneWidget);
      
      // Verify min diameter of 160 is respected
      final sizedBox = find.byType(SizedBox).first;
      final size = tester.getSize(sizedBox);
      expect(size.width, greaterThanOrEqualTo(160.0));
      expect(size.height, greaterThanOrEqualTo(160.0));
    });
  });
}
