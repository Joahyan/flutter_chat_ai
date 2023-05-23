/*
 * @Author: your name
 * @Date: 2022-04-18 17:16:19
 * @LastEditTime: 2022-04-18 17:16:21
 * @LastEditors: Please set LastEditors
 * @Description: 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 * @FilePath: \amake\lib\pages\application\AndroidBackDesktop.dart
 */
import 'package:flutter/services.dart';
 
class AndroidBackDesktop{
  //通讯名称，回到手机桌面
  static const String CHANNEL = "android/back/desktop";
  //设置回退到手机桌面事件
  static const String eventBackDesktop = "backDesktop";
 
  //设置回退到手机桌面方法
  static Future<bool> backToDesktop() async {
    final platform = MethodChannel(CHANNEL);
    //通知安卓返回到手机桌面
    try{
      await platform.invokeMethod(eventBackDesktop);
      print("通信成功");
    }
    on PlatformException catch (e){
      print("通信失败，设置回退到安卓手机桌面失败");
      print(e.toString());
    }
    return Future.value(false);
  }
}

