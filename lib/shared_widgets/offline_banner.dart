import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/connectivity_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/design_tokens.dart';
import '../../core/theme/motion_tokens.dart';

class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityState = ref.watch(connectivityProvider);
    
    ref.listen<AppConnectivityState>(connectivityProvider, (previous, next) {
      if (previous != null && previous != next) {
        if (next == AppConnectivityState.offline) {
          SemanticsService.sendAnnouncement(View.of(context), 'You are currently offline', Directionality.of(context));
        } else if (next == AppConnectivityState.online) {
          SemanticsService.sendAnnouncement(View.of(context), 'You are back online', Directionality.of(context));
        }
      }
    });

    final isOffline = connectivityState == AppConnectivityState.offline;

    return AnimatedSize(
      duration: MotionTokens.durationFor(context, MotionTokens.durationStandard),
      curve: MotionTokens.curveStandard,
      child: isOffline
          ? Container(
              width: double.infinity,
              color: HarvestColors.statusCaution,
              padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.sm, horizontal: HarvestSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 16, color: HarvestColors.inkDark),
                  const SizedBox(width: HarvestSpacing.sm),
                  Text(
                    "Showing yesterday's update — reconnect to refresh",
                    style: context.textTheme.labelMedium?.copyWith(color: HarvestColors.inkDark),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : const SizedBox(width: double.infinity, height: 0),
    );
  }
}
