/*
 * @Author: your name
 * @Date: 2021-12-31 15:19:31
 * @LastEditTime: 2022-07-06 15:12:05
 * @LastEditors: joahyan joahyan@163.com
 * @Description: 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 * @FilePath: \flutter_learn_news-1.0.1\lib\common\widgets\common_input.dart
 */
import 'package:flutter_chat_ai/common/style/style.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonInput extends StatelessWidget {
  /// 输入提示信息
  final String hint;

  /// 输入框高度
  final double? height;

  /// 输入框宽度
  final double? width;

  /// 输入框类型
  final TextInputType? textInputType;

  /// 输入框双向绑定的Controller
  final TextEditingController? textController;

  /// 输入框radius
  final BorderRadiusGeometry borderRadius;

  /// 输入框内间距
  final EdgeInsets? contentPadding;

  /// 输入框文本样式
  final TextStyle? textStyle;

  /// 输入框外边距
  final EdgeInsets? margin;

  /// 输入框外颜色
  final Color borderColor;

  /// 是否隐藏内容
  final bool isPassword;

  final Color? backgroundColor;

  final Widget? icon;

  final TextStyle? hintStyle;

  final LinearGradient? gradient;

  final Function? onTap;

  final Function? onSubmit;

  final Function? onChanged;

  final int maxLines;

  final bool readOnly;
  final double depth;
  final double? intensity;
  final LightSource lightSource;
  final Color? shadowDarkColorEmboss;
  final Color? shadowLightColorEmboss;
  final Color? shadowDarkColor;
  final Color? shadowLightColor;
  final NeumorphicBoxShape? boxShape;
  final FocusNode? focusNode;
  final Widget? suffix;
  

  const CommonInput(
      {Key? key,
      this.hint = '请输入',
      this.height,
      this.width,
      this.textInputType,
      this.textController,
      this.borderRadius = Radii.k6pxRadius,
      this.contentPadding,
      this.textStyle,
      this.margin,
      this.borderColor = AppColors.thridElementText,
      this.isPassword = false,
      this.backgroundColor,
      this.icon,
      this.hintStyle,
      this.gradient,
      this.onTap,
      this.onSubmit,
      this.maxLines = 1,
      this.readOnly = false,
      this.depth = -8,
      this.intensity,
      this.lightSource = LightSource.topLeft,
      this.shadowDarkColorEmboss,
      this.shadowLightColorEmboss,
      this.shadowDarkColor,
      this.shadowLightColor,
      this.boxShape,
      this.focusNode,
      this.suffix,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    LinearGradient curGradient = const LinearGradient(
      colors: [
        Color(0xFFF2F9FF),
        Color(0xFFF2F9FF),
      ],
    );
    if (AppTheme.curTheme == ThemeMode.dark) {
      curGradient = const LinearGradient(
        colors: [
          Color(0xFF22252D),
          Color(0xFF22252D),
        ],
      );
    }

    return NeumorphicTheme(
      themeMode: AppTheme.curTheme,
      theme: NeumorphicThemeData(
        depth: depth,
        intensity: intensity ?? 1,
        lightSource: lightSource,
        shadowDarkColorEmboss:
            shadowDarkColorEmboss ?? const Color.fromRGBO(207, 221, 237, 1),
        shadowLightColorEmboss:
            shadowLightColorEmboss ?? const Color.fromRGBO(255, 255, 255, 0.75),
        shadowLightColor:
            shadowLightColor ?? NeumorphicColors.decorationMaxWhiteColor,
        shadowDarkColor:
            shadowDarkColor ?? NeumorphicColors.decorationMaxDarkColor,
        boxShape:
            boxShape ?? NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
      ),
      darkTheme: NeumorphicThemeData(
        depth: depth,
        baseColor: AppColors.darkCellBgColor,
        intensity: intensity ?? 0.75,
        lightSource: lightSource,
        shadowDarkColorEmboss:
            shadowDarkColorEmboss ?? const Color.fromRGBO(0, 0, 0, 0.57),
        shadowLightColorEmboss:
            shadowLightColorEmboss ?? const Color.fromRGBO(42, 43, 51, 1),
        shadowLightColor:
            shadowLightColor ?? NeumorphicColors.decorationMaxWhiteColor,
        shadowDarkColor:
            shadowDarkColor ?? NeumorphicColors.decorationMaxDarkColor,
        boxShape:
            boxShape ?? NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
      ),
      child: Neumorphic(
        margin: margin ??
            EdgeInsets.only(
              top: 12.h,
              left: 17.w,
              right: 17.w,
            ),
        child: Container(
          height: height ?? 30.h,
          width: width ?? 341.w,
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          decoration: BoxDecoration(
            gradient: gradient ?? curGradient,
          ),
          child: Center(
            child: TextField(
              controller: textController,
              keyboardType: textInputType,
              focusNode: focusNode,
              onTap: () {
                if (onTap != null) {
                  onTap!();
                }
              },
              onSubmitted: (val) {
                if (onSubmit != null) {
                  onSubmit!();
                }
              },
              onChanged: (val) {
                if (onChanged != null) {
                  onChanged!();
                }
              },
              readOnly: readOnly,
              style: textStyle ??
                  TextStyle(
                    color: AppTheme.curTheme == ThemeMode.light
                        ? AppColors.primaryElement
                        : AppColors.darkPrimaryElement,
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.w400,
                    fontSize: 18.sp,
                  ),
              maxLines: maxLines,
              autocorrect: false, // 自动纠正
              obscureText: isPassword, // 隐藏输入内容
              decoration: InputDecoration(
                icon: icon,
                hintText: hint,
                hintStyle: hintStyle ??
                    TextStyle(
                      color: AppTheme.curTheme == ThemeMode.light
                          ? AppColors.hintElementText
                          : AppColors.darkHintElementText,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                isDense: true,
                contentPadding: const EdgeInsets.all(0),
                border: InputBorder.none,
                suffix: suffix,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
