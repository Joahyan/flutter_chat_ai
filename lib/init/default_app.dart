/*
 * @Author: joahyan joahyan@163.com
 * @Date: 2022-07-15 15:02:28
 * @LastEditors: joahyan joahyan@163.com
 * @LastEditTime: 2022-11-25 13:49:11
 * @FilePath: \emr_app\lib\init\default_app.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_chat_ai/common/langs/translation_service.dart';
import 'package:flutter_chat_ai/common/style/style.dart';
import 'package:flutter_chat_ai/common/utils/utils.dart';
import 'package:flutter_chat_ai/routers/route_map.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

//默认App的启动
class DefaultApp {
  //运行app
  static void run() {
    WidgetsFlutterBinding.ensureInitialized();
    // debugPaintSizeEnabled = true;
    initFirst().then((value) => runApp(MyApp()));
    initApp();
  }

  /// 必须要优先初始化的内容
  static Future<void> initFirst() async {
    await StorageUtil.init();
    // 顶部透明色
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  /// 程序初始化操作
  static void initApp() {
    // 初始化window
    if (Platform.isWindows) {}
  }
}

class MyApp extends StatelessWidget {
  ThemeData _getMaterialTheme(NeumorphicThemeData theme) {
    final color = theme.accentColor;
    if (color is MaterialColor) {
      return ThemeData(
        primarySwatch: color,
        textTheme: theme.textTheme,
        iconTheme: theme.iconTheme,
        scaffoldBackgroundColor: theme.baseColor,
      );
    }
    return ThemeData(
      primaryColor: theme.accentColor,
      accentColor: theme.variantColor,
      iconTheme: theme.iconTheme,
      brightness: ThemeData.estimateBrightnessForColor(theme.baseColor),
      primaryColorBrightness:
          ThemeData.estimateBrightnessForColor(theme.accentColor),
      accentColorBrightness:
          ThemeData.estimateBrightnessForColor(theme.variantColor),
      textTheme: theme.textTheme,
      scaffoldBackgroundColor: theme.baseColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = _getMaterialTheme(AppTheme.lightTheme);
    final materialDarkTheme = _getMaterialTheme(AppTheme.darkTheme);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return NeumorphicTheme(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: AppTheme.curTheme,
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'WeChatAI',
            unknownRoute: RouteMap.unKownRouter,
            getPages: RouteMap.getPages,
            defaultTransition: Transition.rightToLeft,
            theme: materialTheme,
            darkTheme: materialDarkTheme,
            translations: TranslationService(), // your translations
            locale: const Locale('en', 'US'),
            builder: EasyLoading.init(),
          ),
        );
      },
    );
  }
}
