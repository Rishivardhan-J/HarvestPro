import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:harvestpro/l10n/app_localizations.dart';

import '../../../core/localization/locale_provider.dart';
import '../../../core/localization/voice_locale_map.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';

class LanguageSelectionScreen extends ConsumerStatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  ConsumerState<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends ConsumerState<LanguageSelectionScreen> with TickerProviderStateMixin {
  String? _selectedLanguageCode;
  late FlutterTts _tts;
  
  // Track playing state and animations for speaker icons
  String? _currentlyPlayingCode;
  late final Map<String, AnimationController> _pulseControllers = {};

  @override
  void initState() {
    super.initState();
    _tts = FlutterTts();
    _tts.setCompletionHandler(() {
      if (mounted && _currentlyPlayingCode != null) {
        _pulseControllers[_currentlyPlayingCode]?.stop();
        _pulseControllers[_currentlyPlayingCode]?.reset();
        setState(() {
          _currentlyPlayingCode = null;
        });
      }
    });

    // Initialize pulse controllers for all locales
    for (final locale in supportedLocales) {
      final code = locale.languageCode;
      _pulseControllers[code] = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      );
    }
    
    // Pre-select based on system locale or English if it's the very first time.
    // However, the provider already handled this logic and holds the initial state.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedLanguageCode = ref.read(localeProvider).languageCode;
      });
    });
  }

  @override
  void dispose() {
    _tts.stop();
    for (final controller in _pulseControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _playLanguageName(String localeCode, String nativeName, bool isAvailable) async {
    if (!isAvailable) {
      return;
    }

    if (_currentlyPlayingCode != null) {
      await _tts.stop();
      _pulseControllers[_currentlyPlayingCode]?.stop();
      _pulseControllers[_currentlyPlayingCode]?.reset();
    }

    setState(() {
      _currentlyPlayingCode = localeCode;
    });

    _pulseControllers[localeCode]?.repeat(reverse: true);
    final ttsLocale = appToTtsLocale[localeCode]!;
    await _tts.setLanguage(ttsLocale);
    await _tts.speak(nativeName);
  }

  void _onCardTapped(String code, String nativeName, bool isAvailable) {
    setState(() {
      _selectedLanguageCode = code;
    });
    // Don't persist yet, just preview
    _playLanguageName(code, nativeName, isAvailable);
  }

  void _onContinuePressed() {
    if (_selectedLanguageCode != null) {
      ref.read(localeProvider.notifier).setLocale(Locale(_selectedLanguageCode!));
      // Navigate to identity verification
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final voiceAvailabilityAsync = ref.watch(voiceAvailabilityProvider);

    final nativeNames = {
      'en': 'English',
      'ta': 'தமிழ்',
      'hi': 'हिन्दी',
      'pa': 'ਪੰਜਾਬੀ',
      'te': 'తెలుగు',
      'mr': 'मराठी',
      'kn': 'ಕನ್ನಡ',
      'ml': 'മലയാളം',
    };

    final languageData = AppLocalizations.supportedLocales.map((locale) {
      final code = locale.languageCode;
      final nativeName = nativeNames[code] ?? code;
      return {
        'code': code,
        'native': nativeName,
        'semantic': l10n.onboarding_languageName(code == 'en' ? nativeName : '$nativeName, ${nativeNames['en']}'),
      };
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.onboarding_languageScreenTitle),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: voiceAvailabilityAsync.when(
                data: (availability) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(HarvestSpacing.lg),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: HarvestSpacing.md,
                      mainAxisSpacing: HarvestSpacing.md,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: languageData.length,
                    itemBuilder: (context, index) {
                      final data = languageData[index];
                      final code = data['code']!;
                      final nativeName = data['native']!;
                      final semanticLabel = data['semantic']!;
                      
                      final isSelected = _selectedLanguageCode == code;
                      final isAvailable = availability[code] ?? false;
                      final isPlaying = _currentlyPlayingCode == code;
                      
                      // Render card with appropriate font per script
                      return _LanguageCard(
                        localeCode: code,
                        nativeName: nativeName,
                        semanticLabel: semanticLabel,
                        isSelected: isSelected,
                        isVoiceAvailable: isAvailable,
                        isPlaying: isPlaying,
                        pulseAnimation: _pulseControllers[code]!,
                        onTap: () => _onCardTapped(code, nativeName, isAvailable),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => const Center(child: Icon(Icons.error)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(HarvestSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _selectedLanguageCode != null ? _onContinuePressed : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: HarvestColors.resolveInteractiveColor(const InteractiveAccent()),
                    foregroundColor: HarvestColors.bgLight,
                    padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md),
                    shape: const RoundedRectangleBorder(borderRadius: HarvestRadius.md),
                  ),
                  child: Text(
                    l10n.onboarding_continueButton,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: HarvestColors.bgLight,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String localeCode;
  final String nativeName;
  final String semanticLabel;
  final bool isSelected;
  final bool isVoiceAvailable;
  final bool isPlaying;
  final Animation<double> pulseAnimation;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.localeCode,
    required this.nativeName,
    required this.semanticLabel,
    required this.isSelected,
    required this.isVoiceAvailable,
    required this.isPlaying,
    required this.pulseAnimation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Generate typography specific to this card's locale so it renders correctly
    // even if the app's current locale is different.
    final cardLocale = Locale(localeCode);
    
    // Instead of above, let's use the actual HarvestTypography logic
    final localizedTheme = Theme.of(context).copyWith(
      textTheme: context.theme.brightness == Brightness.light 
          ? AppTheme.getLightTheme(cardLocale).textTheme 
          : AppTheme.getDarkTheme(cardLocale).textTheme,
    );

    final shadows = isSelected 
        ? HarvestElevation.level2(context.brightness)
        : HarvestElevation.level1(context.brightness);

    final borderColor = isSelected 
        ? HarvestColors.resolveInteractiveColor(const InteractiveAccent())
        : Colors.transparent;

    Widget iconWidget = Icon(
      isVoiceAvailable ? Icons.volume_up : Icons.volume_off,
      size: 16.0,
      color: isVoiceAvailable ? context.theme.colorScheme.onSurface : context.theme.disabledColor,
    );

    if (isPlaying) {
      iconWidget = AnimatedBuilder(
        animation: pulseAnimation,
        builder: (context, child) {
          final scale = 1.0 + (pulseAnimation.value * 0.2);
          return Transform.scale(scale: scale, child: child);
        },
        child: iconWidget,
      );
    }

    return Semantics(
      label: semanticLabel,
      selected: isSelected,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.canvasColor,
            borderRadius: HarvestRadius.md,
            border: Border.all(color: borderColor, width: 2.0),
            boxShadow: shadows,
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      nativeName,
                      style: localizedTheme.textTheme.headlineLarge,
                    ),
                    const SizedBox(height: HarvestSpacing.sm),
                    iconWidget,
                  ],
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: HarvestColors.resolveInteractiveColor(const InteractiveAccent()),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: const Icon(
                      Icons.check,
                      size: 16.0,
                      color: HarvestColors.bgLight,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
