import 'package:flutter/material.dart';
import 'package:flutter_chat_ai/common/style/style.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class MinePage extends GetView<MineController> {
  const MinePage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildBottomSheet() {
    return Container(
      child: Column(
        children: [],
      ),
    );
  }

  Widget _buildPersonInfo() {
    return InkWell(
      onTap: () {
        Get.bottomSheet(_buildBottomSheet());
      },
      child: Container(
        height: 59.w,
        margin: EdgeInsets.only(
          top: 88.h,
          bottom: 32.h,
          left: 17.w,
          right: 17.w,
        ),
        child: Row(
          children: [
            // 头像
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                  'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg'),
            ),

            // 昵称+ 地区
            Container(
              margin: EdgeInsets.only(
                left: 10.w,
                top: 7.h,
                bottom: 7.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 140.w),
                    child: Text(
                      'account',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.curTheme == ThemeMode.light
                              ? AppColors.secondaryElementText
                              : AppColors.darkSecondaryElementText),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Image.asset(
              'assets/images/two_dimension_code.png',
              width: 14.w,
              height: 14.w,
            ),
            SizedBox(
              width: 8.w,
            ),
            Image.asset(
              'assets/images/link.png',
              width: 14.w,
              height: 14.w,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MineController>(
      init: MineController(),
      id: "mine",
      builder: (_) {
        return Scaffold(
          // appBar: AppBar(title: const Text("mine")),
          body: SafeArea(
            child: _buildPersonInfo(),
          ),
        );
      },
    );
  }
}
