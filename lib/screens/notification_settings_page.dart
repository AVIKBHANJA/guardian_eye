import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _notificationsEnabled = true; // Controls the overall notification toggle
  bool _soundEnabled = true; // Controls the notification sound toggle
  bool _emailUpdatesEnabled = true; // Controls the email updates toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Enable Notifications'),
            subtitle: const Text('Turn on or off all notifications'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Notification Sound'),
            subtitle: const Text('Enable or disable notification sound'),
            value: _soundEnabled,
            onChanged: _notificationsEnabled
                ? (bool value) {
                    setState(() {
                      _soundEnabled = value;
                    });
                  }
                : null, // Disable switch when notifications are off
          ),
          SwitchListTile(
            title: const Text('Email Updates'),
            subtitle: const Text('Receive notifications via email'),
            value: _emailUpdatesEnabled,
            onChanged: _notificationsEnabled
                ? (bool value) {
                    setState(() {
                      _emailUpdatesEnabled = value;
                    });
                  }
                : null, // Disable switch when notifications are off
          ),
          ListTile(
            title: const Text('Notification Preferences'),
            subtitle: const Text('Customize your notification preferences'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to a more detailed notification preferences page
            },
          ),
        ],
      ),
    );
  }
}
