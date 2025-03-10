import 'package:flutter/foundation.dart';
import 'package:gold11/model/common_setting_model.dart';
import 'package:gold11/model/home_slider_model.dart';
import 'package:gold11/model/how_to_play_data_model.dart';
import 'package:gold11/repo/basic_app_feature_repo.dart';

import '../model/home_promo_story_model.dart';

enum BasicAppFeatureViewState { idle, loading, success, error }

class BasicAppFeatureViewModel with ChangeNotifier {
  final BasicAppFeatureApiService _basicAppFeatureApiService =
      BasicAppFeatureApiService();
  HowToPlayModel? _howToPlay;
  CommonSettingModel? _commonSetting;
  BasicAppFeatureViewState _viewState = BasicAppFeatureViewState.idle;
  HomeSliderBanner? _homeSlider;
  HomePromotionStoryModel? _homeStoryPromotion;

  HowToPlayModel get howToPlay => _howToPlay!;
  CommonSettingModel get commonSetting => _commonSetting!;
  BasicAppFeatureViewState get viewState => _viewState;
  HomeSliderBanner? get homeSlider => _homeSlider;
  HomePromotionStoryModel? get homeStoryPromotion => _homeStoryPromotion;

  _setViewState(BasicAppFeatureViewState state) {
    _viewState = state;
    notifyListeners();
  }

  Future<void> fetchHowToPlay(String gameId) async {
    _setViewState(BasicAppFeatureViewState.loading);
    try {
      _howToPlay = await _basicAppFeatureApiService.fetchHowToPlay(gameId);
      _setViewState(BasicAppFeatureViewState.success);
    } catch (e) {
      _setViewState(BasicAppFeatureViewState.error);
      if (kDebugMode) {
        print("error: $e");
      }
    }
    notifyListeners();
  }

  Future<void> fetchTCPrivacyPolicyAboutUs(String apiDataType) async {
    _setViewState(BasicAppFeatureViewState.loading);
    try {
      _commonSetting = await _basicAppFeatureApiService
          .fetchTCPrivacyPolicyAboutUs(apiDataType);
      _setViewState(BasicAppFeatureViewState.success);
    } catch (e) {
      _setViewState(BasicAppFeatureViewState.error);
      if (kDebugMode) {
        print("error: $e");
      }
    }
    notifyListeners();
  }

  Future<void> getHomeBanner() async {
    try {
      _homeSlider = await _basicAppFeatureApiService.getHomeBanner();
    } catch (e) {
      if (kDebugMode) {
        print("catch error $e");
      }
    }
    if (kDebugMode) {
      print("something went wrong");
    }
    notifyListeners();
  }

  Future<void> getHomePromoStory() async {
    try {
      _homeStoryPromotion =
          await _basicAppFeatureApiService.getHomePromoStory();
    } catch (e) {
      if (kDebugMode) {
        print("catch error $e");
      }
    }
    if (kDebugMode) {
      print("something went wrong");
    }
    notifyListeners();
  }
}
