import 'package:flutter/foundation.dart';
import 'package:gold11/helper/network/basic_api_service.dart';
import 'package:gold11/res/app_url_const.dart';

import '../helper/network/network_api_services.dart';

class UpdateApkRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> updateApkApi() async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(AppApiUrls.updateApk);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during updateApkApi: $e');
      }
      rethrow;
    }
  }
}