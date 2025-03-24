import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'l10n/en.dart'; // Ensure this import matches your localization files

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).enterEmail; // Get localized text
    }
    if (!EmailValidator.validate(value)) {
      return AppLocalizations.of(context).invalidEmail; // Get localized text
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Simulate password reset logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset link sent to ${_emailController.text}'),
          duration: const Duration(seconds: 3), // Duration for the SnackBar
        ),
      );

      // Navigate back to the LoginPage after submission
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color(0xFF008080);
    final localizations = AppLocalizations.of(context); // Access localization

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        automaticallyImplyLeading: false, // Removes the back arrow
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations.resetPassword, // Use localized text
                  style: const TextStyle(
                    fontFamily: 'YourCustomFont', // Make sure this font is defined
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Email Input Field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: customColor,
                    ),
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: customColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    localizations.sendResetLink, // Use localized text
                    style: const TextStyle(
                      fontFamily: 'YourCustomFont',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Back to Login Button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the Login Page
                  },
                  child: Text(
                    localizations.backToLogin, // Use localized text
                    style: TextStyle(color: customColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
