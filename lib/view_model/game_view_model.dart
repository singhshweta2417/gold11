import 'package:flutter/foundation.dart';
import 'package:gold11/model/game_data_model.dart';
import 'package:gold11/model/game_type_model.dart';
import 'package:gold11/model/match_type_model.dart';
import 'package:gold11/repo/games_repo.dart';

enum GameState { loading, success, error, idle }

enum GameDataState { loading, success, noDataAvl, error }

class GameViewModel with ChangeNotifier {
  final GameApiService _gameApiService = GameApiService();
  GameTypeModel? _gameType;
  String _message = '';
  GameState _gameState = GameState.idle;
  GamesDataModel? _gameData;
  GameDataState _gameDataState = GameDataState.loading;
  MatchTypeModel? _matchType;
  int _selectedGameTabIndex = 0;
  int _selectedGameTypeId = 0;
  String? _userToken;
  String? get userToken=>_userToken;
  GameData? _selectedMatch;


  GameTypeModel get gameType => _gameType!;
  GameState get gameState => _gameState;
  GamesDataModel get gameData => _gameData!;
  GameDataState get gameDataState => _gameDataState;
  MatchTypeModel get matchType => _matchType!;
  int get selectedGameTabIndex => _selectedGameTabIndex;
  int get selectedGameTypeId => _selectedGameTypeId;
  GameData get selectedMatch => _selectedMatch!;

  void updateToken(String token) {
    if (_userToken != token) {
      _userToken = token;
    }
  }

  _setGameState(GameState state) {
    _gameState = state;
    notifyListeners();
  }


  setSelectedGameTabIndex(int index, int typeId) {
    _selectedGameTabIndex = index;
    _selectedGameTypeId = typeId;
    notifyListeners();
  }

  setSelectedMatch(GameData match) {
    _selectedMatch = match;
    notifyListeners();
  }

  _setGameDataState(GameDataState state) {
    _gameDataState = state;
    notifyListeners();
  }

  Future<void> getGameType(context) async {
    _setGameState(GameState.loading);
    try {
      _gameType = await _gameApiService.getGameType();
      _message = _gameType!.msg.toString();
      _setGameState(GameState.success);
      getGameData(context, _gameType!.data![0].id.toString());
      _selectedGameTypeId = _gameType!.data![0].id!;
    } catch (e) {
      _message = 'Failed to load game type data: $e';
      _setGameState(GameState.error);
    }
    if (kDebugMode) {
      print(_message);
    }
    notifyListeners();
  }


  Future<void> getGameData(context, String gameId) async {
    _setGameDataState(GameDataState.loading);
    try {
      _gameData =
          await _gameApiService.getGameData(_userToken.toString(), gameId);
      _message = _gameType!.msg.toString();
      if (_gameData!.complete!.isEmpty &&
          _gameData!.upcoming!.isEmpty &&
          _gameData!.live!.isEmpty) {
        _setGameDataState(GameDataState.noDataAvl);
      } else {
        _setGameDataState(GameDataState.success);
      }
    } catch (e) {
      _message = 'Failed to load match data: $e';
      _setGameDataState(GameDataState.error);
    }
    notifyListeners();
  }

  Future<void> getMatchType(context) async {
    _setGameState(GameState.loading);
    try {
      _matchType = await _gameApiService.getMatchType();
      _message = _gameType!.msg.toString();
      _setGameState(GameState.success);
    } catch (e) {
      _message = 'Failed to load match type data: $e';
      _setGameState(GameState.error);
    }
    if (kDebugMode) {
      print(_message);
    }
    notifyListeners();
  }
}
