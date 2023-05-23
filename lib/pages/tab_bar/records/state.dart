import 'package:flutter_chat_ai/common/entities/entities.dart';
import 'package:get/get.dart';

class RecordsState {
  RxList<ChatCacheEntity> chatCacheEntity = <ChatCacheEntity>[].obs;
  RxList<ChatSettingEntity> chatSettingEntity = <ChatSettingEntity>[].obs;

  RxString chatgptStr =
      'data: {"id":"chatcmpl-7HWX5JTey8jhtLiEvRf9HfTkFU8qP","object":"chat.completion.chunk","created":1684410987,"model":"gpt-3.5-turbo-0301","choices":[{"delta":{"role":"assistant"},"index":0,"finish_reason":null}]}data: {"id":"chatcmpl-7HWX5JTey8jhtLiEvRf9HfTkFU8qP","object":"chat.completion.chunk","created":1684410987,"model":"gpt-3.5-turbo-0301","choices":[{"delta":{"content":"呵"},"index":0,"finish_reason":null}]}data: {"id":"chatcmpl-7HWX5JTey8jhtLiEvRf9HfTkFU8qP","object":"chat.completion.chunk","created":1684410987,"model":"gpt-3.5-turbo-0301","choices":[{"delta":{"content":"呵"},"index":0,"finish_reason":null}]}data: {"id":"chatcmpl-7HWX5JTey8jhtLiEvRf9HfTkFU8qP","object":"chat.completion.chunk","created":1684410987,"model":"gpt-3.5-turbo-0301","choices":[{"delta":{},"index":0,"finish_reason":"stop"}]}data: [DONE]'
          .obs;
}
