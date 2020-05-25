import 'package:flutter/widgets.dart';
import 'localization.dart';
import 'translation_loader.dart';

class LessifyLocalizationDelegate
    extends LocalizationsDelegate<LessifyLocalization> {
  LessifyLocalizationDelegate(
      {@required this.supportedLocales,
      @required this.loader,
      @required this.fallbackLocale});

  final List<Locale> supportedLocales;
  final Locale fallbackLocale;
  final TranslationLoader loader;

  @override
  bool isSupported(Locale locale) {
    return true;
  }

  @override
  Future<LessifyLocalization> load(Locale locale) async {
    Locale acceptableLocale = fallbackLocale;
    for (Locale l in supportedLocales) {
      if (l.languageCode == locale.languageCode) {
        acceptableLocale = l;
        break;
      }
    }
    final translations = await loader.load(acceptableLocale);
    return LessifyLocalization.init(translations);
  }

  @override
  bool shouldReload(LocalizationsDelegate old) {
    return false;
  }
}
