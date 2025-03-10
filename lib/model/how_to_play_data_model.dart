class HowToPlayModel {
  List<HowToPlayData>? data;
  String? msg;
  String? status;

  HowToPlayModel({this.data, this.msg, this.status});

  HowToPlayModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <HowToPlayData>[];
      json['data'].forEach((v) {
        data!.add(HowToPlayData.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class HowToPlayData {
  int? id;
  int? gameId;
  String? title;
  String? description;

  HowToPlayData({this.id, this.gameId, this.title, this.description});

  HowToPlayData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameId = json['gameid'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gameid'] = gameId;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
