import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/data/models/recommendation.dart';
import 'package:harvestpro/features/recommendations/widgets/swipeable_card.dart';
import 'package:harvestpro/l10n/app_localizations.dart';

void main() {
  Widget createTestWidget(Recommendation rec, {
    required ValueChanged<SwipeDirection> onSwiped,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Center(
          child: RecommendationSwipeCard(
            recommendation: rec,
            onSwiped: onSwiped,
            onNonGestureTapLeft: () => onSwiped(SwipeDirection.left),
            onNonGestureTapRight: () => onSwiped(SwipeDirection.right),
            child: const SizedBox(width: 300, height: 200, child: Text('Test Card')),
          ),
        ),
      ),
    );
  }

  testWidgets('SwipeableCard handles right swipe over threshold', (WidgetTester tester) async {
    SwipeDirection? swipedDirection;
    final rec = Recommendation(
      id: '1',
      farmerProfileId: '1',
      titleKey: 'title',
      descriptionKey: 'desc',
      estimatedValueRupees: 100,
      estimatedValueUnit: EstimatedValueUnit.total,
      category: RecommendationCategory.other,
      status: RecommendationStatus.pending,
      iconKey: 'icon',
      createdAt: DateTime.now(),
    );

    await tester.pumpWidget(createTestWidget(rec, onSwiped: (dir) => swipedDirection = dir));
    await tester.pumpAndSettle();

    final screenWidth = tester.view.physicalSize.width / tester.view.devicePixelRatio;
    
    // Drag beyond 35% of screen width (e.g., 50%)
    await tester.drag(find.text('Test Card'), Offset(screenWidth * 0.5, 0));
    await tester.pumpAndSettle(); // Allow exit animation to finish

    expect(swipedDirection, SwipeDirection.right);
  });

  testWidgets('SwipeableCard springs back if below threshold', (WidgetTester tester) async {
    SwipeDirection? swipedDirection;
    final rec = Recommendation(
      id: '1',
      farmerProfileId: '1',
      titleKey: 'title',
      descriptionKey: 'desc',
      estimatedValueRupees: 100,
      estimatedValueUnit: EstimatedValueUnit.total,
      category: RecommendationCategory.other,
      status: RecommendationStatus.pending,
      iconKey: 'icon',
      createdAt: DateTime.now(),
    );

    await tester.pumpWidget(createTestWidget(rec, onSwiped: (dir) => swipedDirection = dir));
    await tester.pumpAndSettle();

    final screenWidth = tester.view.physicalSize.width / tester.view.devicePixelRatio;
    
    // Drag below 35% of screen width (e.g., 20%)
    await tester.drag(find.text('Test Card'), Offset(screenWidth * 0.2, 0));
    await tester.pumpAndSettle(); // Allow spring back animation to finish

    expect(swipedDirection, isNull);
  });
}
