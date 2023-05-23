/*
 * @Author: joahyan joahyan@163.com
 * @Date: 2022-06-22 21:11:13
 * @LastEditors: joahyan joahyan@163.com
 * @LastEditTime: 2022-06-25 16:32:19
 * @FilePath: \amaked:\developSoftware\flutter_windows_2.2.3-stable\flutter\.pub-cache\hosted\pub.dartlang.org\flutter_neumorphic-3.2.0\lib\src\widget\floating_action_button.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCircleButton extends StatelessWidget {
  final Widget? child;
  final NeumorphicButtonClickListener? onPressed;
  final bool mini;
  final String? tooltip;
  final NeumorphicStyle? style;
  final EdgeInsets? padding;

  const AppCircleButton({
    Key? key,
    this.mini = false,
    this.style,
    this.tooltip,
    @required this.child,
    @required this.onPressed,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var constrainedBox = UnconstrainedBox(
      child: NeumorphicButton(
        padding: padding ?? EdgeInsets.all(8.w),
        onPressed: onPressed,
        tooltip: tooltip,
        style: style ??
            NeumorphicTheme.currentTheme(context)
                .appBarTheme
                .buttonStyle
                .copyWith(
                  depth: 2,
                  intensity: 1,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(28),
                  ),
                ),
        child: child,
      ),
    );
    return constrainedBox;
  }
}
