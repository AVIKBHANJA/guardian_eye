import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _guardian1NameController =
      TextEditingController();
  final TextEditingController _guardian1PhoneController =
      TextEditingController();
  final TextEditingController _guardian1EmailController =
      TextEditingController();
  final TextEditingController _guardian2NameController =
      TextEditingController();
  final TextEditingController _guardian2PhoneController =
      TextEditingController();
  final TextEditingController _guardian2EmailController =
      TextEditingController();
  final TextEditingController _primaryAddressController =
      TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  bool _addSecondGuardian = false; // Toggle for second guardian

  File? _profileImage;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _guardian1NameController.dispose();
    _guardian1PhoneController.dispose();
    _guardian1EmailController.dispose();
    _guardian2NameController.dispose();
    _guardian2PhoneController.dispose();
    _guardian2EmailController.dispose();
    _primaryAddressController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      _emailController.text = user.email ?? '';
      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          _nameController.text = userDoc.get('name') ?? '';
          _phoneController.text = userDoc.get('phone') ?? '';
          _guardian1NameController.text = userDoc.get('guardian1Name') ?? '';
          _guardian1PhoneController.text = userDoc.get('guardian1Phone') ?? '';
          _guardian1EmailController.text = userDoc.get('guardian1Email') ?? '';
          _guardian2NameController.text = userDoc.get('guardian2Name') ?? '';
          _guardian2PhoneController.text = userDoc.get('guardian2Phone') ?? '';
          _guardian2EmailController.text = userDoc.get('guardian2Email') ?? '';
          _primaryAddressController.text = userDoc.get('primaryAddress') ?? '';
          _profileImageUrl = userDoc.get('profileImageUrl') ?? '';
        });
      }
    }
  }

  bool _isValidPhoneNumber(String phone) {
    final RegExp phoneRegex = RegExp(r'^[0-9]{10}$'); // 10-digit phone number
    return phoneRegex.hasMatch(phone);
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadProfileImage(User user) async {
    if (_profileImage != null) {
      final Reference ref = _storage.ref().child('profile_images/${user.uid}');
      await ref.putFile(_profileImage!);
      _profileImageUrl = await ref.getDownloadURL();
    }
  }

  Future<void> _saveProfileChanges() async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Validate phone number
    if (!_isValidPhoneNumber(_phoneController.text.trim())) {
      setState(() {
        _errorMessage = 'Please enter a valid 10-digit phone number.';
        _isLoading = false;
      });
      return;
    }

    try {
      // Upload profile image if selected
      await _uploadProfileImage(user);

      // Update user details in Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'guardian1Name': _guardian1NameController.text.trim(),
        'guardian1Phone': _guardian1PhoneController.text.trim(),
        'guardian1Email': _guardian1EmailController.text.trim(),
        if (_addSecondGuardian) ...{
          'guardian2Name': _guardian2NameController.text.trim(),
          'guardian2Phone': _guardian2PhoneController.text.trim(),
          'guardian2Email': _guardian2EmailController.text.trim(),
        },
        'primaryAddress': _primaryAddressController.text.trim(),
        if (_profileImageUrl != null) 'profileImageUrl': _profileImageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Updated')),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to update profile: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFFD1C4E9),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFF263238),
              Color(0xFF311B92),
              Color(0xFF4A148C),
              Color(0xFF9575CD),
              Color(0xFFB39DDB),
            ],
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: ListView(
                  children: <Widget>[
                    // Display profile picture
                    // Center(
                    //   child: GestureDetector(
                    //     onTap: _pickImage,
                    //     child: CircleAvatar(
                    //       radius: 50,
                    //       backgroundImage: _profileImage != null
                    //           ? FileImage(_profileImage!)
                    //           : (_profileImageUrl != null &&
                    //                   _profileImageUrl!.isNotEmpty)
                    //               ? NetworkImage(_profileImageUrl!)
                    //               : const AssetImage(
                    //                       'assets/default_avatar.png')
                    //                   as ImageProvider,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    _buildTextField(_nameController, 'Name'),
                    _buildTextField(_emailController, 'Email ID'),
                    _buildTextField(_phoneController, 'Phone Number'),
                    _buildTextField(
                        _guardian1NameController, 'Guardian 1\'s Name'),
                    _buildTextField(_guardian1PhoneController,
                        'Guardian 1\'s Phone Number'),
                    _buildTextField(
                        _guardian1EmailController, 'Guardian 1\'s Email ID'),
                    const SizedBox(height: 10),
                    // Toggle to show/hide second guardian
                    SwitchListTile(
                      title: const Text(
                        'Add Second Guardian',
                        style: TextStyle(color: Colors.white),
                      ),
                      value: _addSecondGuardian,
                      onChanged: (bool value) {
                        setState(() {
                          _addSecondGuardian = value;
                        });
                      },
                    ),
                    if (_addSecondGuardian) ...[
                      _buildTextField(
                          _guardian2NameController, 'Guardian 2\'s Name'),
                      _buildTextField(_guardian2PhoneController,
                          'Guardian 2\'s Phone Number'),
                      _buildTextField(
                          _guardian2EmailController, 'Guardian 2\'s Email ID'),
                    ],
                    _buildTextField(
                        _primaryAddressController, 'Primary Address'),
                    const SizedBox(height: 20),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _saveProfileChanges,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        style: const TextStyle(color: Colors.white),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
