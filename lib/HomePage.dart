import 'package:flutter/material.dart';
import 'dart:async'; // Import for Timer
import 'LoginPage.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
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
      // Delay removal of the notification
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _showNotification = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF008080), // Your theme color
        title: const Center(
          child: Text(
            'StepAssist',
            style: TextStyle(
              fontFamily: 'YourCustomFont', // Ensure your custom font is included in your pubspec.yaml
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: _currentIndex == 2 ? _buildChatSection() : _buildMainContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
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
        selectedItemColor: Colors.grey[800],
        unselectedItemColor: const Color.fromARGB(255, 164, 162, 162),
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current index
          });
        },
      ),
      drawer: _buildDrawer(), // Add the drawer widget
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
              decoration: BoxDecoration(
                color: Color(0xFF008080),
              ),
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
            _buildDrawerHeading('Preferences'),
            _buildDrawerItem('Your Profile', Icons.account_circle),
            _buildDrawerItem('App Accessibility', Icons.accessibility_new),
            _buildDrawerItem('Device Settings', Icons.devices),
            _buildDrawerItem('FAQs', Icons.help),
            _buildDrawerItem('App Feedback', Icons.feedback),
            _buildDrawerItem('Privacy Policy', Icons.privacy_tip),
            _buildDrawerItem('Terms of Use', Icons.article),
            _buildDrawerHeading('Help & Support'),
            _buildDrawerItem('How This App Works', Icons.info),
            _buildLogoutItem(), // Add logout item
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeading(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF008080)), // Add icon next to the title
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontFamily: 'YourCustomFont'),
      ),
      onTap: () {
        // Handle navigation here
        Navigator.pop(context); // Close the drawer after selection
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Add padding for a modern look
    );
  }

  Widget _buildLogoutItem() {
    return ListTile(
      leading: const Icon(Icons.logout, color: Color(0xFF008080)), // Log out icon
      title: const Text(
        'Log Out',
        style: TextStyle(fontSize: 16, fontFamily: 'YourCustomFont'),
      ),
      onTap: () {
        // Navigate to the LoginPage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    );
  }

  Widget _buildMainContent() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Center(
            child: Column(
              children: [
                // Quick Access Buttons
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  children: [
                    _buildQuickAccessButton(context, 'Find Ramps', Icons.map),
                    _buildQuickAccessButton(context, 'Contact Carer', Icons.call),
                    _buildQuickAccessButton(context, 'Emergency Helpline', Icons.local_phone),
                    _buildQuickAccessButton(context, 'Chat', Icons.chat),
                  ],
                ),
                const SizedBox(height: 20),
                // Features Section
                const Text(
                  'Explore Features',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF008080)),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    _buildFeatureCard('Map Navigation', 'Find accessible routes on the map.'),
                    _buildFeatureCard('Accessibility Info', 'Tips for using public spaces.'),
                    _buildFeatureCard('User Guides', 'How to use the app effectively.'),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Notification Area on top of everything
        if (_showNotification)
          Center(
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 6,
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children:  [
                    Text(
                      'Welcome to StepAssist!',
                      style: TextStyle(
                        fontFamily: 'YourCustomFont',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF008080),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Enjoy your experience with personalized mobility assistance.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontFamily: 'YourCustomFont'),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildQuickAccessButton(BuildContext context, String label, IconData icon) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // Navigate to the respective page
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: const Color(0xFF008080)), // Increased icon size
              const SizedBox(height: 10),
              Text(label, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(String title, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      elevation: 2,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        subtitle: Text(description),
      ),
    );
  }

  Widget _buildChatSection() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ChatBubble(message: messages[index]);
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
                  decoration: const InputDecoration(
                    hintText: 'Type your message...',
                    border: OutlineInputBorder(),
                  ),
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

class ChatBubble extends StatelessWidget {
  final String message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(message),
    );
  }
}

Widget _buildLogoutItem(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Color(0xFF008080)), // Log out icon
      title: const Text(
        'Log Out',
        style: TextStyle(fontSize: 16, fontFamily: 'YourCustomFont'),
      ),
      onTap: () {
        // Navigate to LoginPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    );
  }

