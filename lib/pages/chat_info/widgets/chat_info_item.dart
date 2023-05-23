import 'package:flutter_chat_ai/common/entities/entities.dart';
import 'package:flutter_chat_ai/common/style/style.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:markdown_widget/markdown_widget.dart';

class ChatInfoItem extends StatelessWidget {
  Data data;
  ChatInfoItem({Key? key, required this.data}) : super(key: key);

  final TocController controller = TocController();

  // markdown样式、配置调整
  Widget buildMarkdown() => Column(
          children: MarkdownGenerator(
                  // TODO:
                  config: customMarkdownConfig)
              .buildWidgets(
        data.content ?? '',
      ));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 26.h),
      child: Row(
        textDirection:
            data.role == 'assistant' ? TextDirection.ltr : TextDirection.rtl,
        children: [
          // 头像
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 18.sp,
            backgroundImage: const AssetImage('assets/images/chatgpt.png'),
          ),

          SizedBox(
            width: 8.w,
          ),
          // 昵称 + 消息
          Column(
            crossAxisAlignment: data.role == 'assistant'
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              // 昵称
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 140.w),
                child: Text(
                  data.role ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: 'PingFangSC-Semibold, PingFang SC',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.senderText),
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              // 消息
              NeumorphicTheme(
                  theme: const NeumorphicThemeData(
                    baseColor: AppColors.cellBgColor,
                    depth: 13,
                    intensity: 1,
                    shadowDarkColor: Color.fromRGBO(212, 221, 232, 1),
                    shadowLightColor: Color.fromRGBO(255, 255, 255, 0.56),
                    shadowLightColorEmboss: Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                  darkTheme: const NeumorphicThemeData(
                    baseColor: AppColors.darkCellBgColor,
                    depth: 6,
                    intensity: 1,
                    shadowDarkColor: Color.fromRGBO(20, 24, 26, 1),
                    shadowLightColor: Color.fromRGBO(51, 58, 64, 1),
                    shadowLightColorEmboss: Color.fromRGBO(62, 75, 91, 0.44),
                  ),
                  themeMode: AppTheme.curTheme,
                  child: Neumorphic(
                      padding:
                          EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
                      child: SizedBox(
                        width: 220.w,
                        child: SelectionArea(child: buildMarkdown()),
                      ))),
            ],
          )
        ],
      ),
    );
  }
}
