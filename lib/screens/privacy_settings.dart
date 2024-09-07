import 'package:flutter/material.dart';

class PrivacySettings extends StatelessWidget {
  const PrivacySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Account Privacy'),
            subtitle: const Text('Manage who can see your account details'),
            trailing: Switch(
              value: true, // Change based on state
              onChanged: (bool value) {
                // Handle the switch action
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.visibility_off),
            title: const Text('Activity Status'),
            subtitle: const Text('Control who sees your online status'),
            trailing: Switch(
              value: false, // Change based on state
              onChanged: (bool value) {
                // Handle the switch action
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_off),
            title: const Text('Muted Accounts'),
            subtitle: const Text('Manage accounts you have muted'),
            onTap: () {
              // Handle tap action
            },
          ),
          ListTile(
            leading: const Icon(Icons.block),
            title: const Text('Blocked Accounts'),
            subtitle: const Text('View and manage blocked accounts'),
            onTap: () {
              // Handle tap action
            },
          ),
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Report a Problem'),
            subtitle:
                const Text('Report privacy issues or inappropriate behavior'),
            onTap: () {
              // Handle tap action
            },
          ),
        ],
      ),
    );
  }
}
