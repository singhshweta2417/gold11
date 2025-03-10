class UserTransactions {
  List<UserTransactionList>? data;
  dynamic msg;
  dynamic status;

  UserTransactions({this.data, this.msg, this.status});

  UserTransactions.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserTransactionList>[];
      json['data'].forEach((v) {
        data!.add(UserTransactionList.fromJson(v));
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

class UserTransactionList {
  dynamic id;
  dynamic userid;
  dynamic amount;
  dynamic type;
  dynamic subType;
  dynamic status;
  dynamic matchId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic matchName;
  dynamic transactionType;
  dynamic transactionSubtype;
  dynamic symbols;

  UserTransactionList(
      {this.id,
        this.userid,
        this.amount,
        this.type,
        this.subType,
        this.status,
        this.matchId,
        this.createdAt,
        this.updatedAt,
        this.matchName,
        this.transactionType,
        this.transactionSubtype,
        this.symbols,
      });

  UserTransactionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    amount = json['amount'];
    type = json['type'];
    subType = json['sub_type'];
    status = json['status'];
    matchId = json['match_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    matchName = json['matchname'];
    transactionType = json['transaction_type'];
    transactionSubtype = json['transaction_subtype'];
    symbols = json['symbols'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userid'] = userid;
    data['amount'] = amount;
    data['type'] = type;
    data['sub_type'] = subType;
    data['status'] = status;
    data['match_id'] = matchId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['matchname'] = matchName;
    data['transaction_type'] = transactionType;
    data['transaction_subtype'] = transactionSubtype;
    data['symbols'] = symbols;
    return data;
  }
}
