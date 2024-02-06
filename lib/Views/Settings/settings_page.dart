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
        title: Text(languageProvider.translate('accountSettings')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(languageProvider.translate('changePassword')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()),
                );
              },
            ),
            ListTile(
              title: Text(languageProvider.translate('logout')),
              onTap: () async {
                await Provider.of<AuthService>(context, listen: false).logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            ListTile(
              title: Text(languageProvider.translate('deleteAccount')),
              onTap: () async {
                bool confirmDelete = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                          languageProvider.translate('confirmAccountDeletion')),
                      content: Text(languageProvider
                          .translate('areYouSureToDeleteAccount')),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text(languageProvider.translate('cancel')),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text(languageProvider.translate('delete')),
                        ),
                      ],
                    );
                  },
                );

                if (confirmDelete == true) {
                  try {
                    await Provider.of<AuthService>(context, listen: false)
                        .deleteAccount(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  } catch (e) {
                    print('Error deleting account: $e');
                  }
                }
              },
            ),
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
          title: Text(languageProvider.translate('Language')),
          content: Column(
            children: [
              ListTile(
                title: Text(languageProvider.translate('English')),
                onTap: () {
                  languageProvider.setLocale(Locale('en', 'US'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(languageProvider.translate('Arabic')),
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
