import 'package:gold11/helper/network/network_api_services.dart';
import 'package:gold11/model/how_to_play_data_model.dart';

import '../model/common_setting_model.dart';
import '../model/home_promo_story_model.dart';
import '../model/home_slider_model.dart';
import '../res/app_url_const.dart';

class BasicAppFeatureApiService{
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<HowToPlayModel> fetchHowToPlay(String gameId) async {
    try {
      final response = await _apiServices.getGetApiResponse("${AppApiUrls.howToPlayDataApiEndPoint}$gameId");
      return HowToPlayModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonSettingModel> fetchTCPrivacyPolicyAboutUs(String apiDataType) async {
    try {
      final response = await _apiServices.getGetApiResponse("${AppApiUrls.commonSettingApiEndPoint}$apiDataType");
      return CommonSettingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<HomeSliderBanner> getHomeBanner() async {
    try {
      final response = await _apiServices.getGetApiResponse(AppApiUrls.getHomeScreenBannerApiEndPoint);
      return HomeSliderBanner.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<HomePromotionStoryModel> getHomePromoStory() async {
    try {
      final response = await _apiServices.getGetApiResponse(AppApiUrls.getHomeScreenPromoStoryApiEndPoint);
      return HomePromotionStoryModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}