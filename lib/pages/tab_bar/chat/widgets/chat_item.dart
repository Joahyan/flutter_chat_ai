import 'package:flutter_chat_ai/common/entities/entities.dart';
import 'package:flutter_chat_ai/common/utils/utils.dart';
import 'package:flutter_chat_ai/pages/chat_info/index.dart';
import 'package:flutter_chat_ai/pages/tab_bar/chat/index.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';

class ChatItem extends GetView<ChatController> {
  ChatSettingEntity chatSettingEntity;
  Function edit;
  Function delete;

  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();

  ChatItem(
      {Key? key,
      required this.chatSettingEntity,
      required this.edit,
      required this.delete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.zero,
      // TODO: 从左只有唤起sliderDraw
      child: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails e) {
          _key.currentState?.openSlider();
        },
        child: SizedBox(
          height: 74.h,
          width: 341.w,
          child: SliderDrawer(
            key: _key,
            sliderOpenSize: 110.w,
            slideDirection: SlideDirection.RIGHT_TO_LEFT,
            appBar: Container(),
            slider: Row(children: [
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                child: SizedBox(
                  height: 73.h,
                  width: 50.w,
                  child: Center(child: Text('edit'.tr)),
                ),
                onPressed: () {
                  _key.currentState?.closeSlider();
                  edit();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  primary: Colors.red,
                ),
                child: SizedBox(
                  height: 73.h,
                  width: 50.w,
                  child: Center(child: Text('remove'.tr)),
                ),
                onPressed: () {
                  _key.currentState?.closeSlider();
                  delete();
                },
              ),
            ]),
            child: InkWell(
              child: Row(
                children: _list(chatSettingEntity),
              ),
              onTap: () {
                Get.lazyPut<ChatInfoController>(() => ChatInfoController());
                Get.lazyPut<ChatInfoProvider>(() => ChatInfoProvider());
                Get.to(ChatInfoPage(), arguments: {
                  'id': chatSettingEntity.id,
                  'title': chatSettingEntity.title,
                  'key': chatSettingEntity.setting?.openaiKey,
                  'model': chatSettingEntity.setting?.engine,
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> _list(ChatSettingEntity item) {
  return <Widget>[
    SizedBox(
      width: 12.w,
    ),
    CircleAvatar(
      backgroundColor: Colors.white,
      radius: 26.sp,
      backgroundImage: const AssetImage('assets/images/chatgpt.png'),
    ),
    SizedBox(
      width: 8.w,
    ),
    Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 11.h),
          height: 20.h,
          width: (item.show ?? false) ? 150.w : 237.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                item.title!,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF23365D),
                    height: 1),
              ),
              Text(
                duTimeLineFormat(item.uptime!),
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF23365D),
                    height: 1),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.h),
          height: 20.h,
          width: (item.show ?? false) ? 150.w : 237.w,
          child: Text(
            item.setting?.systemMessage ?? '',
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF5670A6),
                height: 1.2),
            overflow: TextOverflow.clip,
            maxLines: 1,
          ),
        ),
      ],
    )
  ];
}
