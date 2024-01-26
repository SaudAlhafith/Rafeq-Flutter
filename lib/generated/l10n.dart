// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Achievements`
  String get achievements {
    return Intl.message(
      'Achievements',
      name: 'achievements',
      desc: '',
      args: [],
    );
  }

  /// `Finished Courses`
  String get finishedCourses {
    return Intl.message(
      'Finished Courses',
      name: 'finishedCourses',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logout {
    return Intl.message(
      'Log Out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Username not found`
  String get usernameNotFound {
    return Intl.message(
      'Username not found',
      name: 'usernameNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Email not found`
  String get emailNotFound {
    return Intl.message(
      'Email not found',
      name: 'emailNotFound',
      desc: '',
      args: [],
    );
  }

  /// `User data not found`
  String get userDataNotFound {
    return Intl.message(
      'User data not found',
      name: 'userDataNotFound',
      desc: '',
      args: [],
    );
  }

  /// `10 Courses`
  String get tenCourses {
    return Intl.message(
      '10 Courses',
      name: 'tenCourses',
      desc: '',
      args: [],
    );
  }

  /// `5 Courses`
  String get fiveCourses {
    return Intl.message(
      '5 Courses',
      name: 'fiveCourses',
      desc: '',
      args: [],
    );
  }

  /// `3 Courses`
  String get threeCourses {
    return Intl.message(
      '3 Courses',
      name: 'threeCourses',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `RafeeqGPT`
  String get rafeeqGPT {
    return Intl.message(
      'RafeeqGPT',
      name: 'rafeeqGPT',
      desc: '',
      args: [],
    );
  }

  /// `My Courses`
  String get myCourses {
    return Intl.message(
      'My Courses',
      name: 'myCourses',
      desc: '',
      args: [],
    );
  }

  /// `Search by Course Name`
  String get searchMaterialName {
    return Intl.message(
      'Search by Course Name',
      name: 'searchMaterialName',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get searchButton {
    return Intl.message(
      'Search',
      name: 'searchButton',
      desc: '',
      args: [],
    );
  }

  /// `Rafeeq ChatGPT`
  String get RafeeqChatGPT {
    return Intl.message(
      'Rafeeq ChatGPT',
      name: 'RafeeqChatGPT',
      desc: '',
      args: [],
    );
  }

  /// `Rafeeq`
  String get appName {
    return Intl.message(
      'Rafeeq',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login warning message`
  String get loginWarning {
    return Intl.message(
      'Login warning message',
      name: 'loginWarning',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Register now`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account? Register now',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with Google`
  String get signupWithGoogle {
    return Intl.message(
      'Sign up with Google',
      name: 'signupWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Login now`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? Login now',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `settings`
  String get settings {
    return Intl.message(
      'settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `updateProfile`
  String get updateProfile {
    return Intl.message(
      'updateProfile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
