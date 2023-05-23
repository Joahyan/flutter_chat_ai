//
import 'dart:convert';

import 'package:flutter_chat_ai/common/entities/entities.dart';
import 'package:flutter_chat_ai/common/values/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static final StorageUtil _instance = StorageUtil._();
  factory StorageUtil() => _instance;
  static late final SharedPreferences _prefs;

  StorageUtil._();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String str) {
    return _prefs.setString(key, str);
  }

  static String getString(String key) {
    return _prefs.getString(key) ?? '';
  }

  static Future<bool> setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return _prefs.setString(key, jsonString);
  }

  static dynamic getJSON(String key) {
    String? jsonString = _prefs.getString(key);
    return jsonString == null ? '' : jsonDecode(jsonString);
  }

  static Future<bool> setBool(String key, bool val) {
    return _prefs.setBool(key, val);
  }

  static bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  static Future<bool> setInt(String key, int val) {
    return _prefs.setInt(key, val);
  }

  static int getInt(String key) {
    return _prefs.getInt(key) ?? 0;
  }

  static Future<bool> setDouble(String key, double val) {
    return _prefs.setDouble(key, val);
  }

  static double getDouble(String key) {
    return _prefs.getDouble(key) ?? 0.0;
  }

  // ---------------业务逻辑----------------

  // chatSetting
  Future<bool> setChatSetting(String val) {
    return setJSON(StorageConfig.CHAT_SETTING, val);
  }

  List<ChatSettingEntity> getChatSetting() {
    dynamic json = getJSON(StorageConfig.CHAT_SETTING);
    if (json == '') {
      return [];
    } else {
      List<ChatSettingEntity> chatSettingEntities = [];
      List jsonList = jsonDecode(json) as List;
      for (var item in jsonList) {
        chatSettingEntities.add(ChatSettingEntity.fromJson(item));
      }
      return chatSettingEntities;
    }
  }

  // chatCache

  Future<bool> setChatCache(String val) {
    return setJSON(StorageConfig.CHAT_CACHE, val);
  }

  List<ChatCacheEntity> getChatCache() {
    dynamic json = getJSON(StorageConfig.CHAT_CACHE);
    if (json == '') {
      return [];
    } else {
      List<ChatCacheEntity> chatCacheEntities = [];
      List jsonList = jsonDecode(json) as List;
      for (var item in jsonList) {
        chatCacheEntities.add(ChatCacheEntity.fromJson(item));
      }
      return chatCacheEntities;
    }
  }
}
