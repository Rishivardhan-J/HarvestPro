// ignore_for_file: avoid_print
import 'dart:io';

Future<void> main() async {
  print('Downloading fonts...');
  final fonts = {
    'Baloo_Paaji_2': 'https://fonts.google.com/download?family=Baloo%20Paaji%202',
    'Baloo_Thambi_2': 'https://fonts.google.com/download?family=Baloo%20Thambi%202',
    'Baloo_Tammudu_2': 'https://fonts.google.com/download?family=Baloo%20Tammudu%202',
    'Mukta_Mahee': 'https://fonts.google.com/download?family=Mukta%20Mahee',
    'Mukta_Malar': 'https://fonts.google.com/download?family=Mukta%20Malar',
    'Noto_Sans_Telugu': 'https://fonts.google.com/download?family=Noto%20Sans%20Telugu',
  };

  final tempDir = Directory('assets/fonts_temp');
  if (!await tempDir.exists()) {
    await tempDir.create(recursive: true);
  }

  final fontsDir = Directory('assets/fonts');
  if (!await fontsDir.exists()) {
    await fontsDir.create(recursive: true);
  }

  for (final entry in fonts.entries) {
    final name = entry.key;
    final url = entry.value;
    final zipFile = File('${tempDir.path}/$name.zip');

    print('Downloading $name...');
    final request = await HttpClient().getUrl(Uri.parse(url));
    final response = await request.close();
    await response.pipe(zipFile.openWrite());

    print('Extracting $name...');
    final result = await Process.run('unzip', ['-o', zipFile.path, '-d', tempDir.path]);
    if (result.exitCode != 0) {
      print('Failed to extract $name: ${result.stderr}');
      continue;
    }

    // Move TTF files to assets/fonts
    final entities = tempDir.listSync(recursive: true);
    for (final entity in entities) {
      if (entity is File && entity.path.endsWith('.ttf') && entity.path.contains(name.replaceAll('_', ' '))) {
        final fileName = entity.uri.pathSegments.last;
        final targetFile = File('${fontsDir.path}/$fileName');
        if (!await targetFile.exists()) {
           await entity.copy(targetFile.path);
           print('Installed $fileName');
        }
      }
    }
  }

  print('Cleaning up...');
  await tempDir.delete(recursive: true);
  print('Done!');
}
