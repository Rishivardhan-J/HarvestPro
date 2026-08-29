import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/core/providers/app_state_provider.dart';
import 'package:harvestpro/core/router/app_router.dart';
import 'package:harvestpro/core/storage/hive_box_manager.dart';
import 'package:harvestpro/data/models/farmer_profile.dart';
import 'package:harvestpro/features/home/screens/home_screen.dart';
import 'package:harvestpro/features/onboarding/screens/consent_screen.dart';
import 'package:harvestpro/features/onboarding/screens/identity_choice_screen.dart';
import 'package:harvestpro/features/onboarding/screens/language_selection_screen.dart';
import 'package:harvestpro/features/onboarding/screens/manual_entry_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'test_setup.dart';

void main() {
  setUpAll(() async {
    setupTestMocks();
    final tempDir = Directory.systemTemp.createTempSync();
    Hive.init(tempDir.path);
    await HiveBoxManager().initBootstrapBoxes();
  });

  tearDown(() async {
    await Hive.box<String>('app_settings').clear();
    await Hive.box<String>('profiles').clear();
  });

  testWidgets('Integration: Manual Entry path to Home', (WidgetTester tester) async {
    final container = ProviderContainer();
    
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: container.read(appRouterProvider),
        ),
      ),
    );

    // Should start at Language Selection
    await tester.pumpAndSettle();
    expect(find.byType(LanguageSelectionScreen), findsOneWidget);
    
    // Tap Continue on Language
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    
    // Identity Choice
    expect(find.byType(IdentityChoiceScreen), findsOneWidget);
    // Tap "I don't have one"
    await tester.tap(find.text("I don't have one"));
    await tester.pumpAndSettle();
    
    // Manual Entry
    expect(find.byType(ManualEntryScreen), findsOneWidget);
    
    // Fill form
    await tester.enterText(find.byKey(const Key('name_input')), 'Test User');
    await tester.enterText(find.byKey(const Key('village_input')), 'Test Village');
    await tester.enterText(find.byKey(const Key('crop_input')), 'Test Crop');
    await tester.enterText(find.byKey(const Key('land_input')), '2.5');
    
    // Submit
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();
    
    // Consent
    expect(find.byType(ConsentScreen), findsOneWidget);
    
    // Tap Allow
    await tester.tap(find.text('Allow'));
    await tester.pumpAndSettle(); // Wait for navigation
    
    // Should be at Home Screen
    expect(find.byType(HomeScreen), findsOneWidget);
    
    container.dispose();
  });
  
  testWidgets('Integration: Stress Variant (extra profile switch mid-onboarding)', (WidgetTester tester) async {
    final container = ProviderContainer();
    
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: container.read(appRouterProvider),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(LanguageSelectionScreen), findsOneWidget);
    
    // Deliberately trigger an active profile state change while still in onboarding
    // to verify the router doesn't reset.
    container.read(activeFarmerProfileProvider.notifier).state = const AsyncValue.loading();
    await tester.pump();
    
    container.read(activeFarmerProfileProvider.notifier).state = AsyncValue.data(FarmerProfile(
      id: 'stress_test_123',
      name: 'Stress Test',
      village: 'Test',
      district: 'Test',
      state: 'Test',
      primaryCrop: 'Test',
      landSizeAcres: 1.0,
      preferredLanguage: 'en',
      dataSource: DataSource.manualEntry,
      createdAt: DateTime.now(),
    ));
    await tester.pumpAndSettle();
    
    // We should STILL be on Language Selection (it shouldn't have reset to initial route or blown up)
    expect(find.byType(LanguageSelectionScreen), findsOneWidget);

    container.dispose();
  });
}
