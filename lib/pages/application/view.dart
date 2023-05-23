import 'dart:math' as math;
import 'package:flutter_chat_ai/common/style/style.dart';
import 'package:flutter_chat_ai/common/utils/utils.dart';
import 'package:flutter_chat_ai/pages/404/index.dart';
import 'package:flutter_chat_ai/pages/tab_bar/chat/index.dart';
import 'package:flutter_chat_ai/pages/tab_bar/mine/index.dart';
import 'package:flutter_chat_ai/pages/tab_bar/records/index.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({Key? key}) : super(key: key);

  /// 页面预览
  Widget _buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        ChatPage(),
        // NotFoundPage(),
        RecordsPage(),
        MinePage(),
      ],
      controller: controller.pageController,
      onPageChanged: controller.handlePageChanged,
    );
  }

  /// 底部导航栏
  Widget _buildBottomNavigationBar() {
    return NeumorphicTheme(
      theme: const NeumorphicThemeData(
          intensity: 1,
          depth: 8,
          baseColor: Color(0xFFEAF3FA),
          shadowDarkColor: Color.fromRGBO(255, 255, 255, 1)),
      darkTheme: const NeumorphicThemeData(
          depth: 3,
          intensity: 1,
          baseColor: Color(0xFF22252D),
          shadowDarkColor: Color.fromRGBO(20, 24, 26, 1),
          shadowLightColor: Color.fromRGBO(51, 58, 64, 1),
          shadowLightColorEmboss: Color.fromRGBO(62, 75, 91, 0.44)),
      child: Neumorphic(
        style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)))),
        child: Container(
          height: 72.h,
          width: 375.w,
          padding: EdgeInsets.only(
            left: 40.w,
            right: 40.w,
          ),
          color: AppColors.primaryBackground,
          child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: controller.bottomTabs.asMap().keys.map((index) {
                return controller.state.page == index
                    ? Container(
                        margin: EdgeInsets.only(bottom: 25.h),
                        width: 64.w,
                        height: 72.h,
                        child: controller.bottomTabs[index].activeIcon)
                    : Container(
                        margin: EdgeInsets.only(bottom: 25.h),
                        height: 72.h,
                        child: InkWell(
                          child: SizedBox(
                            width: 64.w,
                            child: controller.bottomTabs[index].icon,
                          ),
                          onTap: () {
                            controller.handleNavBarTap(index);
                            controller.handlePageChanged(index);
                          },
                        ),
                      );
              }).toList())),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Obx(() => Scaffold(
              body: _buildPageView(),
              bottomNavigationBar: _buildBottomNavigationBar(),
              floatingActionButton: NeumorphicButton(
                padding: EdgeInsets.all(21.w),
                child: Container(
                  child:
                      controller.bottomTabs[controller.state.page].activeIcon,
                ),
                style: NeumorphicStyle(
                  depth: 13,
                  intensity: 1,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(56),
                  ),
                  shape: NeumorphicShape.flat,
                ),
                onPressed: () {},
              ),
              floatingActionButtonLocation:
                  GuideUserActionLocation(page: controller.state.page),
            )),
        onWillPop: () async {
          AndroidBackDesktop.backToDesktop();
          return false;
        });
  }
}

class GuideUserActionLocation extends FloatingActionButtonLocation {
  final int page;
  final double marginRight = 0;
  final double marginBottom = -13.w;

  GuideUserActionLocation({
    required this.page,
  });

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    double fabX = 0;

    double startX =
        FloatingActionButtonLocation.startFloat.getOffset(scaffoldGeometry).dx;
    double endX =
        FloatingActionButtonLocation.endFloat.getOffset(scaffoldGeometry).dx;
    // double avg = (endX - startX) / 2;
    if (page == 0) {
      fabX = startX + 25;
    } else if (page == 1) {
      fabX = FloatingActionButtonLocation.centerFloat
          .getOffset(scaffoldGeometry)
          .dx;
    } else if (page == 2) {
      fabX = endX - 25;
    }

    // if (page == 0) {
    //   fabX = startX;
    // } else if (page == 1) {
    //   fabX = startX + avg;
    // } else if (page == 2) {
    //   fabX = FloatingActionButtonLocation.centerFloat
    //       .getOffset(scaffoldGeometry)
    //       .dx;
    // } else if (page == 3) {
    //   fabX = endX - avg;
    // } else if (page == 4) {
    //   fabX = endX;
    // }

    // Compute the y-axis offset.
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double snackBarHeight = scaffoldGeometry.snackBarSize.height;

    // double fabY = contentBottom - fabHeight - marginBottom;
    double fabY = contentBottom + marginBottom;

    if (snackBarHeight > 0.0) {
      fabY = math.min(
          fabY,
          contentBottom -
              snackBarHeight -
              fabHeight -
              kFloatingActionButtonMargin);
    }
    if (bottomSheetHeight > 0.0) {
      fabY =
          math.min(fabY, contentBottom - bottomSheetHeight - fabHeight / 2.0);
    }
    return Offset(fabX, fabY);
  }

  @override
  String toString() => 'TestActionLocation';

  double _endOffset(ScaffoldPrelayoutGeometry scaffoldGeometry,
      {double offset = 0.0}) {
    switch (scaffoldGeometry.textDirection) {
      case TextDirection.rtl:
        return _leftOffset(scaffoldGeometry, offset: offset);
      case TextDirection.ltr:
        return _rightOffset(scaffoldGeometry, offset: offset);
    }
  }

  double _leftOffset(ScaffoldPrelayoutGeometry scaffoldGeometry,
      {double offset = 0.0}) {
    return kFloatingActionButtonMargin +
        scaffoldGeometry.minInsets.left -
        offset;
  }

  double _rightOffset(ScaffoldPrelayoutGeometry scaffoldGeometry,
      {double offset = 0.0}) {
    return scaffoldGeometry.scaffoldSize.width -
        scaffoldGeometry.floatingActionButtonSize.width -
        marginRight;
  }
}
