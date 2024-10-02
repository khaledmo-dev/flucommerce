import 'dart:convert';

import 'package:flucommerce/app/app.logger.dart';
import 'package:flucommerce/data/models/user.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flucommerce/consts.dart';

class LocalStorageService implements InitializableDependency {
  late SharedPreferences sharedPreferences;
  @override
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  var logger = getLogger("LocalStorageService");

  void _removeFromDisk(String key) {
    logger.d('(TRACE) LocalStorageService:_removeFromDisk. key: $key');
    sharedPreferences.remove(key);
  }

  dynamic _getFromDisk(String key) {
    var value = sharedPreferences.get(key);
    // logger
    //     .d('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    var preferences = sharedPreferences;
    logger.d(
        '(TRACE) LocalStorageService:_saveStringToDisk. key: $key value: $content');
    if (content is String) {
      preferences.setString(key, content);
    }
    if (content is bool) {
      preferences.setBool(key, content);
    }
    if (content is int) {
      preferences.setInt(key, content);
    }
    if (content is double) {
      preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      preferences.setStringList(key, content);
    }
  }

  //----------------------//----------------------//----------------------//----------------------//----------------------//----------------------//-----------------//

  static const String userKey = 'user';

  User? get user {
    var userJson = _getFromDisk(userKey);
    if (userJson == null) {
      return null;
    }
    return User.fromJson(json.decode(userJson));
  }

  set user(User? userToSave) {
    if (userToSave == null) {
      _removeFromDisk(userKey);
    } else {
      _saveToDisk(userKey, json.encode(userToSave.toJson()));
    }
  }

  static const String themeKey = 'mode';

  bool get isDarkMode {
    return _getFromDisk(themeKey) ?? true;
  }

  set isDarkMode(bool theme) {
    _saveToDisk(themeKey, theme);
  }

  static const String langKey = 'lang';

  String get lang {
    return _getFromDisk(langKey) ?? AppConstants.defaultLanguage;
  }

  set lang(String lang) {
    _saveToDisk(langKey, lang);
  }

  static const String tokenKey = 'token';

  String? get token {
    return _getFromDisk(tokenKey);
  }

  set token(String? token) {
    if (token == null) {
      _removeFromDisk(tokenKey);
    } else {
      _saveToDisk(tokenKey, token);
    }
  }
}
