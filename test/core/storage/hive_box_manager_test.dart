import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/core/storage/hive_box_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUpAll(() async {
    await Hive.initFlutter();
  });

  group('HiveBoxManager', () {
    test('Concurrent requests for the same box return the same instance without throwing race exceptions', () async {
      final manager = HiveBoxManager();
      
      // Fire 10 concurrent requests for the same box
      final futures = List.generate(10, (_) => manager.openBox('test_concurrent_box'));
      
      final boxes = await Future.wait(futures);
      
      // All futures should resolve to the exact same Box instance
      final firstBox = boxes.first;
      for (final box in boxes) {
        expect(identical(box, firstBox), isTrue);
      }
      
      // Verify it's actually open and functioning
      expect(firstBox.isOpen, isTrue);
      
      // Cleanup
      await firstBox.close();
      await Hive.deleteBoxFromDisk('test_concurrent_box');
    });
  });
}
