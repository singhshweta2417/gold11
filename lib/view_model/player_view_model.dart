import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:gold11/model/player_data_insert_model.dart';
import 'package:gold11/model/player_data_model.dart';
import 'package:gold11/model/player_designation_model.dart';
import 'package:gold11/model/team_data_model.dart';
import 'package:gold11/repo/player_repo.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view_model/contest_view_model.dart';
import 'package:gold11/view_model/game_view_model.dart';
import '../res/app_url_const.dart';

enum PlayerState { idle, loading, success, error }

class PlayerViewModel with ChangeNotifier {
  final PlayerApiService _playerApiService = PlayerApiService();
  PlayerDesignationModel? _playerDesignation;
  PlayerDataModel? _playerData;
  List<PlayerData> _selectedPlayers = [];
  PlayerData? _captain;
  PlayerData? _viceCaptain;
  PlayerState _playerDataState = PlayerState.idle;
  List<PlayerDataInsertModel> _finalTeamList = [];
  TeamDataModel? _teamData;
  TeamData? _selectedTeam;
  bool _isUpdateTeam = false;
  int _updateTeamId = -1;

  PlayerDataModel get playerData => _playerData!;
  PlayerDesignationModel get playerDesignation => _playerDesignation!;
  List<PlayerData> get selectedPlayers => _selectedPlayers;
  PlayerData? get captain => _captain;
  PlayerData? get viceCaptain => _viceCaptain;
  PlayerState get playerDataState => _playerDataState;
  TeamDataModel? get teamData => _teamData;
  TeamData? get selectedTeam => _selectedTeam;
  bool get isUpdateTeam => _isUpdateTeam;
  int get updateTeamId => _updateTeamId;

  Future<void> getPlayerDesignation(context) async {
    final data = {
      "gameid":
          Provider.of<GameViewModel>(context, listen: false).selectedGameTypeId,
    };
    try {
      _playerDesignation = await _playerApiService.getPlayerDesignation(data);
      if (_playerData!.status == "200") {
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
    }
    notifyListeners();
  }

  int getSelectedPlayersInDesignation(String designation) {
    return selectedPlayers
        .where((e) => e.designationName == designation)
        .length;
  }

  int get selectedWKPlayersCount => getSelectedPlayersInDesignation("WK");
  int get selectedBATPlayersCount => getSelectedPlayersInDesignation("BAT");
  int get selectedARPlayersCount => getSelectedPlayersInDesignation("AR");
  int get selectedBOWLPlayersCount => getSelectedPlayersInDesignation("BOWL");

  bool canAddPlayer(String designation) {
    final allPlayersDesignationList = [
      selectedARPlayersCount,
      selectedBATPlayersCount,
      selectedBOWLPlayersCount,
      selectedWKPlayersCount
    ];
    bool hasAnyEmptyList = allPlayersDesignationList.any((ele) => ele == 0);
    if (hasAnyEmptyList) {
      int emptyListCount =
          allPlayersDesignationList.where((desg) => desg == 0).length;
      if (getSelectedPlayersInDesignation(designation) != 0) {
        return (11 - selectedPlayers.length) > emptyListCount;
      }
      return (11 - selectedPlayers.length) > (emptyListCount - 1);
    }
    return true;
  }

  setDataState(PlayerState state) {
    _playerDataState = state;
  }

  setUpdateTeam(bool status, int selectedTeamId) {
    _isUpdateTeam = status;
    _updateTeamId = selectedTeamId;
    notifyListeners();
  }

  Future<void> getPlayers(context) async {
    final contest =
        Provider.of<ContestViewModel>(context, listen: false).contestData;
    final data = {
      "gameid":
          Provider.of<GameViewModel>(context, listen: false).selectedGameTypeId,
      "season_id": contest.seasonId,
      "matchid":
          Provider.of<GameViewModel>(context, listen: false).selectedMatch.id,
      "teamid1": contest.team1,
      "teamid2": contest.team2
    };
    try {
      _playerData = await _playerApiService.getPlayers(data);
      if (_playerData!.status == "200") {
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
    }
  }

  List<String> isDesignationSelected = [];
  void togglePlayerSelection(int index) {
    _playerData!.data![index].isSelected =
        !_playerData!.data![index].isSelected!;
    if (_playerData!.data![index].isSelected!) {
      _selectedPlayers.add(_playerData!.data![index]);
    } else {
      _selectedPlayers
          .removeWhere((p) => p.pid == _playerData!.data![index].pid);
    }
    notifyListeners();
  }

  double get totalSelectedPlayersPrice {
    return 100 -
        (_playerData!.data!
            .where((player) => player.isSelected!)
            .fold(0.0, (sum, player) => sum + player.creditPoints!));
  }

  void selectCaptain(PlayerData player) {
    if (viceCaptain != null && viceCaptain!.pid == player.pid) {
      _viceCaptain = null;
    }
    _captain = player;
    notifyListeners();
  }

  void selectViceCaptain(PlayerData player) {
    if (captain != null && captain!.pid == player.pid) {
      _captain = null;
    }
    _viceCaptain = player;
    notifyListeners();
  }

  int _lineupSwitchUp = 0;

  int get lineupSwitchUp => _lineupSwitchUp;

  int get selectedPlayersCount =>
      _selectedPlayers.where((player) => player.isSelected!).length;

  void setLineupSwitchUp(int newValue) {
    _lineupSwitchUp = newValue;
    notifyListeners();
  }

  modifyDataAndSaveTeamApiCall(
    BuildContext context,
  ) {
    _finalTeamList = [];
    if (_captain != null) {
      _finalTeamList.add(PlayerDataInsertModel(
        id: _captain!.id.toString(),
        playerId: _captain!.pid.toString(),
        sportsMonkPid: _captain!.thirdPartySeasonId.toString(),
        isCaptain: "1",
        isViceCaptain: "0",
        designationName: _captain!.designationName.toString(),
        teamId: _captain!.teamId.toString(),
      ));
    }

    if (_viceCaptain != null) {
      _finalTeamList.add(PlayerDataInsertModel(
        id: _viceCaptain!.id.toString(),
        playerId: _viceCaptain!.pid.toString(),
        sportsMonkPid: _viceCaptain!.thirdPartySeasonId.toString(),
        isCaptain: "0",
        isViceCaptain: "1",
        designationName: _viceCaptain!.designationName.toString(),
        teamId: _viceCaptain!.teamId.toString(),
      ));
    }

    for (var player in _selectedPlayers) {
      if (player.id.toString() != _captain?.id.toString() &&
          player.id.toString() != _viceCaptain?.id.toString()) {
        _finalTeamList.add(PlayerDataInsertModel(
          id: player.id.toString(),
          playerId: player.pid.toString(),
          sportsMonkPid: player.thirdPartySeasonId.toString(),
          isCaptain: "0",
          isViceCaptain: "0",
          designationName: player.designationName.toString(),
          teamId: player.teamId.toString(),
        ));
      } else {
        if (kDebugMode) {
          print("It is captain or vice captain");
        }
      }
    }
    List<Map<String, dynamic>> jsonData =
        _finalTeamList.map((player) => player.toJson()).toList();
    createAndUpdateTeam(context, jsonData);
  }

  clearSelectedPlayerList() {
    if (_playerData == null || _playerData!.data == null) {
      return;
    }
    for (var player in _playerData!.data!) {
      if (player.isSelected == true) {
        player.isSelected = false;
      } else {
        if (kDebugMode) {
          print("it is already false");
        }
      }
    }
    _selectedPlayers = [];
    _captain = null;
    _viceCaptain = null;
    _finalTeamList = [];
    notifyListeners();
  }

  Future<void> createAndUpdateTeam(
      BuildContext context, dynamic playerData) async {
    final data = {
      "userid":
          Provider.of<SharedPrefViewModel>(context, listen: false).userToken,
      "my_teamid": _updateTeamId == -1 ? "" : _updateTeamId.toString(),
      "matchid":
          Provider.of<GameViewModel>(context, listen: false).selectedMatch.id,
      "gameid":
          Provider.of<GameViewModel>(context, listen: false).selectedGameTypeId,
      "player_data": playerData
    };
    try {
      final res = await _playerApiService.createAndUpdateTeam(
          data,
          _isUpdateTeam
              ? AppApiUrls.updateTeamApiEndPoint
              : AppApiUrls.saveTeamApiEndPoint);
      if (res["status"] == "200") {
        clearSelectedPlayerList();
        setUpdateTeam(false, -1);
        await getTeam(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Provider.of<ContestViewModel>(context, listen: false)
            .setContestScreenTabIndex(2);
      } else {
        if (kDebugMode) {
          Utils.showErrorMessage(context, res['msg']);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
    }
    notifyListeners();
  }

  Future<void> getTeam(
    BuildContext context,
  ) async {
    final data = {
      "userid":
          Provider.of<SharedPrefViewModel>(context, listen: false).userToken,
      "matchid":
          Provider.of<GameViewModel>(context, listen: false).selectedMatch.id,
      "gameid":
          Provider.of<GameViewModel>(context, listen: false).selectedGameTypeId,
      "contest_id": Provider.of<ContestViewModel>(context, listen: false)
                  .selectedContestData !=
              null
          ? Provider.of<ContestViewModel>(context, listen: false)
              .selectedContestData!
              .id
              .toString()
          : ""
    };
    try {
      _teamData = await _playerApiService.getTeam(data);
      if (_teamData!.status == "200") {
        if (_teamData!.data!.isNotEmpty) {
          Provider.of<PlayerViewModel>(context, listen: false)
                      .teamData!
                      .data!
                      .length ==
                  1
              ? setSelectedTeam(_teamData!.data![0])
              : null;
        }
        notifyListeners();
      } else {
        Utils.showErrorMessage(context, _teamData!.msg);
      }
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
    }
    notifyListeners();
  }

  setSelectedTeam(TeamData data) {
    _selectedTeam = data;
    notifyListeners();
  }

  getUpdateTeamData(List<TeamPlayerList>? teamList) {
    _captain = null;
    _viceCaptain = null;
    for (var playerData in teamList!) {
      if (_playerData!.data!
          .where((e) => e.pid == playerData.playerId)
          .isNotEmpty) {
        final data =
            _playerData!.data!.firstWhere((e) => e.pid == playerData.playerId);
        data.isSelected = true;
        // _selectedPlayers.add(data);
        _selectedPlayers.add(PlayerData(
            id: playerData.id,
            pid: data.pid,
            thirdPartySeasonId: data.thirdPartySeasonId,
            teamId: data.teamId,
            isPlaying: data.isPlaying,
            creditPoints: data.creditPoints,
            seriesPoints: data.seriesPoints,
            createdDate: data.createdDate,
            modifiedDate: data.modifiedDate,
            playerName: data.playerName,
            playerImage: data.playerImage,
            designationId: data.designationId,
            designationName: data.designationName,
            teamName: data.teamName,
            isSelected: true));
        if (playerData.isCaptain == 1) {
          selectCaptain(PlayerData(
              id: playerData.id,
              pid: data.pid,
              thirdPartySeasonId: data.thirdPartySeasonId,
              teamId: data.teamId,
              isPlaying: data.isPlaying,
              creditPoints: data.creditPoints,
              seriesPoints: data.seriesPoints,
              createdDate: data.createdDate,
              modifiedDate: data.modifiedDate,
              playerName: data.playerName,
              playerImage: data.playerImage,
              designationId: data.designationId,
              designationName: data.designationName,
              teamName: data.teamName,
              isSelected: true));
        } else if (playerData.isViceCaptain == 1) {
          selectViceCaptain(PlayerData(
              id: playerData.id,
              pid: data.pid,
              thirdPartySeasonId: data.thirdPartySeasonId,
              teamId: data.teamId,
              isPlaying: data.isPlaying,
              creditPoints: data.creditPoints,
              seriesPoints: data.seriesPoints,
              createdDate: data.createdDate,
              modifiedDate: data.modifiedDate,
              playerName: data.playerName,
              playerImage: data.playerImage,
              designationId: data.designationId,
              designationName: data.designationName,
              teamName: data.teamName,
              isSelected: true));
        } else {
          if (kDebugMode) {
            print("it is getting");
          }
        }
      } else {
        if (kDebugMode) {
          print("data not avl in list");
        }
      }
    }
    notifyListeners();
  }
}
