import 'package:flutter/material.dart';
import 'LoginPage.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'lib/assets/disabled-person.png', // Your logo image
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 10),
                // Title with Custom Font
                const Text(
                  'StepAssist',
                  style: TextStyle(
                    fontFamily: 'YourCustomFont',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60), // Increased height for more gap
                // Subtitle
                Text(
                  'Your journey to mobility assistance starts here.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Get Started Button
                ElevatedButton(
                 onPressed: () {
                // Navigate directly to the LoginPage
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },

                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: const Color.fromARGB(255, 63, 130, 114),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Footer text
              ],
            ),
          ),
        ),
      ),
    );
  }
}
