import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../core/localization/locale_provider.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../data/models/farmer_profile.dart';
import 'identity_verifying_screen.dart';

class ManualEntryScreen extends ConsumerStatefulWidget {
  const ManualEntryScreen({super.key});

  @override
  ConsumerState<ManualEntryScreen> createState() => _ManualEntryScreenState();
}

class _ManualEntryScreenState extends ConsumerState<ManualEntryScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  String _primaryCrop = 'Paddy';
  double _landSizeAcres = 2.0;

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListeningName = false;
  bool _isListeningVillage = false;

  @override
  void dispose() {
    _nameController.dispose();
    _villageController.dispose();
    super.dispose();
  }

  Future<void> _listen(TextEditingController controller, bool isName) async {
    final isListening = isName ? _isListeningName : _isListeningVillage;
    
    if (!isListening) {
      final locale = ref.read(localeProvider).languageCode;
      // Map to STT locale
      final sttLocaleId = locale == 'ta' ? 'ta_IN' : 'en_US';

      final bool available = await _speech.initialize(
        onStatus: (val) {
          if (val == 'done' || val == 'notListening') {
            setState(() {
              if (isName) {
                _isListeningName = false;
              } else {
                _isListeningVillage = false;
              }
            });
          }
        },
        onError: (val) {
          setState(() {
            if (isName) {
              _isListeningName = false;
            } else {
              _isListeningVillage = false;
            }
          });
        },
      );
      if (available) {
        setState(() {
          if (isName) {
            _isListeningName = true;
          } else {
            _isListeningVillage = true;
          }
        });
        await _speech.listen(
          onResult: (val) {
            setState(() {
              controller.text = val.recognizedWords;
            });
          },
          listenOptions: stt.SpeechListenOptions(localeId: sttLocaleId),
        );
      }
    } else {
      setState(() {
        if (isName) {
          _isListeningName = false;
        } else {
          _isListeningVillage = false;
        }
      });
      await _speech.stop();
    }
  }

  void _onContinue() {
    final profile = FarmerProfile(
      id: 'manual_${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text.isEmpty ? 'Unknown Farmer' : _nameController.text,
      village: _villageController.text.isEmpty ? 'Unknown Village' : _villageController.text,
      district: 'Unknown District', // Or from a dropdown in a real app
      state: 'Unknown State', // Or from a dropdown in a real app
      primaryCrop: _primaryCrop,
      landSizeAcres: _landSizeAcres,
      preferredLanguage: ref.read(localeProvider).languageCode,
      dataSource: DataSource.manualEntry,
      createdAt: DateTime.now(),
    );

    ref.read(verifiedProfileProvider.notifier).state = profile;
    ref.read(onboardingStateProvider.notifier).advanceToConsent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Details'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(HarvestSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Let's set up your profile manually.",
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: HarvestSpacing.xl),
              
              // Name Field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  prefixIcon: const Icon(Icons.person),
                  suffixIcon: IconButton(
                    icon: Icon(_isListeningName ? Icons.mic : Icons.mic_none, color: _isListeningName ? HarvestColors.accent : null),
                    onPressed: () => _listen(_nameController, true),
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: HarvestSpacing.lg),

              // Village Field
              TextField(
                controller: _villageController,
                decoration: InputDecoration(
                  labelText: 'Your Village',
                  prefixIcon: const Icon(Icons.location_on),
                  suffixIcon: IconButton(
                    icon: Icon(_isListeningVillage ? Icons.mic : Icons.mic_none, color: _isListeningVillage ? HarvestColors.accent : null),
                    onPressed: () => _listen(_villageController, false),
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: HarvestSpacing.lg),

              // Primary Crop
              DropdownButtonFormField<String>(
                initialValue: _primaryCrop,
                decoration: const InputDecoration(
                  labelText: 'Primary Crop',
                  prefixIcon: Icon(Icons.grass),
                  border: OutlineInputBorder(),
                ),
                items: ['Paddy', 'Wheat', 'Maize', 'Sugarcane'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _primaryCrop = newValue!;
                  });
                },
              ),
              const SizedBox(height: HarvestSpacing.lg),

              // Land Size
              Text('Rough Land Size: ${_landSizeAcres.toStringAsFixed(1)} Acres', style: context.textTheme.titleSmall),
              Slider(
                value: _landSizeAcres,
                min: 0.5,
                max: 20.0,
                divisions: 39, // 0.5 acre increments
                label: '${_landSizeAcres.toStringAsFixed(1)} Acres',
                onChanged: (value) {
                  setState(() {
                    _landSizeAcres = value;
                  });
                },
                activeColor: HarvestColors.accent,
              ),
              const SizedBox(height: HarvestSpacing.xxl),

              ElevatedButton(
                onPressed: _onContinue,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md),
                  backgroundColor: HarvestColors.accent,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Continue', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
