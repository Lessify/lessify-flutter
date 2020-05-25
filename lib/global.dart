import 'localization.dart';

String translate(String key, {Map<String, dynamic> namedArgs, List<dynamic> args})
{
  return LessifyLocalization.instance.translate(key, args: args, namedArgs: namedArgs);
}