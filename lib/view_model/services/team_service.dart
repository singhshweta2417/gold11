import 'package:flutter/cupertino.dart';
import 'package:gold11/view_model/services/player_selection_service.dart';

class TeamService with ChangeNotifier {
  final List<Team> _teams = [];

  List<Team> get teams => _teams;

  void saveTeam(List<Player> selectedPlayers, Player? captain, Player? viceCaptain) {
    final newTeam = Team(
      players: List.from(selectedPlayers),
      captain: captain,
      viceCaptain: viceCaptain,
    );
    _teams.add(newTeam);
    notifyListeners();
  }

  Team? getTeam(int index) {
    if (index >= 0 && index < _teams.length) {
      return _teams[index];
    }
    return null;
  }
}

class Team {
  final List<Player> players;
  final Player? captain;
  final Player? viceCaptain;

  Team({
    required this.players,
    required this.captain,
    required this.viceCaptain,
  });
}
