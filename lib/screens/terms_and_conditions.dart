import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('User Eligibility'),
            subtitle: Text('The app is intended for individuals aged 18 and above. Users must provide accurate personal information during registration.'),
          ),
          ListTile(
            title: Text('Privacy Policy'),
            subtitle: Text('User data will be collected and stored securely. Personal information will not be shared with third parties without consent, except as required by law.'),
          ),
          ListTile(
            title: Text('Emergency Services'),
            subtitle: Text('The app provides a feature to contact emergency services. Users must ensure that their location services are enabled for accurate assistance.'),
          ),
          ListTile(
            title: Text('User Conduct'),
            subtitle: Text('Users are expected to use the app responsibly and not engage in any form of harassment or abuse towards others.'),
          ),
          ListTile(
            title: Text('Liability Disclaimer'),
            subtitle: Text('The app developers are not liable for any incidents that occur while using the app. Users are encouraged to take personal safety precautions.'),
          ),
          ListTile(
            title: Text('Updates and Modifications'),
            subtitle: Text('The terms and conditions may be updated periodically. Users will be notified of significant changes.'),
          ),
          ListTile(
            title: Text('Termination of Service'),
            subtitle: Text('The app reserves the right to suspend or terminate accounts that violate these terms.'),
          ),
        ],
      ),
    );
  }
}