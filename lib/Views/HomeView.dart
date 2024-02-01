import 'package:flutter/material.dart';
import 'package:rafeq_app/Views/MyCourses/MyCourseView.dart';
import 'package:rafeq_app/Views/Profile/UserProfile.dart';
import 'package:rafeq_app/Views/RAFEQGPT/RafeqGPT.dart';
import 'package:rafeq_app/Views/Settings/settings.dart';
import 'package:rafeq_app/Views/Settings/settings_page.dart';
import 'package:rafeq_app/Views/Search/SearchView.dart';

import '../generated/l10n.dart';

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
    var localizations = S.of(context);
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
            label: localizations.profile,
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: localizations.search,
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: localizations.rafeeqGPT,
            icon: Icon(
              Icons.computer,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: localizations.myCourses,
            icon: Icon(
              Icons.book,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: localizations.settings,
            icon: Icon(
              Icons.settings,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
