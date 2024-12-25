import 'dart:convert';
import '../common/console.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._();

  static late SharedPreferences _prefs;

  static SharedPreferences get pref => _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void setKey({required String key, required String? value}) async {
    try {
      if (value != null) {
        _prefs.setString(key, value);
      }
    } catch (e) {
      Console.debug(e);
    }
  }

  static void setStringList({required String key, required List<String> value}) async {
    try {
      _prefs.setStringList(key, value);
    } catch (e) {
      Console.debug(e);
    }
  }

  static Future<List<String>?> getStringList({required String key}) async {
    try {
      return _prefs.getStringList(key);
    } catch (e) {
      Console.debug(e);
      return null;
    }
  }

  static void setMap({required String key, required Map<String, dynamic>? value}) async {
    try {
      if (value != null) {
        Console.debug(value);
        String jsonEncodedString = json.encode(value);
        Console.debug(jsonEncodedString);
        _prefs.setString(key, jsonEncodedString);
      } else {
        Console.debug("The Map is empty there is noting to update to storage");
      }
    } catch (e) {
      Console.debug(e);
    }
  }

  static void removeKey({required String key}) async {
    try {
      _prefs.remove(key);
    } catch (e) {
      Console.debug(e);
    }
  }

  static Future<String?> getKey({required String key}) async {
    try {
      return _prefs.getString(key);
    } catch (e) {
      Console.debug(e);
      return null;
    }
  }

  static Future<dynamic> getKeyAny({required String key}) async {
    try {
      dynamic temp = _prefs.get(key);
      if (temp != null) {
        return json.decode(temp);
      } else {
        return null;
      }
    } catch (e) {
      Console.debug(e);
      return null;
    }
  }

  static void setBool({required String key, required bool value}) async {
    try {
      _prefs.setBool(key, value);
    } catch (e) {
      Console.debug(e);
    }
  }

  static Future<bool?> getBool({required String key}) async {
    try {
      return _prefs.getBool(key);
    } catch (e) {
      Console.debug(e);
      return null;
    }
  }

  static Future<bool?> removeAllKeysAtOnce() async {
    try {
      return _prefs.clear();
    } catch (e) {
      Console.debug(e);
      return null;
    }
  }
}
