import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/generated/l10n.dart';
import 'ChangePasswordScreen.dart';
import 'package:rafeq_app/services/AuthService.dart';
import 'DarkThemeProvider.dart';
import 'NotificationModel.dart';
import 'package:rafeq_app/Views/Settings/LanguageProvider.dart';

class SettingsPage extends StatelessWidget {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var languageProvider = context.watch<LanguageProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'General Settings',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // SwitchListTile(
            //   title: Text('Dark Mode'),
            //   value: Provider.of<DarkThemeProvider>(context).isDarkModeEnabled,
            //   onChanged: (bool value) {
            //     Provider.of<DarkThemeProvider>(context, listen: false)
            //         .toggleDarkMode();
            //   },
            // ),
            // Add other general settings
            // Example: Language preferences, App theme, Font size adjustments
            // Uncomment and customize these lines:
            // ListTile(
            //   title: Text(languageProvider.translate("language")),
            //   onTap: () {
            //     showLanguageDialog(context, languageProvider);
            //   },
            // ),
            // ListTile(
            //   title: Text('App Theme'),
            //   onTap: () {
            //     // Add logic to change app theme
            //   },
            // ),
            // ListTile(
            //   title: Text('Font Size'),
            //   onTap: () {
            //     // Add logic to change font size
            //   },
            // ),

            // SizedBox(height: 16),
            // Text(
            //   'Account Settings',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            ListTile(
              title: Text('Change Password'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()),
                );
              },
            ),
            // Add other account settings
            // Example: Logout, Delete account, Profile settings
            // Uncomment and customize these lines:
            ListTile(
              title: Text('Logout'),
              onTap: () async {
                // Call the logout method from your authentication service
                await Provider.of<AuthService>(context, listen: false).logout();
                // Navigate to the login or home screen after logout
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            ListTile(
              title: Text('Delete Account'),
              onTap: () async {
                bool confirmDelete = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Account Deletion'),
                      content:
                          Text('Are you sure you want to delete your account?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false); // User canceled
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true); // User confirmed
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    );
                  },
                );

                if (confirmDelete == true) {
                  try {
                    // Add logic to delete the account in your authentication service
                    await Provider.of<AuthService>(context, listen: false)
                        .deleteAccount(context);

                    // Navigate to the login screen after successful deletion
                    Navigator.pushReplacementNamed(context, '/login');
                  } catch (e) {
                    // Handle any errors during account deletion
                    print('Error deleting account: $e');
                    // You can show an error message or take appropriate actions
                  }
                }
              },
            ),

            // ListTile(
            //   title: Text('Profile Settings'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => ProfileSettingsPage(),
            //       ),
            //     );
            //   },
            // ),

            // SizedBox(height: 16),
            // Text(
            //   'Notification Settings',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // SwitchListTile(
            //   title: Text('Receive Notifications'),
            //   value:
            //       Provider.of<NotificationModel>(context).isNotificationEnabled,
            //   onChanged: (bool value) {
            //     Provider.of<NotificationModel>(context, listen: false)
            //         .setNotificationEnabled(value);
            //   },
            // ),
            // Add other notification settings
            // Example: Notification sound preferences, Vibration preferences, In-app notifications
            // Uncomment and customize these lines:
            // SwitchListTile(
            //   title: Text('Notification Sound'),
            //   value: // Get value from somewhere,
            //   onChanged: (bool value) {
            //     // Add logic to handle notification sound preference
            //   },
            // ),
            // SwitchListTile(
            //   title: Text('Vibration'),
            //   value: // Get value from somewhere,
            //   onChanged: (bool value) {
            //     // Add logic to handle vibration preference
            //   },
            // ),
            // SwitchListTile(
            //   title: Text('In-app Notifications'),
            //   value: // Get value from somewhere,
            //   onChanged: (bool value) {
            //     // Add logic to handle in-app notification preference
            //   },
            // ),

            // Add more sections and settings as needed
          ],
        ),
      ),
    );
  }

  void showLanguageDialog(
      BuildContext context, LanguageProvider languageProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(languageProvider.translate('language')),
          content: Column(
            children: [
              ListTile(
                title: Text(languageProvider.translate('english')),
                onTap: () {
                  languageProvider.setLocale(Locale('en', 'US'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(languageProvider.translate('arabic')),
                onTap: () {
                  languageProvider.setLocale(Locale('ar', 'AR'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
