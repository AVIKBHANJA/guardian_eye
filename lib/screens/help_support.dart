import 'package:flutter/material.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Help Topics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('How to use the app'),
                    leading: const Icon(Icons.help_outline),
                    onTap: () {
                      // Navigate to a page with more information
                    },
                  ),
                  ListTile(
                    title: const Text('Account management'),
                    leading: const Icon(Icons.person),
                    onTap: () {
                      // Navigate to a page with more information
                    },
                  ),
                  ListTile(
                    title: const Text('Privacy & Security'),
                    leading: const Icon(Icons.lock),
                    onTap: () {
                      // Navigate to a page with more information
                    },
                  ),
                  ListTile(
                    title: const Text('Payment Issues'),
                    leading: const Icon(Icons.payment),
                    onTap: () {
                      // Navigate to a page with more information
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Handle email support
              },
              icon: const Icon(Icons.email),
              label: const Text('Email Support'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Handle phone support
              },
              icon: const Icon(Icons.phone),
              label: const Text('Call Support'),
            ),
          ],
        ),
      ),
    );
  }
}
