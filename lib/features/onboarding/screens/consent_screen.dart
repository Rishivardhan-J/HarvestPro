import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/providers/repositories_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/theme/motion_tokens.dart';
import '../../../data/models/farmer_profile.dart';
import 'identity_verifying_screen.dart';

class ConsentScreen extends ConsumerStatefulWidget {
  const ConsentScreen({super.key});

  @override
  ConsumerState<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends ConsumerState<ConsentScreen> {
  bool _showLearnMore = false;
  bool _isSaving = false;

  Future<void> _onAllow(FarmerProfile profile) async {
    setState(() => _isSaving = true);
    try {
      final repo = ref.read(farmerProfileRepositoryProvider);
      final createdProfile = await repo.createProfile(profile);
      await ref.read(activeFarmerProfileProvider.notifier).setActiveProfile(createdProfile.id);
      
      if (!mounted) {
        return;
      }
      await ref.read(onboardingStateProvider.notifier).advanceToComplete();
    } catch (e) {
      // Handle error gracefully
      if (!mounted) {
        return;
      }
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error saving profile: $e')));
    }
  }

  void _onNotNow(bool isKisanId) {
    if (isKisanId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No problem — let's set up your profile a different way.")),
      );
      ref.read(onboardingStateProvider.notifier).advanceToManualEntry();
    } else {
      // If manual entry declines, they can't use the app without saving locally.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('We need to save this data locally to use the app.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(verifiedProfileProvider);
    if (profile == null) {
      // Fallback if accessed out of order
      return const Scaffold(body: Center(child: Text('Error: No profile data found.')));
    }

    final isKisanIdPath = profile.dataSource == DataSource.kisanIdVerified;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissions & Privacy'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(HarvestSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isKisanIdPath
                    ? 'Before we pull your farm details...'
                    : 'Before we save your profile...',
                style: context.textTheme.headlineSmall,
              ),
              const SizedBox(height: HarvestSpacing.xl),
              
              _buildListItem('🧑', 'Your name and village'),
              _buildListItem('🌾', 'Your primary crop and land size'),
              if (isKisanIdPath) _buildListItem('🪪', 'Your Kisan ID / Farmer ID number'),
              
              const SizedBox(height: HarvestSpacing.xxl),
              
              Text(
                'What happens to this data?',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: HarvestSpacing.sm),
              Text(
                isKisanIdPath
                    ? 'We use this to verify your identity. Your details are encrypted safely on your device. You can delete this data at any time from Settings.'
                    : 'Your details are encrypted safely on your device. We do not share this data. You can delete it at any time from Settings.',
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: HarvestSpacing.xs),
              
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showLearnMore = !_showLearnMore;
                  });
                },
                child: Row(
                  children: [
                    const Text(
                      'Learn more',
                      style: TextStyle(
                        color: HarvestColors.accent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      _showLearnMore ? Icons.expand_less : Icons.expand_more,
                      color: HarvestColors.accent,
                    ),
                  ],
                ),
              ),
              
              AnimatedSize(
                duration: MotionTokens.durationMicro,
                curve: MotionTokens.curveStandard,
                child: _showLearnMore
                    ? Padding(
                        padding: const EdgeInsets.only(top: HarvestSpacing.md),
                        child: Text(
                          'HarvestPro uses industry-standard AES-256 encryption to protect your data locally. No one else has access to this data unless you explicitly share it. Deleting your profile will permanently remove all associated local records.',
                          style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              
              const SizedBox(height: 48.0),
              
              if (_isSaving)
                const Center(child: CircularProgressIndicator())
              else ...[
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _onNotNow(isKisanIdPath),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md),
                          foregroundColor: Colors.grey.shade800,
                          side: BorderSide(color: Colors.grey.shade400, width: 2.0),
                        ),
                        child: const Text('Not now', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: HarvestSpacing.md),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _onAllow(profile),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md),
                          backgroundColor: HarvestColors.accent,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Allow', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: HarvestSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24.0)),
          const SizedBox(width: HarvestSpacing.md),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(text, style: context.textTheme.bodyLarge),
            ),
          ),
        ],
      ),
    );
  }
}
