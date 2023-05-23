// ignore_for_file: unnecessary_overrides

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ai/common/entities/entities.dart';
import 'package:flutter_chat_ai/common/utils/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class ChatController extends GetxController {
  /// 响应式成员变量
  final state = ChatState();

  late ScrollController scrollController; //滚动控制器

  // textController
  late TextEditingController titleController;
  late TextEditingController keyController;
  late TextEditingController engineController;
  late TextEditingController messageController;

  /// 从storage中获取chatSetting,若storage为空，则从json中获取
  getChatSettingInfo() async {
    List<ChatSettingEntity> chatSettingEntities =
        StorageUtil().getChatSetting();
    if (chatSettingEntities.isEmpty) {
      await rootBundle
          .loadString("assets/chat/chat_setting.json")
          .then((value) {
        List jsonList = jsonDecode(value);
        for (var item in jsonList) {
          ChatSettingEntity settingEntity = ChatSettingEntity.fromJson(item);
          String indexLetter =
              PinyinHelper.getFirstWordPinyin(settingEntity.title!);
          if (indexLetter.isNotEmpty) {
            indexLetter = PinyinHelper.getFirstWordPinyin(indexLetter);
          }
          settingEntity.indexLetter = indexLetter;
          chatSettingEntities.add(settingEntity);
        }
      });
      StorageUtil().setChatSetting(jsonEncode(chatSettingEntities));
    }
    // 排序
    chatSettingEntities.sort((ChatSettingEntity a, ChatSettingEntity b) {
      return a.indexLetter!.compareTo(b.indexLetter!);
    });
    state.chatSettingEntity.value = chatSettingEntities;
  }

  changeShow(int index) {
    bool show = state.chatSettingEntity[index].show ?? false;
    state.chatSettingEntity[index].show = !show;
  }

  onVerticalDragDown(int index) {
    state.backColor.value = const Color.fromRGBO(1, 1, 1, 0); //设置背景颜色
    state.textColor.value = Colors.black; //文字显示颜色
    state.indicatorY.value = 2.28 / INDEX_WORDS.length * index - 1.14; //改变坐标 Y值
    state.indicatorText.value = INDEX_WORDS[index]; //获取对应的字母
    state.indicatorHidden.value = false; //是否隐藏指示器
  }

  onVerticalDragEnd() {
    state.backColor.value = const Color.fromRGBO(1, 1, 1, 0.0);
    state.textColor.value = Colors.black;
    state.indicatorHidden.value = true;
  }

  onVerticalDragUpdate(int index) {
    state.indicatorY.value = 2.28 / INDEX_WORDS.length * index - 1.14;
    state.indicatorText.value = INDEX_WORDS[index];
    state.indicatorHidden.value = false;
  }

  indexBarScroll(int index) {
    String str = INDEX_WORDS[index];
    if (state.groupOffsetMap[str] != null) {
      scrollController.animateTo(state.groupOffsetMap[str],
          duration: const Duration(microseconds: 100), curve: Curves.easeIn);
    }
  }

  // 保存设置
  handleSubmit() {
    // 表单校验
    var title = titleController.text;
    var openaiKey = keyController.text;
    var engine = engineController.text;
    var systemMessage = messageController.text;
    if (title.isEmpty) {
      EasyLoading.showError('请填写 chat title');
      return;
    }
    if (openaiKey.isEmpty) {
      EasyLoading.showError('请填写 openaiKey');
      return;
    }
    if (engine.isEmpty) {
      EasyLoading.showError('请填写 engine');
      return;
    }
    if (systemMessage.isEmpty) {
      EasyLoading.showError('请填写 system message');
      return;
    }
    ChatSettingEntity chatSettingEntity = ChatSettingEntity(
        title: title,
        setting: Setting(
            openaiKey: openaiKey,
            engine: engine,
            systemMessage: systemMessage));
    var timeStemp = DateTime.now().microsecondsSinceEpoch ~/ 1000;
    chatSettingEntity.uptime = timeStemp;
    if (state.id.value == 0) {
      chatSettingEntity.id = timeStemp;
      state.chatSettingEntity.add(chatSettingEntity);
      EasyLoading.showSuccess('新增成功');
    } else {
      for (var i = 0; i < state.chatSettingEntity.length; i++) {
        if (state.chatSettingEntity[i].id == state.id.value) {
          chatSettingEntity.id = state.id.value;
          state.chatSettingEntity[i] = chatSettingEntity;
          EasyLoading.showSuccess('修改成功');
        }
      }
    }
    StorageUtil().setChatSetting(jsonEncode(state.chatSettingEntity));
    Get.back();
  }

  @override
  void onInit() {
    getChatSettingInfo();
    scrollController = ScrollController();
    titleController = TextEditingController();
    keyController = TextEditingController();
    engineController = TextEditingController();
    messageController = TextEditingController();
    super.onInit();
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
    scrollController.dispose();
    titleController.dispose();
    keyController.dispose();
    engineController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
