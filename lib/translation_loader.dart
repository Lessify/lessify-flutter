import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

abstract class TranslationLoader {
  Future<Map<String, dynamic>> load(Locale locale);
}

class LessifyTranslationLoader implements TranslationLoader {
  final String spaceId;
  final String environment;
  final String apiKey;
  final bool beta;

  LessifyTranslationLoader({
    @required this.spaceId,
    @required this.environment,
    @required this.apiKey,
    this.beta,
  });

  @override
  Future<Map<String, dynamic>> load(Locale locale) async {
    assert(spaceId != null, 'SpaceId is required');
    assert(environment != null, 'SpaceId is required');
    assert(apiKey != null, 'SpaceId is required');
    final String url = (this.beta == null || this.beta == false)
        ? 'https://api.lessify.io'
        : 'https://dev-api.lessify.io';

    final response = await http.get(
        '$url/v1/spaces/$spaceId/environments/$environment/translations.${locale.languageCode}.json',
        headers: {'Authorization': 'Bearer $apiKey'});
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load translations');
    }
  }
}

class BundleAssetTranslationLoader implements TranslationLoader {
  final String basePath;
  BundleAssetTranslationLoader({
    this.basePath = "assets/i18n",
  });

  @override
  Future<Map<String, dynamic>> load(Locale locale) async {
    return json.decode(
        await rootBundle.loadString('$basePath/${locale.languageCode}.json'));
  }
}
