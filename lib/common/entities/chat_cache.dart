class ChatCacheEntity {
  int? id;
  int? uptime;
  List<Data>? data;

  ChatCacheEntity({this.id, this.uptime, this.data});

  ChatCacheEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uptime = json['uptime'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['uptime'] = uptime;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? role;
  bool? error;
  String? time;
  String? content;

  Data({this.role, this.error, this.time, this.content});

  Data.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    error = json['error'];
    time = json['time'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['role'] = role;
    data['error'] = error;
    data['time'] = time;
    data['content'] = content;
    return data;
  }
}
