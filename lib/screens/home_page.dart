import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  get profileImageUrl => null;

  // This function sends an SOS alert. Since we cannot use location package,
  // it will simply notify the user or send an alert.
  Future<void> sendSOS() async {
    devtools.log('SOS Alert Sent!'); // Placeholder for actual SOS logic
  }

  // Function to handle logout
  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      devtools.log('Error during logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('GuardianEye',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Builder(builder: (context) {
              return GestureDetector(
                child: CircleAvatar(
                  backgroundImage: profileImageUrl != null
                      ? NetworkImage(profileImageUrl)
                      : null,
                  child: profileImageUrl == null
                      ? Text(
                          FirebaseAuth.instance.currentUser!.displayName![0],
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        )
                      : null,
                ),
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            }),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: profileImageUrl != null
                        ? NetworkImage(profileImageUrl)
                        : null,
                    child: profileImageUrl == null
                        ? Text(
                            FirebaseAuth.instance.currentUser!.displayName![0],
                            style: const TextStyle(
                                fontSize: 40, color: Colors.white),
                          )
                        : null,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    FirebaseAuth.instance.currentUser?.displayName ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser?.email ?? '',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('FAQ'),
              onTap: () => Navigator.pushNamed(context, '/chatscreen'),
            ),
            ListTile(
              leading: const Icon(Icons.car_crash),
              title: const Text('Book a Cab'),
              onTap: () => Navigator.pushNamed(context, '/book-cab'),
            ),
            ListTile(
              leading: const Icon(Icons.emergency),
              title: const Text('Emergency helpline'),
              onTap: () => Navigator.pushNamed(context, '/emergency'),
            ),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('Articles'),
              onTap: () => Navigator.pushNamed(context, '/article'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Image or Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.purpleAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                // Hero Section with Image
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Welcome back, stay safe!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/icon/security_icon.png',
                      width: 80,
                    ), // Add a relevant image
                  ],
                ),
                const SizedBox(height: 20),
                // Cards Section
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildFeatureCard(
                        context,
                        Icons.phone,
                        'Emergency Numbers',
                        '/emergency-numbers',
                      ),
                      _buildFeatureCard(
                        context,
                        Icons.directions_walk,
                        'Walk With Me',
                        '/walk-with-me',
                      ),
                      _buildFeatureCard(
                        context,
                        Icons.shield,
                        'Check Safety',
                        '/check-safety',
                      ),
                      _buildFeatureCard(
                        context,
                        Icons.security,
                        'Safety Techniques',
                        '/safety-techniques',
                      ),
                      _buildFeatureCard(
                        context,
                        Icons.forum,
                        'Community Blog',
                        '/blog',
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                ElevatedButton(
                  onPressed: sendSOS,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(20),
                    textStyle: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('SOS'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String label,
    String routeName,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.purple),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
