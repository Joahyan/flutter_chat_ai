import 'package:get/get.dart';

import 'index.dart';

class MineController extends GetxController {
  MineController();

  final state = MineState();

  _initData() {
    update(["mine"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
