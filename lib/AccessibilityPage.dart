import 'package:flutter/material.dart';

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
      home: AccessibilityPage(),
      themeMode: ThemeMode.light, // Ensure it uses only light theme
    );
  }
}

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({super.key});

  @override
  _AccessibilityPageState createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
  // Variables for accessibility settings
  double _fontSize = 16.0;
  bool _highContrastMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF008080), // Your theme color
        title: const Text('Accessibility Options'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Font Size Adjustment
            const Text(
              'Font Size:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _fontSize,
              min: 12.0,
              max: 32.0,
              divisions: 4,
              label: _fontSize.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _fontSize = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // High Contrast Mode Toggle
            const Text(
              'High Contrast Mode:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Switch(
              value: _highContrastMode,
              onChanged: (bool value) {
                setState(() {
                  _highContrastMode = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Displaying the updated settings
            Text(
              'Font Size: ${_fontSize.toStringAsFixed(1)}',
              style: TextStyle(fontSize: _fontSize),
            ),
            Text(
              'High Contrast Mode: ${_highContrastMode ? "Enabled" : "Disabled"}',
              style: TextStyle(fontSize: _fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
