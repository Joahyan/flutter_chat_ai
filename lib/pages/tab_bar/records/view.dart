import 'package:flutter_chat_ai/common/entities/entities.dart';
import 'package:flutter_chat_ai/common/utils/utils.dart';
import 'package:flutter_chat_ai/common/widgets/widgets.dart';
import 'package:flutter_chat_ai/pages/tab_bar/chat/widgets/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class RecordsPage extends GetView<RecordsController> {
  const RecordsPage({Key? key}) : super(key: key);

  /// 构建appBar
  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.h),
      child: NeumorphicAppBar(
        padding: 5.w,
        title: Text(
          'chats'.tr,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'PingFangSC-Semibold, PingFang SC'),
        ),
        actions: [
          AppCircleButton(
              child: Image.asset(
                'assets/images/add.png',
              ),
              onPressed: () {}),
        ],
      ),
    );
  }

  /// 搜索框
  Widget _buildInput() {
    return CommonInput(
      // textController: _textEditingController,
      onSubmit: () {},
      height: 40.h,
      hint: '请输入搜索内容',
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      icon: Image.asset(
        'assets/images/search.png',
      ),
    );
  }

  /// 构建聊天列表
  Widget _buildChatList() {
    return Container(
      margin: EdgeInsets.only(
        top: 12.h,
      ),
      child: Obx(() => Column(
            children:
                controller.state.chatSettingEntity.asMap().keys.map((index) {
              return Container();
            }).toList(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 80.h,
          width: 375.w,
          child: Column(
            children: [
              NeumorphicButton(
                child: Text('click'),
                onPressed: () {
                  controller.formatStr();
                },
              ),
              NeumorphicButton(
                child: Text('清除设置缓存'),
                onPressed: () {
                  StorageUtil().setChatSetting("");
                },
              ),
              NeumorphicButton(
                child: Text('清除聊天记录缓存'),
                onPressed: () {
                  StorageUtil().setChatCache("");
                },
              ),
            ],
          ),
          // child: SliderDrawer(
          //   sliderOpenSize: 100.w,
          //   appBar: Container(),
          //   slideDirection: SlideDirection.RIGHT_TO_LEFT,
          //   slider: Container(color: Colors.red),
          //   child: Container(color: Colors.amber),
          // ),
        ),
      ],
    ));
  }
}
