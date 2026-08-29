import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageException implements Exception {
  final String message;
  final dynamic originalError;

  StorageException(this.message, [this.originalError]);

  @override
  String toString() => 'StorageException: $message${originalError != null ? ' ($originalError)' : ''}';
}

/// A centralized manager for all Hive boxes to prevent race conditions
/// and enforce consistent `Box<String>` serialization across the app.
class HiveBoxManager {
  static final HiveBoxManager _instance = HiveBoxManager._internal();
  factory HiveBoxManager() => _instance;
  HiveBoxManager._internal();

  final Map<String, Future<Box<String>>> _openFutures = {};
  Uint8List? _encryptionKey;

  /// Retrieves or generates the secure encryption key
  Future<void> _initEncryption() async {
    if (_encryptionKey != null) {
      return;
    }

    try {
      const secureStorage = FlutterSecureStorage();
      final containsEncryptionKey = await secureStorage.containsKey(key: 'hive_key');
      if (!containsEncryptionKey) {
        final key = Hive.generateSecureKey();
        await secureStorage.write(key: 'hive_key', value: base64UrlEncode(key));
      }
      final keyString = await secureStorage.read(key: 'hive_key');
      if (keyString == null) {
        throw StorageException('Failed to read encryption key from secure storage.');
      }
      _encryptionKey = base64Url.decode(keyString);
    } catch (e) {
      throw StorageException('Failed to initialize encryption for local storage.', e);
    }
  }

  /// Called during app bootstrap before the first frame
  Future<void> initBootstrapBoxes() async {
    await Hive.initFlutter();
    await _initEncryption();

    // Boxes required for immediate cold-start display and routing
    // All are explicitly opened as Box<String> to ensure JSON serialization consistency
    await Future.wait([
      openBox('app_settings'),
      openBox('profiles'),
      openBox('yield_predictions'),
      openBox('recommendations'),
    ]);
  }

  /// The singular entrypoint for opening any Hive box anywhere in the app.
  /// Uses a memoized future to prevent race conditions during concurrent requests.
  Future<Box<String>> openBox(String boxName) {
    if (_openFutures.containsKey(boxName)) {
      return _openFutures[boxName]!;
    }

    // Memoize the in-flight opening process
    final future = _openBoxInternal(boxName);
    _openFutures[boxName] = future;
    return future;
  }

  Future<Box<String>> _openBoxInternal(String boxName) async {
    await _initEncryption();
    try {
      if (Hive.isBoxOpen(boxName)) {
        final box = Hive.box<String>(boxName);
        return box;
      }
      return await Hive.openBox<String>(
        boxName,
        encryptionCipher: HiveAesCipher(_encryptionKey!),
      );
    } catch (e) {
      // If we failed to open because of a type mismatch from previous untyped data,
      // delete the box and recreate it to enforce the new Box<String> standard.
      if (e is HiveError && e.message.contains('already open and of type')) {
        throw StorageException('Box "$boxName" has a type conflict.', e);
      }
      
      // For general parsing/corruption errors:
      try {
        await Hive.deleteBoxFromDisk(boxName);
        return await Hive.openBox<String>(
          boxName,
          encryptionCipher: HiveAesCipher(_encryptionKey!),
        );
      } catch (fallbackError) {
        throw StorageException('Failed to open or recover box "$boxName".', fallbackError);
      }
    }
  }

  /// Exposes standard JSON reading for app settings that isn't tied to a specific repo
  Future<dynamic> getSetting(String key) async {
    final box = await openBox('app_settings');
    final val = box.get(key);
    if (val == null) {
      return null;
    }
    try {
      return jsonDecode(val);
    } catch (_) {
      return val; // Fallback for raw strings if they exist
    }
  }

  Future<void> putSetting(String key, dynamic value) async {
    final box = await openBox('app_settings');
    await box.put(key, jsonEncode(value));
  }
}
