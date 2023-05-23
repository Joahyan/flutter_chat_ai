class ChatSettingEntity {
  int? id;
  String? model;
  String? title;
  int? uptime;
  Setting? setting;
  bool? show;
  String? indexLetter;

  ChatSettingEntity({
    this.id,
    this.model,
    this.title,
    this.uptime,
    this.setting,
    this.show = false,
    this.indexLetter = '',
  });

  ChatSettingEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    title = json['title'];
    uptime = json['uptime'];
    setting =
        json['setting'] != null ? Setting.fromJson(json['setting']) : null;
    show = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['model'] = model;
    data['title'] = title;
    data['uptime'] = uptime;
    if (setting != null) {
      data['setting'] = setting!.toJson();
    }
    data['show'] = false;
    return data;
  }
}

class Setting {
  String? openaiKey;
  String? temperature;
  String? topP;
  String? presencePenalty;
  String? frequencyPenalty;
  String? replyCount;
  String? engine;
  String? apiUrl;
  String? contextSize;
  String? systemMessage;
  String? apiKey;

  Setting({
    this.openaiKey,
    this.temperature,
    this.topP,
    this.presencePenalty,
    this.frequencyPenalty,
    this.replyCount,
    this.engine,
    this.apiUrl,
    this.contextSize,
    this.systemMessage,
    this.apiKey,
  });

  Setting.fromJson(Map<String, dynamic> json) {
    openaiKey = json['openai_key'];
    temperature = json['temperature'];
    topP = json['top_p'];
    presencePenalty = json['presence_penalty'];
    frequencyPenalty = json['frequency_penalty'];
    replyCount = json['reply_count'];
    engine = json['engine'];
    apiUrl = json['api_url'];
    contextSize = json['context_size'];
    systemMessage = json['system_message'];
    apiKey = json['api_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['openai_key'] = openaiKey;
    data['temperature'] = temperature;
    data['top_p'] = topP;
    data['presence_penalty'] = presencePenalty;
    data['frequency_penalty'] = frequencyPenalty;
    data['reply_count'] = replyCount;
    data['engine'] = engine;
    data['api_url'] = apiUrl;
    data['context_size'] = contextSize;
    data['system_message'] = systemMessage;
    data['api_key'] = apiKey;
    return data;
  }
}
