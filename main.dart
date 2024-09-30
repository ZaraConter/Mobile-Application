import 'package:flutter/material.dart';
import 'GetStartedPage.dart'; // Import the Get Started page
import 'HomePage.dart';

void main() {
  runApp(const StepAssistApp());
}

class StepAssistApp extends StatelessWidget {
  const StepAssistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StepAssist',
      theme: ThemeData(
        primarySwatch: Colors.blue, // App theme color
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GetStartedPage(), // Set the initial page to GetStartedPage
      
      routes: {
        '/login': (context) => const LoginPage(), // Login page route
        '/signup': (context) => const SignUpPage(),  // Sign Up page route
        '/forgotPassword': (context) => const ForgotPasswordPage(),  // Forgot Password page route
        '/home': (context) =>  HomePage(),  // Home page route
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the HomePage after successful login
                Navigator.pushNamed(context, '/home');
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the Forgot Password page
                Navigator.pushNamed(context, '/forgotPassword');
              },
              child: const Text('Forgot your password?'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the Sign Up page
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to the login page after sign up
            Navigator.pop(context);
          },
          child: const Text('Sign Up'),
        ),
      ),
    );
  }
}

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to login after password reset
            Navigator.pop(context);
          },
          child: const Text('Reset Password'),
        ),
      ),
    );
  }
}
