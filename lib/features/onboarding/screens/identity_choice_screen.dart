import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_state_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';

class IdentityChoiceScreen extends ConsumerStatefulWidget {
  const IdentityChoiceScreen({super.key});

  @override
  ConsumerState<IdentityChoiceScreen> createState() => _IdentityChoiceScreenState();
}

class _IdentityChoiceScreenState extends ConsumerState<IdentityChoiceScreen> {
  final TextEditingController _kisanIdController = TextEditingController();
  bool _isVerifyEnabled = false;

  @override
  void initState() {
    super.initState();
    _kisanIdController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _kisanIdController.removeListener(_onTextChanged);
    _kisanIdController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final text = _kisanIdController.text;
    final isEnabled = text.length == 11 && RegExp(r'^\d{11}$').hasMatch(text);
    if (_isVerifyEnabled != isEnabled) {
      setState(() {
        _isVerifyEnabled = isEnabled;
      });
    }
  }

  void _onVerifyTapped() {
    // We would normally pass the ID to a provider, but for now we just advance the state
    // so the verifying screen can read the ID from a provider if needed.
    // For mock purposes, we can store the entered ID in a simple provider, or pass it as an argument.
    // Since routing doesn't take arguments in our current setup for onboarding, we should use a Riverpod StateProvider.
    ref.read(enteredKisanIdProvider.notifier).state = _kisanIdController.text;
    ref.read(onboardingStateProvider.notifier).advanceToIdentityVerifying();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Kisan ID'),
        automaticallyImplyLeading: false, // Onboarding flow shouldn't go back unless explicitly allowed
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(HarvestSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Please enter your 11-digit Kisan ID',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: HarvestSpacing.md),
              TextField(
                controller: _kisanIdController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                style: context.textTheme.bodyLarge?.copyWith(fontSize: 18.0, letterSpacing: 2.0),
                decoration: const InputDecoration(
                  hintText: '00000000000',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: HarvestColors.accent, width: 2.0),
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _isVerifyEnabled ? _onVerifyTapped : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md),
                  backgroundColor: HarvestColors.accent,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Verify', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: HarvestSpacing.md),
              TextButton(
                onPressed: () {
                  ref.read(onboardingStateProvider.notifier).advanceToManualEntry();
                },
                child: const Text("I don't have a Kisan ID yet"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// A simple provider to hold the entered ID temporarily between choice and verifying screens
final enteredKisanIdProvider = StateProvider<String?>((ref) => null);
