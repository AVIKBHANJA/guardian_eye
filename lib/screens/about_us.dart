import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Our Mission'),
            subtitle: Text(
                'At Guardian Eye, we are dedicated to empowering women with the tools they need to stay safe and secure in their everyday lives. Our mission is to provide a comprehensive safety solution that combines cutting-edge technology with community support to create a safer world for women everywhere.'),
          ),
          ListTile(
            title: Text('Who We Are'),
            subtitle: Text(
                'Guardian Eye was founded by a passionate team of tech innovators, safety experts, and advocates who believe that everyone deserves to feel safe and confident in their surroundings. We come from diverse backgrounds, including technology, social work, and advocacy, but we share a common goal: to make safety accessible and effective for all women.'),
          ),
          ListTile(
            title: Text('What We Do'),
            subtitle: Text(
                'Our app is crafted with the utmost emphasis on both safety and user experience, setting us apart with several standout features. With Real-Time Alerts, you can instantly notify trusted contacts or emergency services with just a few taps, ensuring help is always within reach. The Location Tracking feature allows you to share your whereabouts with friends and family, adding an extra layer of reassurance. Our comprehensive Safety Features include emergency SOS buttons, valuable safety tips, and quick access to local resources, all designed to provide you with immediate support when you need it most. '),
          ),
          ListTile(
            title: Text('Join Us'),
            subtitle: Text(
                'We invite you to be part of our community and help us make the world a safer place for women. Whether you’re a user, advocate, or partner, your support is crucial in driving change and improving safety standards.Thank you for choosing Guardian Eye. Together, we can make a difference.'),
          ),
        ],
      ),
    );
  }
}
