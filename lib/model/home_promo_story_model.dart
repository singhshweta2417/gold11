class HomePromotionStoryModel {
  List<PromoStoryData>? data;
  String? msg;
  String? status;

  HomePromotionStoryModel({this.data, this.msg, this.status});

  HomePromotionStoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PromoStoryData>[];
      json['data'].forEach((v) {
        data!.add(PromoStoryData.fromJson(v));
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

class PromoStoryData {
  int? id;
  String? type;
  String? image;
  String? promoLogo;
  int? status;

  PromoStoryData({this.id, this.type, this.image, this.promoLogo, this.status});

  PromoStoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    image = json['image'];
    promoLogo = json['promo_logo'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['image'] = image;
    data['promo_logo'] = promoLogo;
    data['status'] = status;
    return data;
  }
}
