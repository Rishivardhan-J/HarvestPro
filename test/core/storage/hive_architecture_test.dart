import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Hive Architecture Constraints', () {
    test('Hive.openBox is ONLY called from hive_box_manager.dart', () {
      final libDir = Directory('lib');
      final dartFiles = libDir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));

      final violations = <String>[];

      for (final file in dartFiles) {
        // Skip the manager itself
        if (file.path.endsWith('hive_box_manager.dart')) {
          continue;
        }

        final content = file.readAsStringSync();
        
        // Match `Hive.openBox` or `Hive.box` to ensure no one bypasses the manager
        if (content.contains('Hive.openBox(') || content.contains('Hive.openBox<')) {
          violations.add('${file.path} contains Hive.openBox');
        }
        if (content.contains('Hive.box(') || content.contains('Hive.box<')) {
          violations.add('${file.path} contains Hive.box');
        }
      }

      expect(violations, isEmpty, reason: 'All Hive box lifecycle methods must go through HiveBoxManager');
    });
  });
}
