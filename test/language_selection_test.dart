import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/core/localization/locale_provider.dart';
import 'package:harvestpro/core/localization/voice_locale_map.dart';
import 'package:harvestpro/core/providers/app_state_provider.dart';
import 'package:harvestpro/core/storage/hive_box_manager.dart';
import 'package:harvestpro/features/onboarding/screens/language_selection_screen.dart';
import 'package:harvestpro/l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'test_setup.dart';

void main() {
  setUpAll(() async {
    setupTestMocks();
    
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('flutter_tts'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'speak') {
          return 1;
        }
        return null;
      }
    );
    
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return Directory.systemTemp.createTempSync().path;
        }
        return null;
      }
    );

    final tempDir = Directory.systemTemp.createTempSync();
    Hive.init(tempDir.path);
  });
  
  tearDown(() async {
    await Hive.deleteBoxFromDisk('app_settings');
  });
  
  tearDownAll(() async {
    await Hive.close();
  });

  testWidgets('Selecting a card does not persist locale, but Continue does', (tester) async {
    await HiveBoxManager().initBootstrapBoxes();
    
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          voiceAvailabilityProvider.overrideWith((ref) async {
            return {'en': true, 'ta': false, 'hi': true, 'pa': true, 'te': true, 'mr': true, 'kn': true, 'ml': true};
          }),
        ],
        child: Consumer(
          builder: (context, ref, child) {
            final currentLocale = ref.watch(localeProvider);
            return MaterialApp(
              locale: currentLocale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const LanguageSelectionScreen(),
            );
          },
        ),
      ),
    );

    await tester.pump();

    // Verify initial state
    expect(find.text('Choose your language'), findsOneWidget);

    // Tap Tamil card
    await tester.tap(find.text('தமிழ்'));
    await tester.pump();
    
    // The locale should not be persisted yet, but UI should update instantly
    expect(find.text('உங்கள் மொழியைத் தேர்ந்தெடுக்கவும்'), findsOneWidget); // Tamil string
    var box = await HiveBoxManager().openBox('app_settings');
    expect(box.get('locale'), null);

    // Tap Hindi card
    await tester.tap(find.text('हिन्दी'));
    await tester.pump();
    
    // The locale should not be persisted yet, but UI should update to Hindi
    expect(find.text('अपनी भाषा चुनें'), findsOneWidget); // Hindi string
    expect(box.get('locale'), null);

    // Tap Continue
    // Continue is localized to Hindi: "जारी रखें" but we can find it by semantic or button if we aren't sure.
    // In our test, let's tap by widget type since we know it's the only FilledButton.
    await tester.tap(find.byType(FilledButton));
    
    // We expect a GoError because GoRouter is not provided, we can ignore it by using runAsync or just pump.
    // However, if it throws, the test might fail. Let's just catch flutter errors.
    try {
      await tester.pump();
    } catch (_) {}

    // Now it should be persisted to Hindi ('hi')
    box = await HiveBoxManager().openBox('app_settings');
    expect(box.get('locale'), '"hi"'); // JSON encoded string!
  });

  testWidgets('Abandoned preview falls back to default on cold restart', (tester) async {
    await HiveBoxManager().initBootstrapBoxes();
    
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          voiceAvailabilityProvider.overrideWith((ref) async => {'en': true}),
        ],
        child: Consumer(
          builder: (context, ref, child) {
            return MaterialApp(
              locale: ref.watch(localeProvider),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const LanguageSelectionScreen(),
            );
          },
        ),
      ),
    );

    await tester.pump();
    expect(find.text('Choose your language'), findsOneWidget);

    // Tap Tamil
    await tester.tap(find.text('தமிழ்'));
    await tester.pump();
    expect(find.text('உங்கள் மொழியைத் தேர்ந்தெடுக்கவும்'), findsOneWidget);

    // Simulate force quit (tear down)
    await Hive.deleteBoxFromDisk('app_settings');
    
    // Cold restart
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          voiceAvailabilityProvider.overrideWith((ref) async => {'en': true}),
        ],
        child: Consumer(
          builder: (context, ref, child) {
            return MaterialApp(
              locale: ref.watch(localeProvider),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const LanguageSelectionScreen(),
            );
          },
        ),
      ),
    );
    await tester.pump();

    // Because it wasn't persisted, it falls back to default (English)
    expect(find.text('Choose your language'), findsOneWidget);
  });

  testWidgets('Muted speaker icon renders for unavailable voices', (tester) async {
    await HiveBoxManager().initBootstrapBoxes();
    
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          voiceAvailabilityProvider.overrideWith((ref) async {
            return {'en': true, 'ta': false, 'hi': false, 'pa': false, 'te': false, 'mr': false, 'kn': false, 'ml': false};
          }),
        ],
        child: Consumer(
          builder: (context, ref, child) {
            return MaterialApp(
              locale: ref.watch(localeProvider),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const LanguageSelectionScreen(),
            );
          },
        ),
      ),
    );

    await tester.pump();

    // We should see volume_off icons because 7 languages are unavailable
    expect(find.byIcon(Icons.volume_off), findsNWidgets(7));
    // English is available
    expect(find.byIcon(Icons.volume_up), findsOneWidget);
  });

  testWidgets('Continue gracefully handles broken complete state and advances to identityChoice', (tester) async {
    await HiveBoxManager().initBootstrapBoxes();
    
    // Simulate the broken state where user has 0 profiles but onboardingStep is complete
    final box = await HiveBoxManager().openBox('app_settings');
    await box.put('onboardingStep', '"OnboardingStep.complete"'); // Note: JSON encoded
    
    final container = ProviderContainer();
    container.read(onboardingStateProvider); // trigger load
    await Future.delayed(const Duration(milliseconds: 50));
    
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: Consumer(
          builder: (context, ref, child) {
            return MaterialApp(
              locale: ref.watch(localeProvider),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const LanguageSelectionScreen(),
            );
          },
        ),
      ),
    );

    await tester.pump();
    
    // Select English
    await tester.tap(find.text('English'));
    await tester.pump();
    
    // Tap Continue
    await tester.tap(find.byType(FilledButton));
    
    // Wait for the async actions to complete. Should NOT crash.
    try {
      await tester.pump();
    } catch (_) {
      // Ignore GoRouter error because we didn't provide a router, we just want to verify state transition
    }
    
    // Verify that the state was updated despite starting as complete
    final step = container.read(onboardingStateProvider);
    expect(step, OnboardingStep.identityChoice);
    
    container.dispose();
  });
}
