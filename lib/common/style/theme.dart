import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'style.dart';

class AppTheme {
  static ThemeMode curTheme = ThemeMode.light;

  static const lightTheme = NeumorphicThemeData(
      baseColor: AppColors.primaryBackground,
      lightSource: LightSource.topLeft,
      depth: 10,
      appBarTheme: NeumorphicAppBarThemeData(
        textStyle: TextStyle(
            // fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryElement),
        color: AppColors.primaryBackground,
      ));

  static const darkTheme = NeumorphicThemeData(
      baseColor: AppColors.darkBackGround,
      lightSource: LightSource.topLeft,
      depth: 10,
      appBarTheme: NeumorphicAppBarThemeData(
        textStyle: TextStyle(
            // fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.darkPrimaryElement),
        color: AppColors.darkBackGround,
      ));

  static SystemUiOverlayStyle darkStatusTheme =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
  static SystemUiOverlayStyle lightStatusTheme =
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent);

  // 切换主题
  static changeTheme() {
    curTheme = curTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    // NeumorphicTheme.of(context)?.themeMode =curTheme;
    // 修改状态栏字体颜色
    SystemChrome.setSystemUIOverlayStyle(
        curTheme == ThemeMode.light ? darkStatusTheme : darkStatusTheme);
  }
}
