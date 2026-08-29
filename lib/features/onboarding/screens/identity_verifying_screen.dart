import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/providers/connectivity_provider.dart';
import '../../../core/providers/repositories_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/theme/motion_tokens.dart';
import '../../../data/models/farmer_profile.dart';
import '../../../shared_widgets/error_state.dart';
import 'identity_choice_screen.dart';

class IdentityVerifyingScreen extends ConsumerStatefulWidget {
  const IdentityVerifyingScreen({super.key});

  @override
  ConsumerState<IdentityVerifyingScreen> createState() => _IdentityVerifyingScreenState();
}

class _IdentityVerifyingScreenState extends ConsumerState<IdentityVerifyingScreen> {
  bool _isLoading = true;
  String? _error;
  FarmerProfile? _fetchedProfile;

  @override
  void initState() {
    super.initState();
    _verifyId();
  }

  Future<void> _verifyId() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final kisanId = ref.read(enteredKisanIdProvider);
      if (kisanId == null || kisanId.isEmpty) {
        throw Exception('No Kisan ID found to verify');
      }

      final connectivity = ref.read(connectivityProvider);
      if (connectivity == AppConnectivityState.offline) {
        throw Exception('offline');
      }

      final repo = ref.read(farmerProfileRepositoryProvider);
      final profile = await repo.getProfileByKisanId(kisanId);
      
      if (!mounted) {
        return;
      }
      
      setState(() {
        _isLoading = false;
        _fetchedProfile = profile;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  void _onRetry() {
    ref.read(onboardingStateProvider.notifier).advanceToIdentityChoice();
  }

  void _onContinueWithoutIt() {
    ref.read(onboardingStateProvider.notifier).advanceToManualEntry();
  }

  void _onLooksRight() {
    // If looks right, we proceed to consent
    // We should save the profile data into a provider so the final step can persist it, 
    // but the prompt says "Allow -> proceeds to mock AgriStack pull (Part B) and on to complete."
    // Actually, we fetch the profile here in Part B.
    // So we need to store it temporarily to save it later.
    ref.read(verifiedProfileProvider.notifier).state = _fetchedProfile;
    ref.read(onboardingStateProvider.notifier).advanceToConsent();
  }

  Widget _buildLoadingState(String? kisanId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Please enter your 11-digit Kisan ID',
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(height: HarvestSpacing.md),
        TextField(
          enabled: false,
          controller: TextEditingController(text: kisanId ?? ''),
          style: context.textTheme.bodyLarge?.copyWith(fontSize: 18.0, letterSpacing: 2.0, color: context.theme.disabledColor),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              ),
              SizedBox(width: HarvestSpacing.sm),
              Text('Verifying...', style: TextStyle(fontSize: 16.0)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return ErrorState(
      message: _error == 'Exception: offline' 
          ? "You're offline. Please check your connection to verify your Kisan ID, or continue without it for now."
          : "We couldn't verify that ID. You can try again, or continue without it for now.",
      onRetry: _onRetry,
      alternativeActionLabel: 'Continue without it',
      onAlternativeAction: _onContinueWithoutIt,
    );
  }

  Widget _buildSuccessState() {
    final profile = _fetchedProfile!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('We found your details', style: context.textTheme.titleLarge),
        const SizedBox(height: HarvestSpacing.xl),
        _StaggeredProfileCard(profile: profile),
        const Spacer(),
        ElevatedButton(
          onPressed: _onLooksRight,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md),
            backgroundColor: HarvestColors.accent,
            foregroundColor: Colors.white,
          ),
          child: const Text('Looks right, continue', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final kisanId = ref.watch(enteredKisanIdProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(HarvestSpacing.xl),
          child: _isLoading
              ? _buildLoadingState(kisanId)
              : _error != null
                  ? _buildErrorState()
                  : _buildSuccessState(),
        ),
      ),
    );
  }
}

class _StaggeredProfileCard extends StatefulWidget {
  final FarmerProfile profile;
  
  const _StaggeredProfileCard({required this.profile});

  @override
  State<_StaggeredProfileCard> createState() => _StaggeredProfileCardState();
}

class _StaggeredProfileCardState extends State<_StaggeredProfileCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: MotionTokens.durationFor(context, const Duration(milliseconds: 600)),
    );
    _controller.forward();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedRow(int index, String label, String value) {
    // 60ms stagger per field per the prompt
    final start = (index * 0.1).clamp(0.0, 1.0);
    final end = (start + 0.5).clamp(0.0, 1.0);
    
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(start, end, curve: MotionTokens.curveStandard),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(animation),
        child: Padding(
          padding: const EdgeInsets.only(bottom: HarvestSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: Text(label, style: const TextStyle(color: Colors.grey))),
              Expanded(flex: 3, child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(HarvestSpacing.md),
        child: Column(
          children: [
            _buildAnimatedRow(0, 'Name', widget.profile.name),
            _buildAnimatedRow(1, 'Village', widget.profile.village),
            _buildAnimatedRow(2, 'Primary Crop', widget.profile.primaryCrop),
            _buildAnimatedRow(3, 'Land Size', '${widget.profile.landSizeAcres} Acres'),
          ],
        ),
      ),
    );
  }
}

// Temporary provider to hold the verified profile data before consent saves it
final verifiedProfileProvider = StateProvider<FarmerProfile?>((ref) => null);
