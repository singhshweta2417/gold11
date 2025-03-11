import 'package:gold11/model/my_referral_model.dart';
import 'package:gold11/model/team_wise_subordnate_model.dart';
import 'package:gold11/model/user_promotion_data_model.dart';

import '../helper/network/network_api_services.dart';
import '../res/app_url_const.dart';

class MlmApiService{
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<UserPromotionModel> getUserPromotionData(String userToken,String selectedDate) async {
    final data = {
      "userid":userToken,
      "date":selectedDate
    };
    print(data);
    print('khjg');
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.getUserPromotionDataApiEndPoint, data);
      print(response);
      print('jgkgi');
      return UserPromotionModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<MyReferralModel> getReferralData(String userToken,String referralDataType) async {
    final data = {
      "userid":userToken,
      "type":referralDataType
    };
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.getReferralDataApiEndPoint, data);
      return MyReferralModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<TeamWiseSubordinateModel> fetchReferralSubOrdinateDataOnFilter(String userToken,String date, String tear, String searchQuery) async {
    final data = {
      "userid":userToken,
      "date":date,
      "tear":tear,
      "search":searchQuery
    };
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.getReferralDataOnFilterApiEndPoint, data);
      return TeamWiseSubordinateModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}