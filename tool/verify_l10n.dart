// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

void main() {
  final l10nDir = Directory('lib/l10n');
  if (!l10nDir.existsSync()) {
    print('Error: lib/l10n directory not found');
    exit(1);
  }

  final enFile = File('lib/l10n/app_en.arb');
  final Map<String, dynamic> enJson = jsonDecode(enFile.readAsStringSync());
  final enKeys = enJson.keys.where((k) => !k.startsWith('@')).toSet();

  bool success = true;

  for (final entity in l10nDir.listSync()) {
    if (entity is File && entity.path.endsWith('.arb') && !entity.path.endsWith('app_en.arb')) {
      final json = jsonDecode(entity.readAsStringSync()) as Map<String, dynamic>;
      final keys = json.keys.where((k) => !k.startsWith('@')).toSet();

      final missingKeys = enKeys.difference(keys);
      final extraKeys = keys.difference(enKeys);
      
      final emptyValues = keys.where((k) {
        final val = json[k];
        return val == null || (val is String && val.trim().isEmpty);
      }).toList();

      if (missingKeys.isNotEmpty) {
        print('Error in ${entity.uri.pathSegments.last}: Missing keys: $missingKeys');
        success = false;
      }
      if (extraKeys.isNotEmpty) {
        print('Error in ${entity.uri.pathSegments.last}: Extra keys not in en: $extraKeys');
        success = false;
      }
      if (emptyValues.isNotEmpty) {
        print('Error in ${entity.uri.pathSegments.last}: Empty values for keys: $emptyValues');
        success = false;
      }
    }
  }

  if (success) {
    print('All ARB files are complete and match the template!');
    exit(0);
  } else {
    print('L10n validation failed.');
    exit(1);
  }
}
