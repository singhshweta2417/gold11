class PlayerDesignationModel {
  List<DesignationData>? data;
  dynamic msg;
  dynamic status;

  PlayerDesignationModel({this.data, this.msg, this.status});

  PlayerDesignationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DesignationData>[];
      json['data'].forEach((v) {
        data!.add(DesignationData.fromJson(v));
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

class DesignationData {
  dynamic id;
  dynamic title;
  dynamic shortTerm;
  dynamic image;
  dynamic type;
  dynamic gameId;
  dynamic createdDate;
  dynamic modifiedDate;

  DesignationData(
      {this.id,
        this.title,
        this.shortTerm,
        this.image,
        this.type,
        this.gameId,
        this.createdDate,
        this.modifiedDate});

  DesignationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortTerm = json['short_term'];
    image = json['image'];
    type = json['type'];
    gameId = json['gameid'];
    createdDate = json['created_date'];
    modifiedDate = json['modified_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['short_term'] = shortTerm;
    data['image'] = image;
    data['type'] = type;
    data['gameid'] = gameId;
    data['created_date'] = createdDate;
    data['modified_date'] = modifiedDate;
    return data;
  }
}
