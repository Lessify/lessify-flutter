import 'package:flutter/material.dart';

class LessifyLocalization {
  LessifyLocalization(this._translations);

  final Map<String, dynamic> _translations;

  static LessifyLocalization of(BuildContext context) {
    return Localizations.of<LessifyLocalization>(context, LessifyLocalization);
  }

  String translate(String key, {Map<String, dynamic> namedArgs}) {
    var translation = _translations[key];
    if (translation != null) {
      return translation;
    } else {
      return key;
    }
  }
}
