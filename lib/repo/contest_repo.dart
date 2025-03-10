import 'package:gold11/model/common_api_response.dart';
import 'package:gold11/model/contest_data_model.dart';
import 'package:gold11/model/contest_detail_model.dart';
import 'package:gold11/model/contest_filter_type_model.dart';
import '../helper/network/network_api_services.dart';
import '../res/app_url_const.dart';

class ContestApiService{
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<ContestDataModel> getContestData(String userToken, String gameId, String matchId,) async {
    final data={
      "userid":userToken,
      "gameid":gameId,
      "matchid":matchId,
      "type":"1"
    };
    // print("contest data payload: $data");
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.getContestApiEndPoint,data);
      return ContestDataModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ContestFilterTypeModel> getContestFilterType() async {
    try {
      final response = await _apiServices.getGetApiResponse(AppApiUrls.getContestFiltersApiEndPoint);
      return ContestFilterTypeModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ContestDetailModel> getContestDetail(dynamic data) async {
    try {
      final response = await _apiServices.getGetApiResponse("${AppApiUrls.getContestDetailApiEndPoint}$data");
      return ContestDetailModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse> joinContest(dynamic data) async {
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.joinContestApiEndPoint, data);
      return CommonApiResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}