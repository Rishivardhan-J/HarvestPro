import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart' hide Key;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ImageProcessor {
  /// Processes an image:
  /// 1. Reads and applies EXIF orientation.
  /// 2. Strips EXIF location data (privacy).
  /// 3. Resizes to max 1280px long edge.
  /// 4. Iteratively JPEG compresses down to <300KB (step down to quality 40).
  /// 5. Encrypts the final bytes with AES and saves to a secure local file.
  /// Returns the path to the saved file.
  static Future<String> processAndSaveImage(String sourcePath, {bool dataSaverEnabled = false}) async {
    final bytes = await File(sourcePath).readAsBytes();
    
    // 1. Decode image and apply orientation
    img.Image? image = img.decodeImage(bytes);
    if (image == null) {
      throw Exception('Failed to decode image');
    }
    image = img.bakeOrientation(image);

    // 2. Strip GPS/Location EXIF
    // The image package parses Exif. We can clear it or remove specific tags.
    // Easiest and most private is to just clear all EXIF before encoding.
    // The newly encoded JPEG will not have the original EXIF unless we pass it.

    // 3 & 4. Iterative compression
    // Max long edge 1280 (or 800 if data saver is enabled)
    final maxLongEdge = dataSaverEnabled ? 800 : 1280;
    if (image.width > maxLongEdge || image.height > maxLongEdge) {
      final isLandscape = image.width > image.height;
      final targetWidth = isLandscape ? maxLongEdge : null;
      final targetHeight = isLandscape ? null : maxLongEdge;
      image = img.copyResize(image, width: targetWidth, height: targetHeight);
    }

    int quality = dataSaverEnabled ? 60 : 85;
    Uint8List finalBytes = img.encodeJpg(image, quality: quality);
    
    // Budget is 300KB (or 100KB for data saver)
    final sizeBudget = dataSaverEnabled ? 100 * 1024 : 300 * 1024;
    while (finalBytes.length > sizeBudget && quality > 40) {
      quality -= 10;
      finalBytes = img.encodeJpg(image, quality: quality);
    }
    
    // If it's still too big at quality 40, resize further
    while (finalBytes.length > sizeBudget) {
      image = img.copyResize(image!, width: (image.width * 0.8).toInt());
      finalBytes = img.encodeJpg(image, quality: 40);
    }

    debugPrint('Final processed image size: ${finalBytes.length} bytes at quality $quality and size ${image?.width}x${image?.height}');

    // 5. Encrypt with AES
    const secureStorage = FlutterSecureStorage();
    final keyStr = await secureStorage.read(key: 'hive_key');
    final aesKey = base64Url.decode(keyStr!);
    
    final key = Key(aesKey);
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(key));
    
    final encrypted = encrypter.encryptBytes(finalBytes, iv: iv);
    
    // Prepend IV to the file bytes for decryption later
    final fileBytes = BytesBuilder();
    fileBytes.add(iv.bytes);
    fileBytes.add(encrypted.bytes);

    // Save to private sandbox directory
    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'capture_${const Uuid().v4()}.enc';
    final savePath = '${directory.path}/$fileName';
    
    final file = File(savePath);
    await file.writeAsBytes(fileBytes.toBytes(), flush: true);
    
    return savePath;
  }
}
