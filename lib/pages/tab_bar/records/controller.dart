// ignore_for_file: unnecessary_overrides

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_chat_ai/common/entities/entities.dart';
import 'package:flutter_chat_ai/common/utils/utils.dart';
import 'package:get/get.dart';

import 'index.dart';

class RecordsController extends GetxController {
  RecordsController();

  /// 响应式成员变量
  final state = RecordsState();

  /// 从storage中获取chatSetting,若storage为空，则从json中获取
  getChatSettingInfo() async {
    List<ChatSettingEntity> chatSettingEntity = StorageUtil().getChatSetting();
    if (chatSettingEntity.isEmpty) {
      await rootBundle
          .loadString("assets/chat/chat_setting.json")
          .then((value) {
        List jsonList = jsonDecode(value);
        for (var item in jsonList) {
          chatSettingEntity.add(ChatSettingEntity.fromJson(item));
        }
      });
    }
    state.chatSettingEntity.value = chatSettingEntity;
  }

  changeShow(int index) {
    bool show = state.chatSettingEntity[index].show ?? false;
    state.chatSettingEntity[index].show = !show;
  }

  formatStr() {
    var str = '[${state.chatgptStr.value.replaceFirst("data: [DONE]", "")}]';
    List<String> dataList =
        state.chatgptStr.value.split('data: '); // 将数据划分为多个字符串
    List<Map<String, dynamic>> jsonList = [];
    for (String d in dataList) {
      if (d.isNotEmpty && d != '[DONE]') {
        Map<String, dynamic> jsonData = jsonDecode(d);
        jsonList.add(jsonData);
      }
    }
    print(jsonList);
  }

  @override
  void onInit() {
    super.onInit();
    getChatSettingInfo();
    formatStr();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    // uriSub?.cancel();
    super.dispose();
  }
}
