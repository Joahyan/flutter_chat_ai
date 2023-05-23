/*
 * @Author: joahyan joahyan@163.com
 * @Date: 2022-07-15 14:50:28
 * @LastEditors: joahyan joahyan@163.com
 * @LastEditTime: 2022-07-15 14:55:54
 * @FilePath: \surnote\lib\common\router\route_map.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:flutter_chat_ai/pages/404/view.dart';
import 'package:flutter_chat_ai/pages/application/index.dart';
import 'package:flutter_chat_ai/pages/chat_info/index.dart';
import 'package:flutter_chat_ai/pages/tab_bar/records/index.dart';
import 'package:get/get.dart';

class RouteMap {
  static List<GetPage> getPages = [
    GetPage(
      name: '/',
      page: () => const ApplicationPage(),
      binding: ApplicationBinding(),
    ),
    GetPage(
      name: '/records',
      page: () => const RecordsPage(),
      binding: RecordsBinding(),
    ),
    GetPage(
      name: '/chatInfo',
      page: () => ChatInfoPage(),
      binding: ChatInfoBinding(),
    ),
    // GetPage(name: '/setting', page: () => SettingPage()),
  ];

  static GetPage unKownRouter =
      GetPage(name: '/notfound', page: () => const NotFoundPage());
}
