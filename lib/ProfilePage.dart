import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_assist/ChatPage.dart';
import 'package:step_assist/HomePage.dart';
import 'package:step_assist/LoginPage.dart';
import 'package:step_assist/PersonalInfoPage.dart';
import 'package:step_assist/AccessibilityPage.dart';
import 'package:step_assist/MedicalRecordsPage.dart';
import 'package:step_assist/SettingsPage.dart';

class ProfilePage extends StatefulWidget {
  // Remove darkMode and toggleDarkMode from the constructor
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  // Load the saved profile image from SharedPreferences
  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('profileImage');
      if (_imagePath != null) {
        _profileImage = File(_imagePath!);
      }
    });
  }

  // Save the image to local storage and SharedPreferences
  Future<void> _saveProfileImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/profile_image.jpg';
    await image.copy(imagePath);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('profileImage', imagePath);

    setState(() {
      _profileImage = image;
    });
  }

  // Pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    // Show dialog to choose from camera or gallery
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Profile Picture'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () async {
                  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    _saveProfileImage(File(image.path));
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    _saveProfileImage(File(image.path));
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.blue, // Default color (no dark mode)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile image with the option to change it
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage == null
                    ? AssetImage('assets/profile_placeholder.png')
                    : FileImage(_profileImage!) as ImageProvider,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Zara Conter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'zaraconter1@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Personal Information'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PersonalInfoPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.accessibility),
                    title: const Text('Accessibility Options'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AccessibilityPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.health_and_safety),
                    title: const Text('Medical Records'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MedicalRecordsPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text('Log Out', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.grey,
        unselectedItemColor: Color.fromARGB(255, 164, 162, 162),
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ChatPage()),
            );
          }
        },
      ),
    );
  }
}
