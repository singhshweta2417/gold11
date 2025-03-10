// class TeamWiseSubordinateModel {
//   List<Data>? data;
//   String? msg;
//   String? status;
//
//   TeamWiseSubordinateModel({this.data, this.msg, this.status});
//
//   TeamWiseSubordinateModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//     msg = json['msg'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['msg'] = msg;
//     data['status'] = status;
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   dynamic username;
//   String? name;
//   String? mobile;
//   dynamic email;
//   int? gender;
//   String? otp;
//   dynamic dob;
//   dynamic age;
//   String? image;
//   int? status;
//   int? isVerify;
//   int? addedBy;
//   String? createdAt;
//   String? updatedAt;
//   int? level;
//   String? depositAmount;
//   String? betAmount;
//   String? commissionAmount;
//
//   Data(
//       {this.id,
//         this.username,
//         this.name,
//         this.mobile,
//         this.email,
//         this.gender,
//         this.otp,
//         this.dob,
//         this.age,
//         this.image,
//         this.status,
//         this.isVerify,
//         this.addedBy,
//         this.createdAt,
//         this.updatedAt,
//         this.level,
//         this.depositAmount,
//         this.betAmount,
//         this.commissionAmount});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//     name = json['name'];
//     mobile = json['mobile'];
//     email = json['email'];
//     gender = json['gender'];
//     otp = json['otp'];
//     dob = json['dob'];
//     age = json['age'];
//     image = json['image'];
//     status = json['status'];
//     isVerify = json['is_verify'];
//     addedBy = json['added_by'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     level = json['level'];
//     depositAmount = json['deposit_amount'];
//     betAmount = json['bet_amount'];
//     commissionAmount = json['commission_amount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['username'] = username;
//     data['name'] = name;
//     data['mobile'] = mobile;
//     data['email'] = email;
//     data['gender'] = gender;
//     data['otp'] = otp;
//     data['dob'] = dob;
//     data['age'] = age;
//     data['image'] = image;
//     data['status'] = status;
//     data['is_verify'] = isVerify;
//     data['added_by'] = addedBy;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['level'] = level;
//     data['deposit_amount'] = depositAmount;
//     data['bet_amount'] = betAmount;
//     data['commission_amount'] = commissionAmount;
//     return data;
//   }
// }


class TeamWiseSubordinateModel {
  List<Data>? data;
  String? msg;
  String? status;
  Details? details;

  TeamWiseSubordinateModel({this.data, this.msg, this.status, this.details});

  TeamWiseSubordinateModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['status'] = status;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class Details {
  String? firstDepositAmount;
  int? firstDepositCount;
  String? totalDepositAmount;
  int? numberOfBetter;
  String? totalBet;

  Details({this.firstDepositAmount, this.firstDepositCount, this.totalDepositAmount, this.numberOfBetter, this.totalBet});

  Details.fromJson(Map<String, dynamic> json) {
    firstDepositAmount = json['first_deposit_amount'];
    firstDepositCount = json['first_deposit_count'];
    totalDepositAmount = json['total_deposit_amount'];
    numberOfBetter = json['number_of_better'];
    totalBet = json['total_bet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_deposit_amount'] = firstDepositAmount;
    data['first_deposit_count'] = firstDepositCount;
    data['total_deposit_amount'] = totalDepositAmount;
    data['number_of_better'] = numberOfBetter;
    data['total_bet'] = totalBet;
    return data;
  }
}

class Data {
  int? id;
  dynamic username;
  String? name;
  String? mobile;
  dynamic email;
  int? gender;
  String? otp;
  dynamic dob;
  dynamic age;
  String? image;
  int? status;
  int? isVerify;
  int? addedBy;
  String? createdAt;
  String? updatedAt;
  int? level;
  String? depositAmount;
  String? betAmount;
  String? commissionAmount;

  Data(
      {this.id,
        this.username,
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
        this.addedBy,
        this.createdAt,
        this.updatedAt,
        this.level,
        this.depositAmount,
        this.betAmount,
        this.commissionAmount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
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
    addedBy = json['added_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    level = json['level'];
    depositAmount = json['deposit_amount'];
    betAmount = json['bet_amount'];
    commissionAmount = json['commission_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
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
    data['added_by'] = addedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['level'] = level;
    data['deposit_amount'] = depositAmount;
    data['bet_amount'] = betAmount;
    data['commission_amount'] = commissionAmount;
    return data;
  }
}
