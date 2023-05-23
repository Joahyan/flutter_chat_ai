/*
 * @Author: joahyan joahyan@163.com
 * @Date: 2022-07-15 14:50:44
 * @LastEditors: joahyan joahyan@163.com
 * @LastEditTime: 2022-07-15 14:50:45
 * @FilePath: \surnote\lib\common\router\router.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:get/get.dart';

class XRouter {
  static void goWeb(String url, String title) {
    Get.toNamed(
        "/web?url=${Uri.encodeComponent(url)}&title=${Uri.encodeComponent(title)}");
  }
}
