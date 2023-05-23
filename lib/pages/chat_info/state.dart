import 'dart:io';

import 'package:flutter_chat_ai/common/entities/entities.dart';
import 'package:get/get.dart';

class ChatInfoState {
  Rx<ChatCacheEntity> chatCacheEntity = ChatCacheEntity().obs;
  Rx<ChatSettingEntity> chatSettingEntity = ChatSettingEntity().obs;

  RxInt id = 0.obs;
  RxString title = ''.obs;

  RxBool isOpenEmoji = false.obs;
  RxBool isOpenImage = false.obs;
  RxBool isOpenAdd = false.obs;

  Rx<File?> image = null.obs;
}
