import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/shared_widgets/error_state.dart';

void main() {
  testWidgets('ErrorState displays message and retry button', (WidgetTester tester) async {
    bool retryPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ErrorState(
            message: 'Network Error',
            onRetry: () => retryPressed = true,
          ),
        ),
      ),
    );

    expect(find.text('Network Error'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
    
    await tester.tap(find.text('Retry'));
    expect(retryPressed, isTrue);
    
    expect(find.text('Continue without it'), findsNothing);
  });

  testWidgets('ErrorState displays alternative action if provided', (WidgetTester tester) async {
    bool altPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ErrorState(
            message: 'ID Error',
            onRetry: () {},
            alternativeActionLabel: 'Skip',
            onAlternativeAction: () => altPressed = true,
          ),
        ),
      ),
    );

    expect(find.text('ID Error'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    
    await tester.tap(find.text('Skip'));
    expect(altPressed, isTrue);
  });
}
