import 'package:flutter/material.dart';
import 'package:flutter_chat_ai/common/style/style.dart';
import 'package:flutter_chat_ai/pages/tab_bar/chat/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IndexBar extends GetView<ChatController> {
  const IndexBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> words = [];
    for (int i = 0; i < INDEX_WORDS.length; i++) {
      words.add(Expanded(
          child: Center(
        child: Obx(() => Text(INDEX_WORDS[i],
            style: TextStyle(
              backgroundColor:
                  controller.state.indicatorText.value == INDEX_WORDS[i]
                      ? controller.state.backColor.value
                      : Colors.transparent,
              color: AppTheme.curTheme == ThemeMode.light
                  ? AppColors.labelElementText
                  : AppColors.darkLabelElementText,
              fontWeight: FontWeight.w500,
              fontSize: 10.sp,
            ))),
      )));
    }
    return Positioned(
      right: 0.0,
      top: MediaQuery.of(context).size.height / 6,
      height: MediaQuery.of(context).size.height / 2,
      width: 130.w,
      child: Obx(() => Row(
            children: [
              //指示器
              Container(
                alignment: Alignment(0, controller.state.indicatorY.value),
                width: 100,
                child: controller.state.indicatorHidden.value
                    ? null
                    : Stack(
                        alignment: const Alignment(-0.2, 0),
                        children: [
                          Text(
                            controller.state.indicatorText.value,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          )
                        ],
                      ),
              ),

              // 索引
              GestureDetector(
                onVerticalDragDown: (DragDownDetails details) {
                  int index = getIndexItem(context, details.globalPosition);
                  controller.onVerticalDragDown(index);
                  controller.indexBarScroll(index);
                },
                onVerticalDragEnd: (DragEndDetails details) {
                  controller.onVerticalDragEnd();
                },
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  int index = getIndexItem(context, details.globalPosition);
                  controller.onVerticalDragUpdate(index);
                  controller.indexBarScroll(index);
                },
                child: Container(
                  width: 20.w,
                  color: controller.state.backColor.value,
                  child: Column(
                    children: words,
                  ),
                ),
              )
            ],
          )),
    );
  }
}

int getIndexItem(BuildContext context, Offset globalPosition) {
  //拿到当前盒子
  RenderBox box = context.findRenderObject() as RenderBox;
  //拿到y值，当前位置到部件原点(部件左上角)的距离(x,y)
  var y = box.globalToLocal(globalPosition).dy;
  //算出字符高度
  var itemHeight = MediaQuery.of(context).size.height / 2 / INDEX_WORDS.length;
  int index =
      y ~/ itemHeight.clamp(0, INDEX_WORDS.length - 1); //~取整,设置取整范围clamp
  return index;
}

// ignore: constant_identifier_names
const INDEX_WORDS = [
  '🔍',
  '☆',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
