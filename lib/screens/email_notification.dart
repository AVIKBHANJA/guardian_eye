import 'package:flutter/material.dart';

class EmailNotification extends StatefulWidget {
  const EmailNotification({super.key});

  @override
  State<EmailNotification> createState() => _EmailNotificationState();
}

class _EmailNotificationState extends State<EmailNotification> {
  bool newEmailNotifications = true;
  bool promotionalEmails = false;
  bool updatesNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Notification Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text('New Email Notifications'),
            subtitle: const Text('Receive notifications for new emails'),
            value: newEmailNotifications,
            onChanged: (bool value) {
              setState(() {
                newEmailNotifications = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Promotional Emails'),
            subtitle:
                const Text('Receive notifications for promotional emails'),
            value: promotionalEmails,
            onChanged: (bool value) {
              setState(() {
                promotionalEmails = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Updates and News'),
            subtitle: const Text('Receive notifications for updates and news'),
            value: updatesNotifications,
            onChanged: (bool value) {
              setState(() {
                updatesNotifications = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
