import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/core/localization/voice_locale_map.dart';
import 'package:harvestpro/features/onboarding/screens/language_selection_screen.dart';
import 'package:harvestpro/l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUpAll(() async {
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
    await Hive.openBox('app_settings');
    
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          voiceAvailabilityProvider.overrideWith((ref) async {
            return {'en': true, 'ta': false, 'hi': true, 'pa': true, 'te': true, 'mr': true};
          }),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: LanguageSelectionScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify initial state
    expect(find.text('Choose your language'), findsOneWidget);

    // Tap Tamil card
    await tester.tap(find.text('தமிழ்'));
    await tester.pump();
    
    // The locale should not be persisted yet
    final box = Hive.box('app_settings');
    expect(box.get('locale'), null);

    // Tap Continue
    await tester.tap(find.text('Continue'));
    await tester.pump();

    // Now it should be persisted
    expect(box.get('locale'), 'ta');
  });

  testWidgets('Muted speaker icon renders for unavailable voices', (tester) async {
    await Hive.openBox('app_settings');
    
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          voiceAvailabilityProvider.overrideWith((ref) async {
            return {'en': true, 'ta': false, 'hi': false, 'pa': false, 'te': false, 'mr': false};
          }),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: LanguageSelectionScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // We should see volume_off icons because 5 languages are unavailable
    expect(find.byIcon(Icons.volume_off), findsNWidgets(5));
    // English is available
    expect(find.byIcon(Icons.volume_up), findsOneWidget);
  });
}
