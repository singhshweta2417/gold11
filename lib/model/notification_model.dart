class NotificationModel {
  String? counts;
  List<NotificationData>? data;
  String? msg;
  String? status;

  NotificationModel({this.counts, this.data, this.msg, this.status});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    counts = json['counts'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(NotificationData.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['counts'] = counts;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class NotificationData {
  int? id;
  String? title;
  String? description;
  int? type;
  int? userid;
  String? createdAt;
  String? updatedAt;
  String? isViewed;

  NotificationData(
      {this.id,
        this.title,
        this.description,
        this.type,
        this.userid,
        this.createdAt,
        this.updatedAt,
        this.isViewed});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    userid = json['userid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isViewed = json['is_viewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['type'] = type;
    data['userid'] = userid;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_viewed'] = isViewed;
    return data;
  }
}
