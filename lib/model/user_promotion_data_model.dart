class UserPromotionModel {
  String? invitationCode;
  int? yesterdayTotalCommission;
  DirectSubordinate? directSubordinate;
  DirectSubordinate? teamSubordinate;
  PromotionData? promotionData;
  String? msg;
  String? status;

  UserPromotionModel(
      {this.invitationCode,
        this.yesterdayTotalCommission,
        this.directSubordinate,
        this.teamSubordinate,
        this.promotionData,
        this.msg,
        this.status});

  UserPromotionModel.fromJson(Map<String, dynamic> json) {
    invitationCode = json['invitation_code'];
    yesterdayTotalCommission = json['yesterday_total_comission'];
    directSubordinate = json['direct_subordinate'] != null
        ? DirectSubordinate.fromJson(json['direct_subordinate'])
        : null;
    teamSubordinate = json['team_subordinate'] != null
        ? DirectSubordinate.fromJson(json['team_subordinate'])
        : null;
    promotionData = json['promotion_data'] != null
        ? PromotionData.fromJson(json['promotion_data'])
        : null;
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invitation_code'] = invitationCode;
    data['yesterday_total_comission'] = yesterdayTotalCommission;
    if (directSubordinate != null) {
      data['direct_subordinate'] = directSubordinate!.toJson();
    }
    if (teamSubordinate != null) {
      data['team_subordinate'] = teamSubordinate!.toJson();
    }
    if (promotionData != null) {
      data['promotion_data'] = promotionData!.toJson();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class DirectSubordinate {
  int? noOfRegister;
  dynamic depositeAmount;
  int? depositeNumber;
  int? firstDepositeCount;

  DirectSubordinate(
      {this.noOfRegister,
        this.depositeAmount,
        this.depositeNumber,
        this.firstDepositeCount});

  DirectSubordinate.fromJson(Map<String, dynamic> json) {
    noOfRegister = json['NoOfRegister'];
    depositeAmount = json['DepositeAmount'];
    depositeNumber = json['DepositeNumber'];
    firstDepositeCount = json['FirstDepositeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NoOfRegister'] = noOfRegister;
    data['DepositeAmount'] = depositeAmount;
    data['DepositeNumber'] = depositeNumber;
    data['FirstDepositeCount'] = firstDepositeCount;
    return data;
  }
}

class PromotionData {
  int? totalCommission;
  int? directSubordinate;
  int? directTotalSalary;
  int? todaySalary;
  int? teamSubordinateCount;
  int? teamTotalSalary;

  PromotionData(
      {this.totalCommission,
        this.directSubordinate,
        this.directTotalSalary,
        this.todaySalary,
        this.teamSubordinateCount,
        this.teamTotalSalary});

  PromotionData.fromJson(Map<String, dynamic> json) {
    totalCommission = json['total_commission'];
    directSubordinate = json['direct_subordinate'];
    directTotalSalary = json['direct_total_salery'];
    todaySalary = json['today_salary'];
    teamSubordinateCount = json['team_subordinate_count'];
    teamTotalSalary = json['team_total_salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_commission'] = totalCommission;
    data['direct_subordinate'] = directSubordinate;
    data['direct_total_salery'] = directTotalSalary;
    data['today_salary'] = todaySalary;
    data['team_subordinate_count'] = teamSubordinateCount;
    data['team_total_salary'] = teamTotalSalary;
    return data;
  }
}
