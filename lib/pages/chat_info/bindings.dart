import 'package:get/get.dart';

import 'index.dart';

class ChatInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatInfoController>(() => ChatInfoController());
    Get.lazyPut<ChatInfoProvider>(() => ChatInfoProvider());
  }
}
