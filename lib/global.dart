import 'package:flutter/foundation.dart';

import 'localization.dart';

String translate(String key, {Map<String, dynamic> namedArgs, List<dynamic> args})
{
  return LessifyLocalization.instance.translate(key, args: args, namedArgs: namedArgs);
}

String translatePlural(String key, Plural plural, {Map<String, dynamic> namedArgs, List<dynamic> args})
{
  return LessifyLocalization.instance.translate("$key.${describeEnum(plural)}", args: args, namedArgs: namedArgs);
}

enum Plural {
  zero,
  one,
  two,
  few,
  many,
  other
}