import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/core/storage/hive_box_manager.dart';
import 'package:harvestpro/data/repositories/mock_recommendation_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUpAll(() async {
    FlutterSecureStorage.setMockInitialValues({});
    TestWidgetsFlutterBinding.ensureInitialized();
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
    await HiveBoxManager().initBootstrapBoxes();
  });

  tearDownAll(() async {
    if (Hive.isBoxOpen('app_settings')) {
      await Hive.box<String>('app_settings').clear();
    }
    if (Hive.isBoxOpen('profiles')) {
      await Hive.box<String>('profiles').clear();
    }
  });

  test('All seeded Recommendation keys exist in app_en.arb', () async {
    // 1. Get seeded recommendations
    final repo = MockRecommendationRepository();
    final recs = await repo.getActiveRecommendations('test_profile');

    // 2. Read app_en.arb
    final arbFile = File('lib/l10n/app_en.arb');
    final arbContent = await arbFile.readAsString();
    final arbJson = jsonDecode(arbContent) as Map<String, dynamic>;

    // 3. Verify
    for (final rec in recs) {
      expect(
        arbJson.containsKey(rec.titleKey),
        isTrue,
        reason: 'Missing titleKey in app_en.arb: ${rec.titleKey}',
      );
      expect(
        arbJson.containsKey(rec.descriptionKey),
        isTrue,
        reason: 'Missing descriptionKey in app_en.arb: ${rec.descriptionKey}',
      );
    }
  });
}
