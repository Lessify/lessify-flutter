class LessifyLocalization {
  LessifyLocalization._(this._translations);

  final Map<String, dynamic> _translations;

  static LessifyLocalization _instance;

  static LessifyLocalization get instance =>
      _instance ?? (_instance = LessifyLocalization._(null));

  static LessifyLocalization init(Map<dynamic, dynamic> translations) {
    _instance = LessifyLocalization._(translations);
    return instance;
  }

  String translate(String key,
      {Map<String, dynamic> namedArgs, List<dynamic> args}) {
    if (key == null || key.isEmpty) return key;
    String translation = _translations[key];
    if (translation == null || translation.isEmpty) return key;
    if (namedArgs != null && namedArgs.isNotEmpty) {
      namedArgs.forEach((key, value) =>
          translation = translation.replaceAll('{$key}', '${namedArgs[key]}'));
    } else if (args != null && args.isNotEmpty) {
      args.forEach(
          (value) => translation = translation.replaceFirst('{}', '$value'));
    }
    return translation;
  }
}
