class MyReferralModel {
  List<ReferralList>? data;
  String? msg;
  String? status;

  MyReferralModel({this.data, this.msg, this.status});

  MyReferralModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ReferralList>[];
      json['data'].forEach((v) {
        data!.add( ReferralList.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class ReferralList {
  int? id;
  dynamic username;
  String? name;
  String? createdAt;
  String? referralType;

  ReferralList({this.id, this.username, this.name, this.createdAt, this.referralType});

  ReferralList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    createdAt = json['created_at'];
    referralType = json['referral_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['referral_type'] = referralType;
    return data;
  }
}
