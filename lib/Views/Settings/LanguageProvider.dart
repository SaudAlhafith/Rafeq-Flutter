import 'package:flutter/material.dart';
import 'package:rafeq_app/Views/Settings/TranslationLoader.dart';

class LanguageProvider extends ChangeNotifier {
  late Locale _locale;
  late Map<String, dynamic> _translations;
  final TranslationLoader _translationLoader;

  LanguageProvider(this._translationLoader) {
    _locale = Locale('en', 'US');
    _translations = Map();
    _loadTranslations();
  }

  Locale get locale => _locale;
  Map<String, dynamic> get translations => _translations;

  void setLocale(Locale locale) {
    _locale = locale;
    _translations = Map();
    _loadTranslations();
    notifyListeners();
  }

  Future<void> _loadTranslations() async {
    _translations =
        await _translationLoader.loadTranslations(_locale.languageCode);
  }

  String translate(String key) {
    return _translations[key] ?? key;
  }
}
