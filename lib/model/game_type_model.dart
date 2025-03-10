class GameTypeModel {
  List<GameType>? data;
  String? msg;
  String? status;

  GameTypeModel({this.data, this.msg, this.status});

  GameTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GameType>[];
      json['data'].forEach((v) {
        data!.add(GameType.fromJson(v));
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

class GameType {
  int? id;
  String? name;
  dynamic images;
  dynamic bgImages;
  int? status;
  dynamic createdAt;

  GameType({this.id, this.name, this.images, this.status, this.createdAt});

  GameType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    images = json['images'];
    bgImages = json['bg_image'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['images'] = images;
    data['bg_image'] = bgImages;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
