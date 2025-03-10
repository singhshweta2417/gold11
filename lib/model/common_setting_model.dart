class CommonSettingModel {
  String? data;
  String? msg;
  String? status;
  String? heading;

  CommonSettingModel({this.data, this.msg, this.status});

  CommonSettingModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    msg = json['msg'];
    status = json['status'];
    heading = json['headings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['msg'] = msg;
    data['status'] = status;
    data['headings'] = heading;
    return data;
  }
}