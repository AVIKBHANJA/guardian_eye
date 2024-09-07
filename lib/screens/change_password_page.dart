import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ChangePasswordPage({super.key});

  Future<void> _changePassword(BuildContext context) async {
    // Show a confirmation dialog
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Password Change'),
          content: const Text('Are you sure you want to change your password?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false); // User pressed Cancel
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(true); // User pressed Confirm
              },
            ),
          ],
        );
      },
    );

    // If the user confirmed, proceed with password reset
    if (confirm == true) {
      try {
        final user = _auth.currentUser;

        if (user != null && user.email != null) {
          await _auth.sendPasswordResetEmail(email: user.email!);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Password reset email sent to ${user.email}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user is currently signed in.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _changePassword(context),
          child: const Text('Change Password'),
        ),
      ),
    );
  }
}
