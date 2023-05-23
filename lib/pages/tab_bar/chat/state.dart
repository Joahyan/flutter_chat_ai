import 'package:flutter/material.dart';
import 'package:flutter_chat_ai/common/entities/entities.dart';
import 'package:get/get.dart';

import 'widgets/widgets.dart';

class ChatState {
  Rx<Color> backColor = const Color.fromRGBO(1, 1, 1, 0.0).obs;
  Rx<Color> textColor = Colors.black.obs;
  RxDouble indicatorY = 0.0.obs;
  RxBool indicatorHidden = true.obs;
  RxString indicatorText = 'A'.obs;

  RxMap groupOffsetMap = {
    INDEX_WORDS[0]: 0.0,
    INDEX_WORDS[0]: 0.0,
  }.obs;

  RxList<ChatSettingEntity> chatSettingEntity = <ChatSettingEntity>[].obs;

  RxInt id = 0.obs;
}
