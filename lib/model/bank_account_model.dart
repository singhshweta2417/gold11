class BankAccountModel {
  List<BankAccountData>? data;
  String? msg;
  String? status;

  BankAccountModel({this.data, this.msg, this.status});

  BankAccountModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BankAccountData>[];
      json['data'].forEach((v) {
        data!.add(BankAccountData.fromJson(v));
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

class BankAccountData {
  int? id;
  int? userid;
  String? accountNo;
  String? accountHolderName;
  String? ifscCode;
  String? bankName;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? mobile;
  dynamic email;

  BankAccountData(
      {this.id,
        this.userid,
        this.accountNo,
        this.accountHolderName,
        this.ifscCode,
        this.bankName,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.mobile,
        this.email});

  BankAccountData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    accountNo = json['account_no'];
    accountHolderName = json['account_holder_name'];
    ifscCode = json['ifsc_code'];
    bankName = json['bankname'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userid'] = userid;
    data['account_no'] = accountNo;
    data['account_holder_name'] = accountHolderName;
    data['ifsc_code'] = ifscCode;
    data['bankname'] = bankName;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['mobile'] = mobile;
    data['email'] = email;
    return data;
  }
}
