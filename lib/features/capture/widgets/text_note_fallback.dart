import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/providers/app_state_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../data/models/capture_artifact.dart';
import '../../../data/repositories/capture_repository.dart';
import '../../../l10n/app_localizations.dart';

class TextNoteFallback extends ConsumerStatefulWidget {
  final VoidCallback onSubmitted;
  
  const TextNoteFallback({super.key, required this.onSubmitted});

  @override
  ConsumerState<TextNoteFallback> createState() => _TextNoteFallbackState();
}

class _TextNoteFallbackState extends ConsumerState<TextNoteFallback> {
  final _controller = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitNote() async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final profile = ref.read(activeFarmerProfileProvider).valueOrNull;
      if (profile == null) {
        throw Exception('No active profile');
      }

      final artifact = CaptureArtifact(
        id: const Uuid().v4(),
        farmerProfileId: profile.id,
        type: CaptureType.textNote,
        textContent: text,
        createdAt: DateTime.now(),
      );

      await ref.read(captureRepositoryProvider).saveArtifact(artifact);
      widget.onSubmitted();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Padding(
      padding: const EdgeInsets.all(HarvestSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.edit_note, size: 64, color: HarvestColors.accent),
          const SizedBox(height: HarvestSpacing.md),
          Text(
            l10n.capture_instructionText,
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: HarvestSpacing.lg),
          TextField(
            controller: _controller,
            maxLines: 5,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '...',
            ),
          ),
          const SizedBox(height: HarvestSpacing.xl),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submitNote,
              style: ElevatedButton.styleFrom(
                backgroundColor: HarvestColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md),
              ),
              child: _isSubmitting 
                ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white))
                : Text(l10n.capture_useTextButton),
            ),
          ),
        ],
      ),
    );
  }
}
