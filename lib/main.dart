import 'package:flutter/material.dart';
import 'package:rafeq_app/Views/HomeView.dart';
import 'package:rafeq_app/Views/MyCourses/FavoritesModel.dart';
import 'package:rafeq_app/Views/Search/SearchResultModel.dart';
import 'package:rafeq_app/Views/Search/SearchView.dart';
import 'Views/RegistrationView.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rafeq_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavoritesModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchResultModel(),
        ),
        // You can add more providers as needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      home: DecisionView(),
    );
  }
}

class DecisionView extends StatefulWidget {
  @override
  _DecisionViewState createState() => _DecisionViewState();
}

class _DecisionViewState extends State<DecisionView> {
  bool isUserLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return isUserLoggedIn
        ? const HomeView()
        : LoginView(
            registerCallback: _register,
          );
  }

  _register() {
    setState(() {
      isUserLoggedIn = true;
    });
  }

  _logout() {
    setState(() {
      isUserLoggedIn = false;
    });
  }
}
