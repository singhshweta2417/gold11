class ContestFilterTypeModel {
  List<ContestFilter>? contestFilter;
  String? msg;
  String? status;

  ContestFilterTypeModel({this.contestFilter, this.msg, this.status});

  ContestFilterTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['contest_filter'] != null) {
      contestFilter = <ContestFilter>[];
      json['contest_filter'].forEach((v) {
        contestFilter!.add(ContestFilter.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contestFilter != null) {
      data['contest_filter'] =
          contestFilter!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class ContestFilter {
  int? id;
  String? type;
  String? name;
  String? value;
  int? status;

  ContestFilter({this.id, this.type, this.name, this.value, this.status});

  ContestFilter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}
