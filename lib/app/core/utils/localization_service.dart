import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationService {
  static final _storage = GetStorage();
  static const String _languageKey = 'language_code';
  static const String _countryKey = 'country_code';
  
  // Supported languages with their locales
  static final Map<String, Locale> supportedLanguages = {
    'English': const Locale('en', 'GB'),
    'Dutch': const Locale('nl', 'NL'),
    'French': const Locale('fr', 'FR'),
    'Spanish': const Locale('es', 'ES'),
  };
  
  // Countries with their default languages
  static final Map<String, String> countryToLanguage = {
    'Netherlands': 'Dutch',
    'Belgium': 'Dutch',
    'France': 'French',
    'United Kingdom': 'English',
    'Spain': 'Spanish',
  };
  
  // Default language
  static const Locale defaultLanguage = Locale('en', 'GB');
  
  // Get current locale
  static Locale get currentLocale {
    String? languageCode = _storage.read(_languageKey);
    if (languageCode != null) {
      final parts = languageCode.split('_');
      if (parts.length == 2) {
        return Locale(parts[0], parts[1]);
      }
    }
    return defaultLanguage;
  }
  
  // Get current country
  static String get currentCountry {
    return _storage.read(_countryKey) ?? 'United Kingdom';
  }
  
  // Change language
  static void changeLocale(String languageName) {
    if (supportedLanguages.containsKey(languageName)) {
      final locale = supportedLanguages[languageName]!;
      _storage.write(_languageKey, '${locale.languageCode}_${locale.countryCode}');
      Get.updateLocale(locale);
    }
  }
  
  // Set country
  static void setCountry(String country) {
    _storage.write(_countryKey, country);
    
    // Optionally update language based on country
    final defaultLanguage = countryToLanguage[country];
    if (defaultLanguage != null) {
      changeLocale(defaultLanguage);
    }
  }
  
  // Get language name from locale
  static String getLanguageName(Locale locale) {
    String localeKey = '${locale.languageCode}_${locale.countryCode}';
    for (var entry in supportedLanguages.entries) {
      if ('${entry.value.languageCode}_${entry.value.countryCode}' == localeKey) {
        return entry.key;
      }
    }
    return 'English'; // Default
  }
  
  // Get all language names
  static List<String> get languageNames => supportedLanguages.keys.toList();
  
  // Get all countries
  static List<String> get countries => countryToLanguage.keys.toList();
}
