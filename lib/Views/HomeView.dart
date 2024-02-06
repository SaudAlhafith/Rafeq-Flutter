import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/Views/MyCourses/MyCourseView.dart';
import 'package:rafeq_app/Views/Profile/UserProfile.dart';
import 'package:rafeq_app/Views/RAFEQGPT/RafeqGPT.dart';
import 'package:rafeq_app/Views/Settings/settings.dart';
import 'package:rafeq_app/Views/Settings/settings_page.dart';
import 'package:rafeq_app/Views/Search/SearchView.dart';
import '../generated/l10n.dart';
import 'package:rafeq_app/Views/Settings/LanguageProvider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 3;
  List<Widget> body = [
    UserProfile(),
    SearchView(),
    RafeqGPT(),
    MyCourses(),
    SettingsPage(), // Add the SettingsPage here
  ];

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          // Body based on current index
          Expanded(
            child: Center(
              child: body[_currentIndex],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: languageProvider.translate('profile'),
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: languageProvider.translate('search'),
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: languageProvider.translate('rafeeqGPT'),
            icon: Icon(
              Icons.computer,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: languageProvider.translate('myCourses'),
            icon: Icon(
              Icons.book,
              color: Colors.grey,
            ),
          ),
          // BottomNavigationBarItem(
          //   label: languageProvider.translate('settings'),
          //   icon: Icon(
          //     Icons.settings,
          //     color: Colors.grey,
          //   ),
          // ),
        ],
      ),
    );
  }
}
