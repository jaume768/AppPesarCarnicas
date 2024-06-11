import 'dart:ui';

enum Language { catalan }

extension LanguageExtension on Language {
  String get locale {
    return 'ca';
  }

  String get name {
    return 'Català';
  }

  String get flag {
    return '🇪🇸';
  }

  Locale get localeValue {
    return const Locale('ca', "ES");
  }
}
