import 'package:gold11/helper/network/network_api_services.dart';
import 'package:gold11/model/player_data_model.dart';
import 'package:gold11/model/player_designation_model.dart';
import 'package:gold11/model/team_data_model.dart';
import '../res/app_url_const.dart';

class PlayerApiService {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<PlayerDesignationModel> getPlayerDesignation(dynamic data) async {
    try {
      final response = await _apiServices.getPostApiResponse(
          AppApiUrls.playerDesignationApiEndPoint, data);
      return PlayerDesignationModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<PlayerDataModel> getPlayers(dynamic data) async {
    try {
      final response = await _apiServices.getPostApiResponse(
          AppApiUrls.playersApiEndPoint, data);
      return PlayerDataModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> createAndUpdateTeam(dynamic data, String url) async {
    try {
      final response = await _apiServices.getPostApiResponse(
          url, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<TeamDataModel> getTeam(dynamic data) async {
    try {
      final response = await _apiServices.getPostApiResponse(
          AppApiUrls.getTeamApiEndPoint, data);
      return TeamDataModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
