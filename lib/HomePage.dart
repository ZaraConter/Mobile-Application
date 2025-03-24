import 'dart:async';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_assist/ProfilePage.dart';
import 'SignUpPage.dart';
import 'ChatPage.dart'; // Add ChatPage import
import 'LoginPage.dart'; // Add LoginPage import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(), // Starting screen is HomePage
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1; // Default to Home
  bool _showNotification = true;
  double _opacity = 1.0; // For fading effect
  final TextEditingController _controller = TextEditingController(); // Chat input controller
  List<String> messages = []; // Chat messages

  @override
  void initState() {
    super.initState();
    // Timer to hide notification after 5 seconds
    Timer(const Duration(seconds: 5), () {
      setState(() {
        _opacity = 0.0; // Start fading out
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _showNotification = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF008080),
        title: const Text(
          'StepAssist',
          style: TextStyle(
            fontFamily: 'YourCustomFont',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _currentIndex == 2
            ? _buildChatSection()
            : SingleChildScrollView(
                child: _buildMainContent(screenWidth, screenHeight),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.grey,
        unselectedItemColor: const Color.fromARGB(255, 164, 162, 162),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatPage()),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ProfilePage()),
              );
            }
          });
        },
      ),
      drawer: _buildDrawer(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF008080)),
              child: Text(
                'StepAssist',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'YourCustomFont',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildDrawerItem('Your Profile', Icons.account_circle),
            _buildDrawerItem('App Accessibility', Icons.accessibility_new),
            _buildDrawerItem('Device Settings', Icons.devices),
            _buildDrawerItem('FAQs', Icons.help),
            _buildDrawerItem('App Feedback', Icons.feedback),
            _buildDrawerItem('Privacy Policy', Icons.privacy_tip),
            _buildDrawerItem('Terms of Use', Icons.article),
            _buildLogoutItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF008080)),
      title: Text(title, style: const TextStyle(fontSize: 16, fontFamily: 'YourCustomFont')),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildLogoutItem() {
    return ListTile(
      leading: const Icon(Icons.logout, color: Color(0xFF008080)),
      title: const Text('Log Out', style: TextStyle(fontSize: 16, fontFamily: 'YourCustomFont')),
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
    );
  }

  Widget _buildMainContent(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Explore Features',
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF008080),
              fontFamily: 'YourCustomFont',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatSection() {
    return Column(
      children: [
        _showNotification
            ? AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 500),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'You have new messages',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(messages[index]));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(hintText: 'Type a message'),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  setState(() {
                    messages.add(_controller.text);
                    _controller.clear();
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
