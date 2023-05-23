import 'dart:convert';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter_chat_ai/common/entities/entities.dart';
import 'package:flutter_chat_ai/common/style/style.dart';
import 'package:flutter_chat_ai/common/widgets/widgets.dart';
import 'package:flutter_chat_ai/pages/chat_info/widgets/widgets.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class ChatInfoPage extends GetView<ChatInfoController> {
  ChatInfoPage({Key? key}) : super(key: key);

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.h),
      child: NeumorphicAppBar(
        padding: 5.w,
        centerTitle: true,
        color: AppTheme.curTheme == ThemeMode.light
            ? AppColors.primaryBackground
            : AppColors.darkBackGround,
        leading: AppCircleButton(
          child: Image.asset('assets/images/back.png'),
          style: NeumorphicStyle(
            depth: 2,
            intensity: 1,
            color: AppTheme.curTheme == ThemeMode.light
                ? AppColors.btnBgColor
                : AppColors.darkBtnBgColor,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(28),
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Container(
          margin: EdgeInsets.only(left: 5.w),
          child: Text(
            controller.state.title.value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.curTheme == ThemeMode.light
                  ? AppColors.labelElementText
                  : AppColors.darkLabelElementText,
            ),
          ),
        ),
      ),
    );
  }

  /// 聊天框
  Widget _buildChatBox() {
    return Container(
      padding:
          EdgeInsets.only(top: 24.h, left: 17.w, right: 17.w, bottom: 10.h),
      child: GetBuilder<ChatInfoController>(
        id: 'chatbox',
        initState: (_) {},
        builder: (_) {
          return ListView.builder(
              controller: controller.scrollController,
              itemCount:
                  controller.state.chatCacheEntity.value.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return ChatInfoItem(
                  data: controller.state.chatCacheEntity.value.data?[index] ??
                      Data(),
                );
              });
        },
      ),
    );
  }

  /// 输入框
  Widget _buildInputBox() {
    return Container(
        height: 120.h,
        width: 375.w,
        padding: EdgeInsets.only(bottom: 26.h),
        decoration: BoxDecoration(
            color: AppTheme.curTheme == ThemeMode.light
                ? AppColors.bottomBgColor
                : AppColors.darkBottomBgColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 1),
                offset: Offset(0, -2),
                blurRadius: 8,
                spreadRadius: 0,
              )
            ]),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonInput(
              textController: controller.textEditingController,
              height: 40.h,
              hint: 'sendMsg'.tr,
              onSubmit: () {
                controller.sendMessage();
              },
              onChanged: () {},
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10.h,
                left: 24.w,
                right: 24.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Image.asset('assets/images/emoji.png'),
                    onTap: () {
                      controller.state.isOpenEmoji.value = true;
                      controller.state.isOpenAdd.value = false;
                      controller.state.isOpenImage.value = false;

                      // setState(() {
                      //   isOpenImage = false;
                      //   isOpenAdd = false;
                      //   isOpenEmoji = true;
                      // });
                    },
                  ),
                  InkWell(
                    child: Image.asset('assets/images/red_paper.png'),
                    onTap: () {},
                  ),
                  InkWell(
                    child: Image.asset('assets/images/transfer_account.png'),
                    onTap: () {
                      // context.router.push(TransfersAccountRoute());
                    },
                  ),
                  InkWell(
                    child: Image.asset('assets/images/picture.png'),
                    onTap: () {
                      // setState(() {
                      //   isOpenEmoji = false;
                      //   isOpenAdd = false;
                      //   isOpenImage = true;
                      // });
                    },
                  ),
                  InkWell(
                    child: Image.asset('assets/images/circle_add.png'),
                    onTap: () {
                      // setState(() {
                      //   isOpenEmoji = false;
                      //   isOpenImage = false;
                      //   isOpenAdd = true;
                      // });
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buildEmojiList() {
    return Obx(() => controller.state.isOpenEmoji.value
        ? Expanded(
            flex: 3,
            child: EmojiPicker(
                config: Config(
                  columns: 8,
                  emojiSizeMax: 24 * (Platform.isIOS ? 1.30 : 1.0),
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  gridPadding: EdgeInsets.zero,
                  initCategory: Category.SMILEYS,
                  bgColor: AppTheme.curTheme == ThemeMode.light
                      ? AppColors.bottomBgColor
                      : AppColors.darkBottomBgColor,
                  indicatorColor: Colors.blue,
                  iconColor: Colors.grey,
                  iconColorSelected: Colors.blue,
                  // progressIndicatorColor: Colors.blue,
                  backspaceColor: Colors.blue,
                  skinToneDialogBgColor: Colors.white,
                  skinToneIndicatorColor: Colors.grey,
                  enableSkinTones: true,
                  showRecentsTab: true,
                  recentsLimit: 28,
                  // noRecents: Text(
                  //   FlutterI18n.translate(context, "chatBox.noRecent"),
                  //   style: TextStyle(fontSize: 20, color: Colors.black26),
                  //   textAlign: TextAlign.center,
                  // ),
                  tabIndicatorAnimDuration: kTabScrollDuration,
                  categoryIcons: const CategoryIcons(),
                  buttonMode: ButtonMode.MATERIAL,
                ),
                onEmojiSelected: (emoji, category) {
                  controller.textEditingController.text =
                      controller.textEditingController.text + category.emoji;
                },
                onBackspacePressed: () {
                  controller.state.isOpenEmoji.value = false;
                }))
        : Container());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: InkWell(
              onTap: () {},
              child: _buildChatBox(),
            ),
          ),
          _buildInputBox(),
          // 表情
          _buildEmojiList(),
          // 图片
          // _buildImagePicker(),
          // // 加号
          // _buildOtherGridList(),
        ],
      ),
    );
  }
}
