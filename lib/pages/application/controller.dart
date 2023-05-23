import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class ApplicationController extends GetxController {
  /// 响应式成员变量
  final state = ApplicationState();

  // 页控制器
  late final PageController pageController;

  // 底部导航项目
  late final List<BottomNavigationBarItem> bottomTabs;

  // tab栏页码切换
  void handlePageChanged(int page) {
    state.page = page;
  }

  // tab栏动画
  void handleNavBarTap(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  void onInit() {
    super.onInit();

    bottomTabs = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        label: 'Chat',
        icon: Image.asset(
          'assets/images/chat.png',
          height: 22.h,
          width: 22.w,
        ),
        activeIcon: Image.asset(
          'assets/images/chat-active.png',
          height: 22.h,
          width: 22.w,
        ),
      ),
      BottomNavigationBarItem(
        label: 'concat',
        icon: Image.asset(
          'assets/images/concat.png',
          height: 22.h,
          width: 22.w,
        ),
        activeIcon: Image.asset(
          'assets/images/concat-active.png',
          height: 22.h,
          width: 22.w,
        ),
      ),
      BottomNavigationBarItem(
        label: 'mine',
        icon: Image.asset(
          'assets/images/mine.png',
          height: 22.h,
          width: 22.w,
        ),
        activeIcon: Image.asset(
          'assets/images/mine-active.png',
          height: 22.h,
          width: 22.w,
        ),
      ),
    ];

    pageController = new PageController(initialPage: state.page);
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
    pageController.dispose();
    super.dispose();
  }
}
