import 'package:flutter/material.dart';
import 'package:rafeq_app/Views/MyCourses/MyCourseView.dart';
import 'package:rafeq_app/Views/Profile/UserProfile.dart';
import 'package:rafeq_app/Views/Search/SearchView.dart';
import 'package:rafeq_app/services/AuthService.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  List<Widget> body =  [
    UserProfile(),
    SearchView(),
    MyCourses(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.book),
          ),
        ],
      ),
    );
  }
}
