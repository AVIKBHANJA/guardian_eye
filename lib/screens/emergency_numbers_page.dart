import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmergencyNumbersPage extends StatefulWidget {
  const EmergencyNumbersPage({super.key});

  @override
  State<EmergencyNumbersPage> createState() => _EmergencyNumbersPageState();
}

class _EmergencyNumbersPageState extends State<EmergencyNumbersPage> {
   final List<TextEditingController> _phoneControllers = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadEmergencyNumbers(); // Load the numbers when the page initializes
  }

  Future<void> _loadEmergencyNumbers() async {
    final User? user = _auth.currentUser;
    if (user == null) return; // Ensure the user is logged in

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Fetch the user's saved emergency numbers
      final DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;
        final List<String> emergencyNumbers = List<String>.from(data['emergencyNumbers'] ?? []);

        // Populate the controllers with the saved phone numbers
        for (String number in emergencyNumbers) {
          _phoneControllers.add(TextEditingController(text: number));
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load emergency numbers.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveEmergencyNumbers() async {
    final User? user = _auth.currentUser;
    if (user == null) return; // Ensure the user is logged in

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Collect all phone numbers from the controllers
      final List<String> phoneNumbers = _phoneControllers
          .map((controller) => controller.text.trim())
          .toList();

      // Check if any of the phone numbers are invalid
      for (String phone in phoneNumbers) {
        if (!_isValidPhoneNumber(phone)) {
          setState(() {
            _errorMessage = 'Please enter valid phone numbers.';
          });
          _isLoading = false;
          return;
        }
      }

      // Save the updated emergency numbers in Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'emergencyNumbers': phoneNumbers,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Emergency numbers saved successfully')),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred while saving emergency numbers.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isValidPhoneNumber(String phone) {
    final RegExp regex = RegExp(r'^\d{10}$');
    return regex.hasMatch(phone);
  }

  void _addAnotherPhoneNumber() {
    setState(() {
      _phoneControllers.add(TextEditingController());
    });
  }

  void _removePhoneNumber(int index) {
    setState(() {
      _phoneControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Numbers'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Emergency Contacts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _phoneControllers.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextField(
                            controller: _phoneControllers[index],
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Phone No ${index + 1}',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => _removePhoneNumber(index),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
            if (!_isLoading)
              ElevatedButton(
                onPressed: _saveEmergencyNumbers,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text('Save Changes'),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addAnotherPhoneNumber,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Add Another No.'),
            ),
          ],
        ),
      ),
    );
  }
}