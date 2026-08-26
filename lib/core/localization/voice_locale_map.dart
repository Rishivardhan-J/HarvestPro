import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Mapping from app language code to TTS engine locale.
const Map<String, String> appToTtsLocale = {
  'en': 'en-IN', // Indian English
  'ta': 'ta-IN',
  'hi': 'hi-IN',
  'pa': 'pa-IN',
  'te': 'te-IN',
  'mr': 'mr-IN',
};

/// Mapping from app language code to STT engine locale. (Reusing the same table)
const Map<String, String> appToSttLocale = appToTtsLocale;

/// Provider that checks device capabilities on initialization and caches 
/// which voice packs are actually installed and available to use.
final voiceAvailabilityProvider = FutureProvider<Map<String, bool>>((ref) async {
  final tts = FlutterTts();
  final dynamic languages = await tts.getLanguages;
  
  final availableLanguages = (languages as List?)?.cast<String>() ?? [];
  final Map<String, bool> availability = {};
  
  for (final locale in appToTtsLocale.keys) {
    final ttsCode = appToTtsLocale[locale]!;
    availability[locale] = availableLanguages.contains(ttsCode) || 
                           availableLanguages.contains(ttsCode.replaceAll('-', '_'));
  }
  
  return availability;
});
