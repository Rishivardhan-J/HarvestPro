import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/providers/repositories_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../data/models/post.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/streak_visual.dart';

final communityFeedProvider = FutureProvider.autoDispose<List<Post>>((ref) async {
  final profileAsync = ref.watch(activeFarmerProfileProvider);
  final profile = profileAsync.valueOrNull;
  if (profile == null) {
    return [];
  }
  
  final repo = ref.watch(communityRepositoryProvider);
  return repo.getFeed(profile.village, profile.district);
});

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  Future<void> _handleReport(BuildContext context, WidgetRef ref, String postId) async {
    final repo = ref.read(communityRepositoryProvider);
    await repo.reportPost(postId);
    ref.invalidate(communityFeedProvider);
    
    if (!context.mounted) {
      return;
    }
    
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.community_reportAck),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleHelplineCall(BuildContext context, AppLocalizations l10n) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.community_helplineMock),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedAsync = ref.watch(communityFeedProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.community_title),
      ),
      body: feedAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (posts) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: StreakVisual(),
              ),
              if (posts.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.people_outline, size: 80, color: HarvestColors.inkLight),
                        const SizedBox(height: HarvestSpacing.lg),
                        Text(l10n.community_emptyFeed, style: context.textTheme.headlineMedium),
                      ],
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final post = posts[index];
                      return _buildPostCard(context, ref, post, l10n);
                    },
                    childCount: posts.length,
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(HarvestSpacing.md),
                  child: Column(
                    children: [
                      const Divider(),
                      const SizedBox(height: HarvestSpacing.sm),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.support_agent),
                        label: Text(l10n.community_helplineExpert),
                        onPressed: () => _handleHelplineCall(context, l10n),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                        ),
                      ),
                      const SizedBox(height: HarvestSpacing.sm),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.phone),
                        label: Text(l10n.community_helplinePerson),
                        onPressed: () => _handleHelplineCall(context, l10n),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, WidgetRef ref, Post post, AppLocalizations l10n) {
    // Mock "Most helpful contributor" badge
    final isHelpful = post.authorProfileId.contains('1'); 
    
    // Mock social proof (e.g. 3 farmers near you...) for observation posts
    final isObservation = post.postType == PostType.observation;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: HarvestSpacing.md, vertical: HarvestSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(HarvestSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: HarvestColors.accent.withValues(alpha: 0.2),
                  child: const Icon(Icons.person, color: HarvestColors.accent),
                ),
                const SizedBox(width: HarvestSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.authorDisplayName, style: context.textTheme.titleMedium),
                      if (isHelpful)
                        Text(
                          l10n.community_helpfulBadge(12),
                          style: context.textTheme.bodySmall?.copyWith(color: HarvestColors.statusGood),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.flag_outlined, size: 20),
                  color: HarvestColors.inkLight,
                  onPressed: () => _handleReport(context, ref, post.id),
                  tooltip: 'Report',
                ),
              ],
            ),
            const SizedBox(height: HarvestSpacing.sm),
            Text(post.contentText, style: context.textTheme.bodyLarge),
            if (isObservation) ...[
              const SizedBox(height: HarvestSpacing.sm),
              Container(
                padding: const EdgeInsets.all(HarvestSpacing.xs),
                decoration: BoxDecoration(
                  color: HarvestColors.accent.withValues(alpha: 0.1),
                  borderRadius: HarvestRadius.sm,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.group, size: 16, color: HarvestColors.accent),
                    const SizedBox(width: HarvestSpacing.xs),
                    Expanded(
                      child: Text(
                        l10n.community_farmersReportedThis(3),
                        style: context.textTheme.bodySmall?.copyWith(color: HarvestColors.accent),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
