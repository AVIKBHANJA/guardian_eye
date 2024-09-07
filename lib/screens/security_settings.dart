import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SecuritySettings extends StatefulWidget {
  const SecuritySettings({super.key});

  @override
  State<SecuritySettings> createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isTwoFactorEnabled = false;
  bool isVerifying = false;

  // For storing the phone number
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Two-Factor Authentication',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Enable Two-Factor Authentication'),
              value: isTwoFactorEnabled,
              onChanged: (bool value) async {
                setState(() {
                  isVerifying = true;
                });

                if (value) {
                  // Enabling 2FA via phone verification
                  await _verifyPhoneNumber(context);
                } else {
                  // Disable 2FA logic
                  setState(() {
                    isTwoFactorEnabled = false;
                  });
                  _showSnackBar(context, 'Two-Factor Authentication Disabled');
                }

                setState(() {
                  isVerifying = false;
                });
              },
            ),
            if (isVerifying) const CircularProgressIndicator(),
            const SizedBox(height: 20),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyPhoneNumber(BuildContext context) async {
    final String phoneNumber = phoneController.text.trim();

    if (phoneNumber.isEmpty) {
      _showSnackBar(context, "Please enter a valid phone number.");
      return;
    }

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically signs the user in when verification is complete
          await _auth.currentUser!.linkWithCredential(credential);
          setState(() {
            isTwoFactorEnabled = true;
          });
          _showSnackBar(context, 'Two-Factor Authentication Enabled');
        },
        verificationFailed: (FirebaseAuthException e) {
          _showSnackBar(context, 'Verification Failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          // Handle code input by the user
          _handleCodeSent(context, verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout handler
        },
      );
    } catch (e) {
      _showSnackBar(context, 'Error: $e');
    }
  }

  Future<void> _handleCodeSent(
      BuildContext context, String verificationId) async {
    String smsCode = await _getSmsCodeFromUser(context);

    if (smsCode.isNotEmpty) {
      // Create a phone auth credential
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      // Link the credential to the current user to enable 2FA
      try {
        await _auth.currentUser!.linkWithCredential(credential);
        setState(() {
          isTwoFactorEnabled = true;
        });
        _showSnackBar(context, 'Two-Factor Authentication Enabled');
      } catch (e) {
        _showSnackBar(context, 'Error linking credential: $e');
      }
    }
  }

  Future<String> _getSmsCodeFromUser(BuildContext context) async {
    // This function should show a dialog or another UI element to let the user enter the OTP
    String smsCode = ''; // Replace this with actual user input logic
    // For the sake of this example, you could use a TextEditingController in a dialog for input
    return smsCode;
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
