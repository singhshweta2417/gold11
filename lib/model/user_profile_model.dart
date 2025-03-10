class UserProfileModel {
  dynamic data;
  dynamic msg;
  dynamic status;
  dynamic supportUrl;

  UserProfileModel({this.data, this.msg, this.status,  this.supportUrl});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
    status = json['status'];
    supportUrl = json['support_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    data['status'] = status;
    data['support_url'] = supportUrl;
    return data;
  }
}

class Data {
  dynamic id;
  dynamic name;
  dynamic mobile;
  dynamic email;
  dynamic gender;
  dynamic otp;
  dynamic dob;
  dynamic age;
  dynamic image;
  dynamic status;
  dynamic isVerify;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic wallet;
  dynamic unUtilisedWallet;
  dynamic winningWallet;
  dynamic bonusWallet;
  dynamic skillScore;
  dynamic userName;


  Data(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.gender,
        this.otp,
        this.dob,
        this.age,
        this.image,
        this.status,
        this.isVerify,
        this.createdAt,
        this.updatedAt,
        this.wallet,
        this.unUtilisedWallet,
        this.winningWallet,
        this.bonusWallet,
        this.skillScore,
        this.userName,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    gender = json['gender'];
    otp = json['otp'];
    dob = json['dob'];
    age = json['age'];
    image = json['image'];
    status = json['status'];
    isVerify = json['is_verify'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    wallet = json['wallet'];
    unUtilisedWallet = json['unutiliesed_wallet'];
    winningWallet = json['winning_wallet'];
    bonusWallet = json['bonus_wallet'];
    skillScore = json['skill_score'];
    userName = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['gender'] = gender;
    data['otp'] = otp;
    data['dob'] = dob;
    data['age'] = age;
    data['image'] = image;
    data['status'] = status;
    data['is_verify'] = isVerify;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['wallet'] = wallet;
    data['unutiliesed_wallet'] = unUtilisedWallet;
    data['winning_wallet'] = winningWallet;
    data['bonus_wallet'] = bonusWallet;
    data['skill_score'] = skillScore;
    data['username'] = userName;
    return data;
  }
}