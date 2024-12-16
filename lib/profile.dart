import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "John Doe";
  String userEmail = "johndoe@university.com";
  String userPhone = "+8801234567890";
  String profilePicture =
      'https://www.example.com/profile.jpg'; // Placeholder profile image

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with current user data
    _nameController.text = userName;
    _emailController.text = userEmail;
    _phoneController.text = userPhone;
  }

  void _saveProfile() {
    setState(() {
      userName = _nameController.text;
      userEmail = _emailController.text;
      userPhone = _phoneController.text;
    });
    // You can integrate backend to save the updated information here
  }

  void _updateProfilePicture() {
    // Here, you can allow the user to update the profile picture by selecting an image from the gallery or camera
    setState(() {
      profilePicture =
      'https://www.example.com/new_profile.jpg'; // Placeholder for the new profile picture URL
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Profile picture
            GestureDetector(
              onTap: _updateProfilePicture,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(profilePicture),
              ),
            ),
            SizedBox(height: 20),
            // User details form
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            SizedBox(height: 30),
            // Save button
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
