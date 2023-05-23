import 'package:flutter_chat_ai/pages/chat_info/index.dart';
import 'package:flutter_chat_ai/pages/tab_bar/chat/index.dart';
import 'package:flutter_chat_ai/pages/tab_bar/mine/controller.dart';
import 'package:flutter_chat_ai/pages/tab_bar/records/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<ChatInfoController>(() => ChatInfoController());
    Get.lazyPut<RecordsController>(() => RecordsController());
    Get.lazyPut<MineController>(() => MineController());
  }
}
