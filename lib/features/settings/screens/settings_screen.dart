import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/localization/locale_provider.dart';
import '../../../core/providers/data_saver_provider.dart';
import '../../home/providers/home_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final voiceEnabled = ref.watch(voiceNarrationEnabledProvider);
    final dataSaverEnabled = ref.watch(dataSaverEnabledProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: Text(locale.languageCode.toUpperCase()),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/settings/language'),
          ),
          const Divider(height: 1),
          SwitchListTile(
            secondary: const Icon(Icons.volume_up),
            title: const Text('Voice Narration'),
            subtitle: const Text('Automatically read aloud screens'),
            value: voiceEnabled,
            onChanged: (val) => ref.read(voiceNarrationEnabledProvider.notifier).toggle(),
          ),
          const Divider(height: 1),
          SwitchListTile(
            secondary: const Icon(Icons.data_usage),
            title: const Text('Data Saver Mode'),
            subtitle: const Text('Use less data by lowering image quality'),
            value: dataSaverEnabled,
            onChanged: (val) => ref.read(dataSaverEnabledProvider.notifier).toggle(),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Profiles'),
            subtitle: const Text('Switch or add a farmer profile'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/settings/profiles'),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Data & Privacy'),
            subtitle: const Text('Manage your data and account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/settings/data'),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text('Helpline'),
            subtitle: const Text('Contact support or a Krishi Expert'),
            trailing: const Icon(Icons.call),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Helpline mock. Please use Community screen for full options.')),
              );
            },
          ),
          const Divider(height: 1),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              final version = snapshot.data?.version ?? '1.0.0';
              return ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('App Version'),
                subtitle: Text(version),
              );
            },
          ),
        ],
      ),
    );
  }
}
