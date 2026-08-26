// ignore_for_file: avoid_print
import 'dart:io';

void main() {
  final dir = Directory('lib/l10n');
  if (dir.existsSync()) {
    for (final file in dir.listSync()) {
      if (file is File && file.path.endsWith('.dart') && file.path.contains('app_localizations')) {
        file.deleteSync();
        print('Deleted ${file.path}');
      }
    }
  }
}
