import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfilePage extends StatefulWidget {
  final void Function(String message) showMessage;

  const ProfilePage({super.key, required this.showMessage});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _fullNameController;
  late String _selectedGender;
  late TextEditingController _emailController;
  late TextEditingController _dobController;
  late TextEditingController _phoneController;

  late DatabaseReference _profileRef;
  late User _user;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _selectedGender = 'Male'; // Default value
    _emailController = TextEditingController();
    _dobController = TextEditingController();
    _phoneController = TextEditingController();

    _user = FirebaseAuth.instance.currentUser!;
    _profileRef = FirebaseDatabase.instance.ref().child('profiles').child(_user.uid);


    _loadProfileData();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _loadProfileData() async {
    try {
      DataSnapshot snapshot = (await _profileRef.once()) as DataSnapshot;
      if (snapshot.value != null) {
        Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;

        setState(() {
          _fullNameController.text = data['full_name'] ?? '';
          _selectedGender = data['gender'] ?? 'Male';
          _emailController.text = data['email'] ?? '';
          _dobController.text = data['dob'] ?? '';
          _phoneController.text = data['phone'] ?? '';
        });
      }
    } catch (error) {
      // Handle error here
      widget.showMessage('Error loading profile data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/profile.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 500,
            width: 300,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileField('Full Name', _fullNameController.text),
                _buildProfileField('Email', _emailController.text),
                _buildProfileField('Phone Number', _phoneController.text),
                _buildProfileField('Gender', _selectedGender),
                _buildProfileField('Date of Birth', _dobController.text),
                const SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEditing = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreenAccent,
                    ),
                    child: const Text(
                        'Edit',
                    style: TextStyle(fontSize: 28),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
