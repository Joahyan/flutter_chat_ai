import 'package:flutter_chat_ai/common/style/color.dart';
import 'package:flutter_chat_ai/common/widgets/common_button.dart';
import 'package:flutter_chat_ai/common/widgets/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);

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
          ),
        ),
        actions: [
          AppCircleButton(
              child: Image.asset(
                'assets/images/add.png',
              ),
              onPressed: () {
                controller.state.id.value = 0;
                controller.titleController.text = '';
                controller.keyController.text = '';
                controller.engineController.text = 'gpt-3.5-turbo';
                controller.messageController.text = '';
                Get.bottomSheet(_buildBottomSheet());
              }),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    TextStyle txtStyle = TextStyle(
      color: AppColors.secondaryElementText,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
    return Container(
      padding: EdgeInsets.only(top: 16.h),
      height: Get.height * 0.7,
      color: AppColors.primaryBackground,
      child: Form(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 17.w, top: 12.h),
              child: Text(
                'chat tile',
                style: txtStyle,
              ),
            ),
            CommonInput(
              textController: controller.titleController,
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.w, top: 12.h),
              child: Text(
                'OpenAIKey',
                style: txtStyle,
              ),
            ),
            CommonInput(
              isPassword: true,
              textController: controller.keyController,
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.w, top: 12.h),
              child: Text(
                'engine',
                style: txtStyle,
              ),
            ),
            CommonInput(
              textController: controller.engineController,
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.w, top: 12.h),
              child: Text(
                'sys message',
                style: txtStyle,
              ),
            ),
            CommonInput(
              height: 80.h,
              maxLines: 3,
              textController: controller.messageController,
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.w, top: 24.h),
              child: CommonButton(
                  title: 'confirm',
                  onTap: () {
                    controller.handleSubmit();
                  }),
            )
          ],
        ),
      )),
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
              return ChatItem(
                chatSettingEntity: controller.state.chatSettingEntity[index],
                edit: () {
                  var data = controller.state.chatSettingEntity[index];
                  controller.state.id.value = data.id ?? 0;
                  controller.titleController.text = data.title ?? '';
                  controller.keyController.text = data.setting?.openaiKey ?? '';
                  controller.engineController.text =
                      data.setting?.engine ?? 'gpt-3.5-turbo';
                  controller.messageController.text =
                      data.setting?.systemMessage ?? '';
                  Get.bottomSheet(_buildBottomSheet());
                },
                delete: () {},
              );
            }).toList(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              children: [
                _buildInput(),
                _buildChatList(),
              ],
            ),
          ),
          const IndexBar()
        ],
      ),
    );
  }
}
