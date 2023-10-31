import 'package:flutter/material.dart';
import 'package:rafeq_app/Views/HomeView.dart';
import 'package:rafeq_app/Views/LoginView.dart';
import 'package:rafeq_app/Views/SignInUpViewModel.dart';
import 'package:rafeq_app/Views/MyCourses/FavoritesModel.dart';
import 'package:rafeq_app/Views/Search/SearchResultModel.dart';
import 'package:rafeq_app/Views/Search/SearchView.dart';
import 'package:rafeq_app/services/AuthService.dart';
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
        StreamProvider<User?>(
          create: (context) => AuthService().user,
          initialData: null,
        ),
        Provider<AuthService>(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoritesModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchResultModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInUpViewModel(),
        ),
        // You can add more providers as needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rafeeq',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        '/' : (context) => Wrapper(),
        '/login': (context) =>  LoginView(),
        '/home': (context) => HomeView(),
        '/register': (context) => RegistrationView(),
      },
    );
  }
}

class Wrapper extends StatelessWidget {
  Wrapper({super.key});
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user == null ? LoginView() : const HomeView();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
