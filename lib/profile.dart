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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _fullNameController;
  late String _selectedGender;
  late TextEditingController _emailController;
  late TextEditingController _dobController;
  late TextEditingController _phoneController;

  late DatabaseReference _profileRef;
  late User _user;

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _profileRef.set({
        'full_name': _fullNameController.text,
        'gender': _selectedGender,
        'email': _emailController.text,
        'dob': _dobController.text,
        'phone': _phoneController.text,
      }).then((_) {
        widget.showMessage('Profile updated successfully!');
      }).catchError((error) {
        widget.showMessage('Failed to update profile: $error');
      });
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
        height: MediaQuery.of(context).size.height, // Set height to screen height
        width: MediaQuery.of(context).size.width, // Set width to screen width
        decoration:const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/profile.jpg'),
            fit: BoxFit.cover, // Adjust the fit to cover the whole page
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 600, // Set desired height for the form
            width: 300, // Set desired width for the form
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white, // Set background color to white
              borderRadius: BorderRadius.circular(10.0), // Add border radius
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue!;
                      });
                    },
                    items: <String>['Male', 'Female', 'Other']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Add email validation logic if needed
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _dobController,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your date of birth';
                      }
                      // Add date validation logic if needed
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      // Add phone number validation logic if needed
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Set background color to green
                      ),
                      child: const Text('Update'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
