import 'package:flutter/material.dart';
import 'package:rafeq_app/Views/MyCourses/MyCourseView.dart';
import 'package:rafeq_app/Views/Profile/UserProfile.dart';
import 'package:rafeq_app/Views/Search/SearchView.dart';
import 'package:rafeq_app/services/AuthService.dart';
import 'package:rafeq_app/Views/RAFEQGPT/RafeqGPT.dart';
import 'package:rafeq_app/Views/Settings/settings.dart';
import 'package:rafeq_app/Views/Settings/settings_page.dart';

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
        items: const [
          BottomNavigationBarItem(
            label: "profile",
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: "search",
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: "RafeeqGPT",
            icon: Icon(
              Icons.computer,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: "My Courses",
            icon: Icon(
              Icons.book,
              color: Colors.grey,
            ),
          ),
          // Add SettingsPage to the bottom navigation bar
          BottomNavigationBarItem(
            label: "Settings",
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
