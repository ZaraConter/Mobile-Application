class AppLocalizations {
  static const AppLocalizations _instance = AppLocalizations._();

  const AppLocalizations._();

  static AppLocalizations get instance => _instance;

  String get title => 'Paramètres';
  String get darkMode => 'Mode sombre';
  String get darkModeDescription => 'Activer le thème sombre';
  String get notifications => 'Notifications';
  String get notificationsDescription => 'Recevoir des notifications';
  String get language => 'Langue';
  String get accountSettings => 'Paramètres du compte';
  String get otherAppsSettings => 'Paramètres des autres applications';
  String get about => 'À propos';
}
