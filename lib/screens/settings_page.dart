import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.purple, // AppBar color
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 10),

          // Profile Settings
          SettingsSection(
            title: 'Profile',
            tiles: [
              SettingsTile(
                icon: Icons.person,
                title: 'Edit Profile',
                subtitle: 'Update your name, email, and more',
                onTap: () {
                  Navigator.pushNamed(context, '/edit-profile');
                },
              ),
              SettingsTile(
                icon: Icons.lock,
                title: 'Change Password',
                subtitle: 'Update your password',
                onTap: () {
                  Navigator.pushNamed(context, '/change-password');
                },
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Notification Settings
          SettingsSection(
            title: 'Notifications',
            tiles: [
              SettingsTile(
                icon: Icons.notifications,
                title: 'Push Notifications',
                subtitle: 'Manage push notification preferences',
                onTap: () {
                  Navigator.pushNamed(context, '/notification-settings');
                },
              ),
              SettingsTile(
                icon: Icons.email,
                title: 'Email Notifications',
                subtitle: 'Manage email notification preferences',
                onTap: () {
                  Navigator.pushNamed(context, '/email-notifications');
                },
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Privacy & Security Settings
          SettingsSection(
            title: 'Privacy & Security',
            tiles: [
              SettingsTile(
                icon: Icons.privacy_tip,
                title: 'Privacy Settings',
                subtitle: 'Manage your privacy settings',
                onTap: () {
                  Navigator.pushNamed(context, '/privacy-settings');
                },
              ),
              SettingsTile(
                icon: Icons.security,
                title: 'Security',
                subtitle: 'Manage security settings',
                onTap: () {
                  Navigator.pushNamed(context, '/security-settings');
                },
              ),
            ],
          ),

          const SizedBox(height: 20),

          // General Settings
          SettingsSection(
            title: 'General',
            tiles: [
              SettingsTile(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'Select your preferred language',
                onTap: () {
                  Navigator.pushNamed(context, '/language-settings');
                },
              ),
              SettingsTile(
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'Get help and support',
                onTap: () {
                  Navigator.pushNamed(context, '/help-support');
                },
              ),
              SettingsTile(
                icon: Icons.info_outline,
                title: 'About Us',
                subtitle: 'Learn more about the app',
                onTap: () {
                  Navigator.pushNamed(context, '/about-us');
                },
              ),
              SettingsTile(
                icon: Icons.person,
                title: 'Terms and Condition',
                subtitle: 'About the terms',
                onTap: () {
                  Navigator.pushNamed(context, '/terms-and-conditions');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// A widget to create a section in the settings page
class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  const SettingsSection({
    super.key,
    required this.title,
    required this.tiles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.purple, // Section title color
          ),
        ),
        const SizedBox(height: 10),
        ...tiles,
      ],
    );
  }
}

// A widget to create individual settings tile
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple), // Icon color
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}