// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:provider/provider.dart';
// import 'package:gold11/model/contest_data_model.dart';
// import 'package:gold11/model/match_type_model.dart';
// import 'package:gold11/repo/contest_repo.dart';
// import 'package:gold11/res/shared_preferences_util.dart';
// import 'package:gold11/utils/utils.dart';
// import 'package:gold11/view_model/game_view_model.dart';
// import 'package:gold11/view_model/player_view_model.dart';
//
// import '../model/contest_detail_model.dart';
// import '../model/contest_filter_type_model.dart';
//
// enum ContestDataState { loading, success, noDataAvl, error }
//
// class ContestViewModel with ChangeNotifier {
//   final ContestApiService _contestApiService = ContestApiService();
//   ContestDataModel? _contestData;
//   String _message = '';
//   MatchTypeModel? _matchType;
//   ContestDataState? _dataState;
//   ContestFilterTypeModel? _contestFilterType;
//   final ValueNotifier<bool> _isFabVisible = ValueNotifier(true);
//   final ScrollController _scrollController = ScrollController();
//   String _selectedMatchId = "";
//   ContestDetailModel? _contestDetail;
//   ContestList? _selectedContestData;
//
//   ContestDataModel get contestData => _contestData!;
//   MatchTypeModel get matchType => _matchType!;
//   ContestDataState get dataState => _dataState!;
//   ContestFilterTypeModel get contestFilterType => _contestFilterType!;
//   String get message => _message;
//   ValueNotifier<bool> get isFabVisible => _isFabVisible;
//   ScrollController get scrollController => _scrollController;
//   ContestDetailModel get contestDetail => _contestDetail!;
//   ContestList get selectedContestData => _selectedContestData!;
//
//   ContestViewModel() {
//     _scrollController.addListener(_scrollListener);
//   }
//
//   void _scrollListener() {
//     final direction = _scrollController.position.userScrollDirection;
//     if (direction == ScrollDirection.reverse) {
//       updateFabVisibility(false);
//     } else if (direction == ScrollDirection.forward) {
//       updateFabVisibility(true);
//     }
//   }
//
//   void updateFabVisibility(bool isVisible) {
//     if (_isFabVisible.value != isVisible) {
//       _isFabVisible.value = isVisible;
//       notifyListeners();
//     }
//   }
//
//   void setSelectedContestData(ContestList contest) {
//     _selectedContestData = contest;
//     notifyListeners();
//   }
//
//   _setContestDataState(ContestDataState state) {
//     _dataState = state;
//     notifyListeners();
//   }
//
//   Future<void> getContestData(context, String matchId) async {
//     _selectedMatchId = matchId;
//     _setContestDataState(ContestDataState.loading);
//     final userToken =
//         Provider.of<SharedPrefViewModel>(context, listen: false).userToken;
//     final gameProvider = Provider.of<GameViewModel>(context, listen: false);
//     final gameId = gameProvider
//         .gameType.data![gameProvider.selectedGameTabIndex].id
//         .toString();
//     try {
//       _contestData =
//           await _contestApiService.getContestData(userToken, gameId, matchId);
//       _message = _contestData!.msg.toString();
//       if (_contestData!.myContest!.isEmpty &&
//           _contestData!.contestList!.isEmpty) {
//         _setContestDataState(ContestDataState.noDataAvl);
//       } else {
//         _setContestDataState(ContestDataState.success);
//       }
//     } catch (e) {
//       _message = 'Failed to load data: $e';
//       _setContestDataState(ContestDataState.error);
//     }
//     if (kDebugMode) {
//       print(_message);
//     }
//     notifyListeners();
//   }
//
//   Future<void> getContestFilterType(context) async {
//     try {
//       _contestFilterType = await _contestApiService.getContestFilterType();
//       _message = _contestFilterType!.msg.toString();
//     } catch (e) {
//       _message = 'Failed to load data: $e';
//     }
//     if (kDebugMode) {
//       print(_message);
//     }
//     notifyListeners();
//   }
//
//   Future<void> getContestDetail(String contestId) async {
//     _setContestDataState(ContestDataState.loading);
//     try {
//       _contestDetail = await _contestApiService.getContestDetail(
//           contestId, _selectedMatchId);
//       _message = _contestFilterType!.msg.toString();
//       _setContestDataState(ContestDataState.success);
//     } catch (e) {
//       _message = 'Failed to load data: $e';
//       _setContestDataState(ContestDataState.error);
//     }
//     if (kDebugMode) {
//       print(_message);
//     }
//     notifyListeners();
//   }
//
//   Future<void> joinContest(BuildContext context) async {
//     final data = {
//       "userid":
//           Provider.of<SharedPrefViewModel>(context, listen: false).userToken,
//       "matchid":
//           Provider.of<GameViewModel>(context, listen: false).selectedMatch.id,
//       "contestid":
//           Provider.of<GameViewModel>(context, listen: false).selectedGameTypeId,
//       "teamid": Provider.of<PlayerViewModel>(context, listen: false)
//           .selectedTeam!
//           .id
//           .toString(),
//       "amount": Provider.of<ContestViewModel>(context, listen: false)
//           .selectedContestData
//           .id
//           .toString(),
//       "gameid":
//           Provider.of<GameViewModel>(context, listen: false).selectedGameTypeId
//     };
//     try {
//       final res = await _contestApiService.joinContest(data);
//       if (res.status == "200") {
//         Navigator.pop(context);
//         Utils.showSuccessMessage(context, res.message);
//       } else {
//         if (kDebugMode) {
//           print("something went wrong");
//         }
//       }
//     } catch (e) {
//       _message = 'Failed to load data: $e';
//     }
//     if (kDebugMode) {
//       print(_message);
//     }
//     notifyListeners();
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:gold11/model/contest_data_model.dart';
import 'package:gold11/model/match_type_model.dart';
import 'package:gold11/repo/contest_repo.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view_model/game_view_model.dart';
import 'package:gold11/view_model/player_view_model.dart';
import 'package:gold11/view_model/profile_view_model.dart';

import '../model/contest_detail_model.dart';
import '../model/contest_filter_type_model.dart';

enum ContestDataState { loading, success, noDataAvl, error }
class ContestViewModel with ChangeNotifier {
  final ContestApiService _contestApiService = ContestApiService();
   TabController? _tabController;
  ContestDataModel? _contestData;
  String _message = '';
  MatchTypeModel? _matchType;
  ContestDataState? _dataState;
  ContestFilterTypeModel? _contestFilterType;
  final ValueNotifier<bool> _isFabVisible = ValueNotifier(true);
  final ScrollController _scrollController = ScrollController();
  String _selectedMatchId = '';
  ContestDetailModel? _contestDetail;
  ContestList? _selectedContestData;
  bool _enableJoinContestBottomSheet=false;
  int _contestTabIndex = 0;

  // Getters
  ContestDataModel get contestData => _contestData!;
  MatchTypeModel get matchType => _matchType!;
  ContestDataState get dataState => _dataState!;
  ContestFilterTypeModel get contestFilterType => _contestFilterType!;
  String get message => _message;
  ValueNotifier<bool> get isFabVisible => _isFabVisible;
  ScrollController get scrollController => _scrollController;
  ContestDetailModel? get contestDetail => _contestDetail;
  ContestList? get selectedContestData => _selectedContestData;
  bool get enableJoinContestBottomSheet => _enableJoinContestBottomSheet;
  int get contestTabIndex => _contestTabIndex;

  ContestViewModel() {
    _scrollController.addListener(_scrollListener);
  }
  //
  void setTabController(TabController tabController) {
    _tabController = tabController;
    _tabController!.addListener(() {
      final index = _tabController!.index;
      if (_contestTabIndex != index) {
        _contestTabIndex = index;
        notifyListeners();
      }
    });
  }

  void setContestScreenTabIndex(int index) {
    if (_tabController!.index != index) {
      _tabController!.animateTo(index);
      _contestTabIndex = index;
      notifyListeners();
    }
  }

  setEnableJoinContestBottomSheet(bool val){
    _enableJoinContestBottomSheet = val;
    notifyListeners();
  }

  void _scrollListener() {
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) {
      updateFabVisibility(false);
    } else if (direction == ScrollDirection.forward) {
      updateFabVisibility(true);
    }
  }

  void updateFabVisibility(bool isVisible) {
    if (_isFabVisible.value != isVisible) {
      _isFabVisible.value = isVisible;
      notifyListeners();
    }
  }

  void setSelectedContestData(ContestList contest) {
    _selectedContestData=null;
    _selectedContestData = contest;
    notifyListeners();
  }

  void _setContestDataState(ContestDataState state) {
    _dataState = state;
    notifyListeners();
  }

  Future<void> getContestData(BuildContext context, String matchId) async {
    _selectedMatchId = matchId;
    _setContestDataState(ContestDataState.loading);
    final userToken = Provider.of<SharedPrefViewModel>(context, listen: false).userToken;
    final gameProvider = Provider.of<GameViewModel>(context, listen: false);
    final gameId = gameProvider.gameType.data![gameProvider.selectedGameTabIndex].id.toString();

    try {
      _contestData = await _contestApiService.getContestData(userToken, gameId, matchId);
      _message = _contestData!.msg.toString();
      if (_contestData!.myContest!.isEmpty && _contestData!.contestList!.isEmpty) {
        _setContestDataState(ContestDataState.noDataAvl);
      } else {
        _setContestDataState(ContestDataState.success);
      }
    } catch (e) {
      _message = 'Failed to load data: $e';
      _setContestDataState(ContestDataState.error);
    }

    if (kDebugMode) {
      print(_message);
    }
    notifyListeners();
  }

  // Fetch contest filter type
  Future<void> getContestFilterType() async {
    try {
      _contestFilterType = await _contestApiService.getContestFilterType();
      _message = _contestFilterType!.msg.toString();
    } catch (e) {
      _message = 'Failed to load data: $e';
    }

    if (kDebugMode) {
      print(_message);
    }
    notifyListeners();
  }

  // Fetch contest detail
  Future<void> getContestDetail(BuildContext context, String contestId) async {
    final userId = Provider.of<SharedPrefViewModel>(context, listen: false).userToken;
    final gameId = Provider.of<GameViewModel>(context, listen: false).selectedGameTypeId;
    _setContestDataState(ContestDataState.loading);
    final data = "$contestId/$_selectedMatchId/$gameId/$userId";
    try {
      _contestDetail = await _contestApiService.getContestDetail(data);
      _message = _contestDetail!.msg.toString();
      _setContestDataState(ContestDataState.success);

      notifyListeners();
    } catch (e) {
      _message = 'Failed to load data: $e';
      _setContestDataState(ContestDataState.error);
    }
    if (kDebugMode) {
      print(_message);
    }
    notifyListeners();
  }

  // Join contest
  Future<void> joinContest(BuildContext context) async {
    final data = {
      'userid': Provider.of<SharedPrefViewModel>(context, listen: false).userToken,
      'matchid': Provider.of<GameViewModel>(context, listen: false).selectedMatch.id,
      'contestid': _selectedContestData!.id.toString(),
      'teamid': Provider.of<PlayerViewModel>(context, listen: false).selectedTeam!.id.toString(),
      'amount': Provider.of<ContestViewModel>(context, listen: false).selectedContestData!.desprice=="1"?
      Provider.of<ContestViewModel>(context, listen: false).selectedContestData!.desprice.toString():
      Provider.of<ContestViewModel>(context, listen: false).selectedContestData!.entryFee.toString(),
      'gameid': Provider.of<GameViewModel>(context, listen: false).selectedGameTypeId
    };

    try {
      final res = await _contestApiService.joinContest(data);
      if (res.status == '200') {
        Navigator.pushReplacementNamed(context, AppRoutes.contestScreen);
        getContestData(context, _selectedMatchId);
        setEnableJoinContestBottomSheet(false);
        Provider.of<ProfileViewModel>(context, listen: false).fetchUserProfile();
        Utils.showSuccessMessage(context, res.message);
      } else {
        Utils.showErrorMessage(context, res.message);
      }
    } catch (e) {
      _message = 'Failed to load data: $e';
      Utils.showMessage(context, 'Failed to load data: $e');
    }

    if (kDebugMode) {
      print(_message);
    }
    notifyListeners();
  }
}
