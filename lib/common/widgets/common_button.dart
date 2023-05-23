/*
 * @Author: joahyan joahyan@163.com
 * @Date: 2022-06-22 21:20:50
 * @LastEditors: joahyan joahyan@163.com
 * @LastEditTime: 2022-07-06 14:34:14
 * @FilePath: \amake\lib\pages\common\common_button.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:flutter_chat_ai/common/style/style.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    this.title,
    required this.onTap,
    this.bgColor,
    this.txtColor = AppColors.secondaryElementText,
    this.borderRadius = const BorderRadius.all(Radius.circular(23)),
    this.width,
    this.height,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.shape = NeumorphicShape.flat,
  }) : super(key: key);
  final String? title;
  final Function onTap;
  final Color? bgColor;
  final Color txtColor;
  final BorderRadius borderRadius;
  final double? width;
  final double? height;
  final double fontSize;
  final FontWeight fontWeight;
  final NeumorphicShape shape;

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: AppTheme.curTheme,
      theme: NeumorphicThemeData(
        buttonStyle: NeumorphicStyle(
          color: bgColor ?? AppColors.btnBgColor,
          depth: 13,
          boxShape: NeumorphicBoxShape.roundRect(
            borderRadius,
          ),
          shape: shape,
        ),
      ),
      darkTheme: NeumorphicThemeData(
        buttonStyle: NeumorphicStyle(
          color: bgColor ?? AppColors.darkBtnBgColor,
          depth: 4,
          shadowLightColor: Color.fromRGBO(51, 58, 64, 1),
          shadowDarkColor: Color.fromRGBO(20, 24, 26, 1),
          boxShape: NeumorphicBoxShape.roundRect(
            borderRadius,
          ),
          shape: shape,
        ),
      ),
      child: NeumorphicButton(
        padding: const EdgeInsets.all(0),
        child: Container(
          height: height ?? 45.h,
          width: width ?? 341.w,
          alignment: Alignment.center,
          child: Text(
            title!,
            style: TextStyle(
              color: AppTheme.curTheme == ThemeMode.light
                  ? AppColors.labelElementText
                  : AppColors.darkLabelElementText,
              fontSize: 14.sp,
            ),
          ),
        ),
        onPressed: () {
          onTap();
        },
      ),
    );
  }
}
