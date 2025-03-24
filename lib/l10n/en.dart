import 'package:flutter/src/widgets/framework.dart';

class AppLocalizations {
  static const AppLocalizations _instance = AppLocalizations._();

  const AppLocalizations._();

  static AppLocalizations get instance => _instance;

  String get title => 'Settings';
  String get darkMode => 'Dark Mode';
  String get darkModeDescription => 'Enable dark mode theme';
  String get notifications => 'Notifications';
  String get notificationsDescription => 'Receive notifications';
  String get language => 'Language';
  String get accountSettings => 'Account Settings';
  String get otherAppsSettings => 'Other Apps Settings';
  String get about => 'About';

  static of(BuildContext context) {}
}
