class ChatParamsEntity {
  List<Messages>? messages;
  String? model;
  bool? stream;

  ChatParamsEntity({this.messages, this.model, this.stream = true});

  ChatParamsEntity.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
    model = json['model'];
    stream = json['stream'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    data['model'] = model;
    data['stream'] = stream;
    return data;
  }
}

class Messages {
  String? role;
  String? content;

  Messages({this.role, this.content});

  Messages.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['role'] = role;
    data['content'] = content;
    return data;
  }
}
