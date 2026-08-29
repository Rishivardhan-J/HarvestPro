import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/core/providers/app_state_provider.dart';
import 'package:harvestpro/core/providers/repositories_provider.dart';
import 'package:harvestpro/core/router/app_router.dart';
import 'package:harvestpro/core/storage/hive_box_manager.dart';
import 'package:harvestpro/data/models/farmer_profile.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'test_setup.dart';

void main() {
  setUpAll(() async {
    setupTestMocks();
    final tempDir = Directory.systemTemp.createTempSync();
    Hive.init(tempDir.path);
    await HiveBoxManager().initBootstrapBoxes();
  });

  tearDownAll(() async {
    await Hive.box<String>('app_settings').clear();
    await Hive.box<String>('profiles').clear();
  });

  testWidgets('Router identity remains constant across state changes', (WidgetTester tester) async {
    final container = ProviderContainer();
    
    // Read the router instance for the first time
    final initialRouter = container.read(appRouterProvider);
    final initialHashCode = identityHashCode(initialRouter);

    // Simulate onboarding step change
    await container.read(onboardingStateProvider.notifier).advanceToConsent();
    await tester.pump();
    
    final routerAfterStepChange = container.read(appRouterProvider);
    expect(
      identityHashCode(routerAfterStepChange),
      initialHashCode,
      reason: 'Router was recreated after OnboardingStep changed!',
    );

    // Simulate active profile change (the original trigger condition for the bug)
    final profile = FarmerProfile(
      id: 'mock_regression_123',
      name: 'Regression Tester',
      village: 'Test Village',
      district: 'Test District',
      state: 'Test State',
      primaryCrop: 'Test Crop',
      landSizeAcres: 5.0,
      preferredLanguage: 'en',
      dataSource: DataSource.manualEntry,
      createdAt: DateTime.now(),
    );
    
    final repo = container.read(farmerProfileRepositoryProvider);
    final createdProfile = await repo.createProfile(profile);
    await container.read(activeFarmerProfileProvider.notifier).setActiveProfile(createdProfile.id);
    await tester.pump();

    final routerAfterProfileChange = container.read(appRouterProvider);
    expect(
      identityHashCode(routerAfterProfileChange),
      initialHashCode,
      reason: 'Router was recreated after activeFarmerProfileProvider changed!',
    );

    container.dispose();
  });
}
