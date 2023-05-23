import 'package:get/get.dart';

import 'index.dart';

class RecordsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordsController>(() => RecordsController());
  }
}