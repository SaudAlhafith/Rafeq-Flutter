import 'package:flutter/material.dart';
import 'settings_page.dart';

class Settings {
  static void openSettingsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }

  static void updateSetting(String key, dynamic value) {
    // Add logic to update the specified setting with the new value
    print('Setting updated: $key - $value');
  }

  static dynamic getSetting(String key) {
    // Add logic to retrieve the value of the specified setting
    return 'Dummy Value';
  }

  static void resetPassword() {}

  static bool isDarkModeEnabled() {
    // Add logic to check if dark mode is enabled
    return false;
  }

  static void setDarkMode(bool enableDarkMode) {
    // Add logic to set the dark mode preference

    print('Dark mode set to: $enableDarkMode');
  }
}
