import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/DataModel/VideoCard.dart';
import 'package:rafeq_app/Views/MyCourses/FavoritesModel.dart';
import 'package:rafeq_app/Views/Profile/EditProfileScreen.dart';
import 'package:rafeq_app/generated/l10n.dart';
import 'package:rafeq_app/services/AuthService.dart';
import 'package:rafeq_app/Views/Settings/DarkThemeProvider.dart';
import 'package:rafeq_app/Views/Settings/settings_page.dart';
import 'package:rafeq_app/Views/Settings/LanguageProvider.dart';
import 'package:rafeq_app/Views/Settings/TranslationLoader.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthService>(context);
    var currentUser = authService.currentUser;
    var favoritesModel = Provider.of<FavoritesModel>(context);
    final darkThemeProvider = Provider.of<DarkThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.translate('profile')),
        backgroundColor: darkThemeProvider.isDarkModeEnabled
            ? Color(0xff303030) // Change to the desired color for dark mode
            : Colors.blue,
      ),
      backgroundColor: darkThemeProvider.isDarkModeEnabled
          ? Color(0xff303030) // Change to the desired color for dark mode
          : Colors.white,
      drawer: _settingsDrawer(context, languageProvider),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                NetworkImage('https://picsum.photos/200'),
                            backgroundColor: Colors.blue,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child:
                                Icon(Icons.edit, size: 20, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (currentUser != null)
                      FutureBuilder<Map<String, dynamic>?>(
                        future: authService.fetchUserProfile(currentUser.uid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  snapshot.data?['username'] ??
                                      languageProvider
                                          .translate('usernameNotFound'),
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: darkThemeProvider.isDarkModeEnabled
                                        ? Colors.grey
                                        : Colors.blue,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                ListTile(),
                                Text(
                                  snapshot.data?['bio'] ??
                                      '', // Display the bio
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: darkThemeProvider.isDarkModeEnabled
                                        ? Colors.grey
                                        : Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 30),
                              ],
                            );
                          }
                          return Text(
                              languageProvider.translate('userDataNotFound'));
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  languageProvider.translate('achievements'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkThemeProvider.isDarkModeEnabled
                        ? Colors.grey
                        : Colors.blue,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: darkThemeProvider.isDarkModeEnabled
                        ? Color(0xff303030)
                        : Colors.blue,
                  ),
                  // other properties...
                ),
                Container(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      AchievementIcon(
                        iconData: Icons.emoji_events,
                        color: Colors.amber,
                        label: languageProvider.translate('tenCourses'),
                      ),
                      AchievementIcon(
                        iconData: Icons.emoji_events,
                        color: Colors.grey,
                        label: languageProvider.translate('fiveCourses'),
                      ),
                      AchievementIcon(
                        iconData: Icons.emoji_events,
                        color: Colors.brown,
                        label: languageProvider.translate('threeCourses'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  languageProvider.translate('finishedCourses'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkThemeProvider.isDarkModeEnabled
                        ? Colors.grey
                        : Colors.blue,
                  ),
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: favoritesModel.favorites.length,
                  itemBuilder: (context, index) {
                    return ContentCard(video: favoritesModel.favorites[index]);
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Drawer _settingsDrawer(
    BuildContext context, LanguageProvider languageProvider) {
  var darkThemeProvider = Provider.of<DarkThemeProvider>(context);
  return Drawer(
    child: ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: darkThemeProvider.isDarkModeEnabled
                ? Color(0xff303030) // Change to the desired color for dark mode
                : Colors.blue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                languageProvider.translate('Settings'),
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              // Add a switch or any other widgets you want in the header
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text(
            languageProvider.translate('Edit Profile'),
            style: TextStyle(fontSize: 16),
          ),
          onTap: () async {
            Navigator.pop(context);
            var authService = Provider.of<AuthService>(context, listen: false);
            var currentUser = authService.currentUser;

            if (currentUser != null) {
              var userProfile =
                  await authService.fetchUserProfile(currentUser.uid);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditProfileScreen(
                  initialUsername: userProfile?['username'],
                  initialEmail: currentUser.email,
                  initialBio: userProfile?['bio'] ?? "",
                ),
              ));
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.dark_mode),
          title: Text(
            languageProvider.translate('Dark Mode'),
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            Navigator.pop(context);
            Provider.of<DarkThemeProvider>(context, listen: false)
                .toggleDarkMode();
          },
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text(
            languageProvider.translate("Language"),
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            showLanguageDialog(context, languageProvider);
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(languageProvider.translate('Account Settings'),
              style: TextStyle(fontSize: 16)),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SettingsPage(),
            ));
          },
        ),
        // ... Other list tiles for different options
      ],
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

class AchievementIcon extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final String label;

  const AchievementIcon({
    Key? key,
    required this.iconData,
    required this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(iconData, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ContentCard extends StatelessWidget {
  final VideoCard video;

  ContentCard({required this.video});

  @override
  Widget build(BuildContext context) {
    final darkThemeProvider = Provider.of<DarkThemeProvider>(context);
    return Card(
      color: Colors.grey.shade50,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                video.thumbnailURL ?? "",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Column(
                children: [
                  Text(
                    video.title ?? "",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: darkThemeProvider.isDarkModeEnabled
                          ? Colors.grey
                          : Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    video.channelTitle ?? "",
                    style: TextStyle(
                      fontSize: 10,
                      color: darkThemeProvider.isDarkModeEnabled
                          ? Colors.grey
                          : Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
