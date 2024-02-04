import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class TranslationLoader {
  Future<Map<String, dynamic>> loadTranslations(String languageCode) async {
    final String jsonContent =
        await rootBundle.loadString('lib/assets/translations/$languageCode.json');
    return json.decode(jsonContent);
  }
}
