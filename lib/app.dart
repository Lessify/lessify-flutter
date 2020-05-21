import 'package:flutter/cupertino.dart';
import 'package:lessify_flutter/translation_loader.dart';
import 'package:rxdart/rxdart.dart';

import 'localization_delegate.dart';

class LessifyApp extends InheritedWidget {
  final Widget child;
  final LessifyLocalizationDelegate delegate;
  final List<Locale> supportedLocales;
  final Locale fallbackLocale;
  final TranslationLoader loader;
  //ignore: close_sinks
  final BehaviorSubject<Locale> _currentLocale = BehaviorSubject.seeded(null);

  ValueStream<Locale> get currentLocaleStream$ => _currentLocale.stream;

  LessifyApp(
      {Key key,
      @required this.child,
      @required this.supportedLocales,
      @required this.loader,
      @required this.fallbackLocale})
      : this.delegate = LessifyLocalizationDelegate(
            supportedLocales: supportedLocales,
            loader: loader,
            fallbackLocale: fallbackLocale),
        super(key: key, child: child);

  static LessifyApp of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LessifyApp>();
  }

  void changeLocale(Locale newLocale) {
    this._currentLocale.add(newLocale);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
