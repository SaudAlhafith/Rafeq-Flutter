import 'package:flutter/material.dart';

class NotificationModel with ChangeNotifier {
  bool _isNotificationEnabled = true;

  bool get isNotificationEnabled => _isNotificationEnabled;

  void setNotificationEnabled(bool value) {
    _isNotificationEnabled = value;
    // Add logic to update the notification preference in your data source
    // For example, you might save it to shared preferences or a database
    // Replace the comment below with the actual logic
    // _saveNotificationPreference(value);

    // Notify listeners so that the UI can be updated
    notifyListeners();
  }

  // Add any additional logic, such as initializing from a data source
}
