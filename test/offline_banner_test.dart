import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/core/providers/connectivity_provider.dart';
import 'package:harvestpro/shared_widgets/offline_banner.dart';

void main() {
  testWidgets('OfflineBanner displays when offline', (WidgetTester tester) async {
    final container = ProviderContainer();
    container.read(connectivityProvider.notifier).state = AppConnectivityState.offline;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                OfflineBanner(),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text("Showing yesterday's update — reconnect to refresh"), findsOneWidget);
    expect(find.byIcon(Icons.wifi_off), findsOneWidget);
  });

  testWidgets('OfflineBanner is hidden when online', (WidgetTester tester) async {
    final container = ProviderContainer();
    container.read(connectivityProvider.notifier).state = AppConnectivityState.online;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                OfflineBanner(),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text("Showing yesterday's update — reconnect to refresh"), findsNothing);
    expect(find.byIcon(Icons.wifi_off), findsNothing);
  });
}
