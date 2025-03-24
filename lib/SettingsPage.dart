import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  bool _notifications = true;
  String _language = 'English';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load settings from SharedPreferences
  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('darkMode') ?? false;
      _notifications = prefs.getBool('notifications') ?? true;
      _language = prefs.getString('language') ?? 'English';
    });
  }

  // Save settings to SharedPreferences
  _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', _darkMode);
    prefs.setBool('notifications', _notifications);
    prefs.setString('language', _language);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark mode theme'),
            value: _darkMode,
            onChanged: (bool value) {
              setState(() {
                _darkMode = value;
              });
              _saveSettings();
            },
          ),
          SwitchListTile(
            title: const Text('Notifications'),
            subtitle: const Text('Receive notifications'),
            value: _notifications,
            onChanged: (bool value) {
              setState(() {
                _notifications = value;
              });
              _saveSettings();
            },
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: Text('Current language: $_language'),
            leading: const Icon(Icons.language),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () async {
              final selectedLanguage = await showDialog<String>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Select Language'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: ['English', 'French', 'Spanish']
                          .map((lang) => ListTile(
                                title: Text(lang),
                                onTap: () {
                                  Navigator.pop(context, lang);
                                },
                              ))
                          .toList(),
                    ),
                  );
                },
              );
              if (selectedLanguage != null) {
                setState(() {
                  _language = selectedLanguage;
                });
                _saveSettings();
              }
            },
          ),
          ListTile(
            title: const Text('Account Settings'),
            subtitle: const Text('Manage your account details'),
            leading: const Icon(Icons.account_circle),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountSettingsPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Other Apps Settings'),
            subtitle: const Text('Manage settings for other connected apps'),
            leading: const Icon(Icons.apps),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OtherAppsSettingsPage()),
              );
            },
          ),
          ListTile(
            title: const Text('About'),
            subtitle: const Text('Learn more about this app'),
            leading: const Icon(Icons.info),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AccountSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Settings')),
      body: Column(
        children: [
          ListTile(
            title: const Text('Profile Picture'),
            leading: const Icon(Icons.camera_alt),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Add functionality to pick profile picture
            },
          ),
          // Additional account-related settings can go here
        ],
      ),
    );
  }
}

class OtherAppsSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Other Apps Settings')),
      body: Center(child: Text('Manage other apps settings here')),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Center(child: Text('Learn more about this app here')),
    );
  }
}
