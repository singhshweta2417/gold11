import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gold11/model/user_promotion_data_model.dart';
import 'package:gold11/repo/mlm_repo.dart';

import '../model/my_referral_model.dart';
import '../model/team_wise_subordnate_model.dart';
import '../res/shared_preferences_util.dart';

enum MlmViewState { idle, loading, error, success }

class MlmViewModel extends ChangeNotifier {
  final MlmApiService _mlmApiService = MlmApiService();
  MyReferralModel? _myReferralData;
  MlmViewState _mlmView = MlmViewState.idle;
  UserPromotionModel? _userPromotionData;
  bool _dataLoading = false;
  TeamWiseSubordinateModel? _teamWiseFilterData;
  DateTime? _selectedDate;
  int _selectedTierIndex = 0;


  MyReferralModel get myReferralData => _myReferralData!;
  MlmViewState get mlmView => _mlmView;
  UserPromotionModel get userPromotionData => _userPromotionData!;
  bool get dataLoading => _dataLoading;
  TeamWiseSubordinateModel get teamWiseFilterData => _teamWiseFilterData!;
  DateTime? get selectedDate => _selectedDate;
  int get selectedTierIndex => _selectedTierIndex;


  _setMlmViewState(MlmViewState state) {
      _mlmView = state;
      notifyListeners();
   }

  _setDataLoading(bool state) {
    _dataLoading = state;
    notifyListeners();
  }

  Future<void> getUserPromotionData(String userToken) async {
    final date = DateTime.now().subtract(const Duration(days: 1));
    final previousDate = DateFormat('yyyy-MM-dd').format(date);
    _setMlmViewState(MlmViewState.loading);
    try {
      _userPromotionData = await _mlmApiService.getUserPromotionData(userToken, previousDate);
      _setMlmViewState(MlmViewState.success);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("something went wrong");
      }
    }
  }

  Future<void> fetchReferralData(String userToken, String referralDataType) async {
   _setDataLoading(true);
    try {
      _myReferralData = await _mlmApiService.getReferralData(userToken, referralDataType);
      _setDataLoading(false);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("something went wrong");
      }
    }
  }

  Future<void> fetchReferralSubOrdinateDataOnFilter(String userToken, String searchQuery) async {
    _setDataLoading(true);
    String filterDate="";
    if(_selectedDate != null) {
      filterDate  = "${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}";
    } else {
      filterDate = "";
    }
    try {
      _teamWiseFilterData = await _mlmApiService.fetchReferralSubOrdinateDataOnFilter(userToken,filterDate, _selectedTierIndex.toString(), searchQuery);
      _setDataLoading(false);
      notifyListeners();
    } catch (e) {
      _setDataLoading(false);
      if (kDebugMode) {
        print("something went wrong");
      }
    }
  }

  Future<void> pickDate(context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
        _selectedDate = pickedDate;
        notifyListeners();
        await fetchReferralSubOrdinateDataOnFilter(Provider.of<SharedPrefViewModel>(context,
            listen: false)
            .userToken,"");

    }
  }

  void setTearIndex(context,int index){
    _selectedTierIndex = index + 1;
    notifyListeners();
     fetchReferralSubOrdinateDataOnFilter(Provider.of<SharedPrefViewModel>(context,
        listen: false)
        .userToken,"");
  }
}
