class MatchTypeModel {
  List<MatchType>? data;
  String? msg;
  String? status;

  MatchTypeModel({this.data, this.msg, this.status});

  MatchTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MatchType>[];
      json['data'].forEach((v) {
        data!.add(MatchType.fromJson(v));
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

class MatchType {
  int? id;
  String? name;
  String? slug;
  int? status;

  MatchType({this.id, this.name, this.slug, this.status});

  MatchType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['status'] = status;
    return data;
  }
}
