import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'SignUpPage.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true; // Variable to control password visibility

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmailOrUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email or username.';
    }

    // Validate email format if it contains "@" symbol
    if (value.contains('@')) {
      // Basic check for valid email format
      if (!EmailValidator.validate(value)) {
        return 'Please enter a valid email address.';
      }

      // Additional checks
      if (value.indexOf('@') == 0 || value.indexOf('@') == value.length - 1) {
        return 'Invalid email format.';
      }

      // Ensure there is at least one '.' after the '@'
      final domain = value.split('@')[1];
      if (!domain.contains('.') || domain.startsWith('.') || domain.endsWith('.')) {
        return 'Invalid email format. Please check the domain.';
      }
    } else {
      // Username validation
      if (!RegExp(r'^[a-zA-Z0-9_]{3,20}$').hasMatch(value)) {
        return 'Invalid Username. Please try again';
      }
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters.';
    }
    // Check for at least one uppercase letter, one lowercase letter, one digit, and one special character
    if (!RegExp(r'(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}').hasMatch(value)) {
      return 'Invalid password. Please try again';
    }
    return null;
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Handle login logic here
      Navigator.pushNamed(context, '/home'); // Navigates to Home Page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Header with Blue-Green Gradient
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF008080), Color(0xFF20B2AA)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Centered Login Card
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Color(0xFF008080),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'YourCustomFont',
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 30),

                              TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  labelText: 'Email or Username',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Color(0xFF008080),
                                  ),
                                ),
                                validator: _validateEmailOrUsername,
                              ),
                              const SizedBox(height: 20),

                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Color(0xFF008080),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: const Color(0xFF008080),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                validator: _validatePassword,
                              ),
                              const SizedBox(height: 10),

                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/forgotPassword');
                                  },
                                  child: const Text(
                                    'Forgot your password?',
                                    style: TextStyle(
                                      color: Color(0xFF20B2AA),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              ElevatedButton(
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                  backgroundColor: const Color(0xFF008080),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontFamily: 'YourCustomFont',
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  },
  child: const Text(
    "Don't have an account? Sign up",
    style: TextStyle(color: Color(0xFF008080)),
  ),
),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
