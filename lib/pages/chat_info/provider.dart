import 'dart:convert';
// import 'dart:html';
import 'dart:io';

import 'package:flutter_chat_ai/common/entities/chat_params.dart';
import 'package:get/get.dart';

class ChatInfoProvider extends GetConnect {
  Future<Response> sendMsg(ChatParamsEntity params, String key) async {
    Map<String, String> headers = Map<String, String>();
    headers['authorization'] = 'Bearer $key';
    headers['Content-Type'] = 'application/json';
    headers['Accept'] = 'text/event-stream';
    return await post(
      'https://api.openai.com/v1/chat/completions',
      jsonEncode(params),
      headers: headers,
    );
  }


    Future<List> sendMsg1(ChatParamsEntity params, String key) async {
    final client = HttpClient();
    final request = await client
        .postUrl(Uri.parse('https://api.openai.com/v1/chat/completions'));

    request.headers.set('authorization', 'Bearer $key');
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('Accept', 'text/event-stream');
    request.write(jsonEncode(params));
    final response = await request.close();
    List info = [];
    await for (var event
        in response.transform(utf8.decoder).transform(const LineSplitter())) {
      if (event.startsWith('data: ')) {
        final jsonData = jsonDecode(event.substring(6));
        info.add(jsonData);
        print(jsonData);
      }
    }
    return info;
  }
}


