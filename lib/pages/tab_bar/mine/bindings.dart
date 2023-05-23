import 'package:get/get.dart';

import 'index.dart';

class MineBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<MineController>(() => MineController());
  }

}