import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ai/common/style/style.dart';
import 'package:flutter_highlight/themes/a11y-dark.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/all.dart';

Map<String, TextStyle> darkTheme = a11yDarkTheme;

// update('root', (value) => TextStyle(backgroundColor: Color(0xff2b2b2b), color: Color(0xfff8f8f2)));

MarkdownConfig customMarkdownConfig = MarkdownConfig(configs: [
  PreConfig.darkConfig.copy(
    // TODO:调整代码背景颜色
    textStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    ),
    // theme: ,
    wrapper: (preWidget, code) {
      return Stack(
        children: <Widget>[
          preWidget,
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: 14.h, left: 8.w),
              width: 40.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: const BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                icon: Image.asset(
                  'assets/images/copy.png',
                  width: 14.w,
                  height: 14.w,
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                  // TODO:提示复制成功
                }),
          )
        ],
      );
    },
  ),
  PConfig(
      textStyle: TextStyle(
    color: AppTheme.curTheme == ThemeMode.light
        ? AppColors.secondaryElementText
        : AppColors.darkSecondaryElementText,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
  )),
  CodeConfig(
      style: TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Colors.red,
  ))
]);
