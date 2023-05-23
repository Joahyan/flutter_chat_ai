import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ai/common/entities/chat_params.dart';
import 'package:flutter_chat_ai/common/entities/entities.dart';
import 'package:flutter_chat_ai/common/utils/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'index.dart';

class ChatInfoController extends GetxController {
  ChatInfoController();
  final state = ChatInfoState();
  // 获取实例
  final provider = Get.find<ChatInfoProvider>();

  late TextEditingController textEditingController;

  late ScrollController scrollController;

  late ImagePicker picker;

  Future chosePic(ImageSource source) async {
    XFile? xfile = await picker.pickImage(source: source);
    state.image.value = xfile as File;
  }

  initMessage(int id) async {
    List<ChatCacheEntity> chatCacheEntities = StorageUtil().getChatCache();
    if (chatCacheEntities.isEmpty) {
      await rootBundle.loadString("assets/chat/chat_cache.json").then((value) {
        List jsonList = jsonDecode(value);
        StorageUtil().setChatCache(value);
        for (var item in jsonList) {
          ChatCacheEntity cacheEntity = ChatCacheEntity.fromJson(item);
          if (cacheEntity.id == id) {
            state.chatCacheEntity.value = cacheEntity;
          }
        }
      });
    } else {
      for (var item in chatCacheEntities) {
        if (item.id == id) {
          state.chatCacheEntity.value = item;
        }
      }
    }
  }

  sendMessage() async {
    var arguments = Get.arguments;
    var key = arguments['key'];
    var model = arguments['model'];

    List<Messages> messages = [];
    // 总共传三条数据，实现上下文光联
    List<Data> datas = state.chatCacheEntity.value.data ?? [];
    if (datas.length > 1) {
      var data = datas[datas.length - 2];
      messages.add(Messages(role: data.role, content: data.content));
    }
    if (datas.isNotEmpty) {
      var data = datas[datas.length - 1];
      messages.add(Messages(role: data.role, content: data.content));
    }
    messages.add(Messages(role: 'user', content: textEditingController.text));
    ChatParamsEntity params =
        ChatParamsEntity(messages: messages, model: model);
    EasyLoading.show(status: 'loading...');
    var res = await provider.sendMsg(params, key);
    EasyLoading.dismiss();
    // 发送的数据
    state.chatCacheEntity.value.data?.add(
      Data(
          role: 'user',
          error: false,
          content: textEditingController.text,
          time: DateTime.now().millisecondsSinceEpoch.toString()),
    );
    textEditingController.text = '';
    // 响应
    if (res.hasError) {
      printError(info: jsonEncode(res.body['message']));
      state.chatCacheEntity.value.data?.add(
        Data(
            role: 'assistant',
            error: true,
            content: '',
            time: DateTime.now().millisecondsSinceEpoch.toString()),
      );
    } else {
      List<String> dataList =
          res.bodyString?.split('data: ') ?? []; // 将数据划分为多个字符串
      // var isFirst = true;
      // var index = state.chatCacheEntity.value.data?.length ?? 0;
      var str = '';
      var time = '';
      for (String d in dataList) {
        // TODO: 文字输入效果
        if (d.isNotEmpty && !d.contains('[DONE]')) {
          Map<String, dynamic> result = jsonDecode(d);
          str = '$str${result['choices'][0]['delta']['content'] ?? ''}';
          time = result['created'].toString();
          // if (isFirst) {
          //   isFirst = false;
          //   state.chatCacheEntity.value.data?.add(Data(
          //     role: 'assistant',
          //     error: true,
          //     content: result['choices'][0]['delta']['content'],
          //     time: result['created'].toString(),
          //   ));
          // } else {
          //   state.chatCacheEntity.value.data?[index] = Data(
          //     role: 'assistant',
          //     error: true,
          //     content: state.chatCacheEntity.value.data?[index].content ??
          //         '' + result['choices'][0]['delta']['content'],
          //     time: result['created'].toString(),
          //   );
          // }
        }
      }
      state.chatCacheEntity.value.data?.add(Data(
        role: 'assistant',
        error: true,
        content: str,
        time: time,
      ));
    }
    List<ChatCacheEntity> chatCacheEntities = StorageUtil().getChatCache();
    var status = true;
    // 若之前存在聊天，则覆盖之前数据
    for (var i = 0; i < chatCacheEntities.length; i++) {
      if (chatCacheEntities[i].id == arguments['id']) {
        status = false;
        chatCacheEntities[i] = state.chatCacheEntity.value;
        break;
      }
    }
    // 不存在，则新增
    if (status) {
      chatCacheEntities.add(state.chatCacheEntity.value);
    }
    // 存入缓存
    StorageUtil().setChatCache(jsonEncode(chatCacheEntities));
    jumpToBottom();
    update(['chatbox']);
  }

  /// 滚动至底部
  jumpToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();
    scrollController = ScrollController();
    picker = ImagePicker();
    var arguments = Get.arguments;
    state.title.value = arguments['title'];
    state.id.value = arguments['id'];
    initMessage(state.id.value);
    jumpToBottom();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
