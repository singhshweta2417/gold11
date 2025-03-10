  import 'package:flutter/cupertino.dart';

  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/view_model/services/team_service.dart';

import '../../generated/assets.dart';
import '../../utils/route/app_routes.dart';

  class PlayerProviderService with ChangeNotifier {
     final List<Player> _players = [
      Player(
        name: 'Ashutosh Tripathi',
        imageUrl:Assets.playersImgVirat,
        selectionPercentage: 19.6,
        points: 38,
        price: 8.0,
        role: 'Batsman', team: 'India',
      ),
      Player(
        name: 'John Doe',
        imageUrl: Assets.playersImgRohit,
        selectionPercentage: 15.3,
        points: 40,
        price: 9.0,
        role: 'Bowler', team: 'India',
      ),
      Player(
        name: 'Jane Smith',
        imageUrl: Assets.playersImgPlayer3,
        selectionPercentage: 22.1,
        points: 42,
        price: 8.5,
        role: 'Allrounder', team: 'India',
      ),
      Player(
        name: 'Mark Taylor',
        imageUrl: Assets.playersImgPlayer4,
        selectionPercentage: 18.9,
        points: 39,
        price: 8.1,
        role: 'Wicketkeeper', team: 'India',
      ),
      Player(
        name: 'Chris Evans',
        imageUrl: Assets.playersImgPlayer5,
        selectionPercentage: 12.3,
        points: 37,
        price: 8.0,
        role: 'Batsman', team: 'India',
      ),
      Player(
        name: 'David Warner',
        imageUrl: Assets.playersImgPlayer6,
        selectionPercentage: 25.5,
        points: 44,
        price: 9.2,
        role: 'Bowler', team: 'India',
      ),
      Player(
        name: 'Steve Smith',
        imageUrl: Assets.playersImgPlayer7,
        selectionPercentage: 20.3,
        points: 41,
        price: 8.9,
        role: 'Allrounder', team: 'India',
      ),
      Player(
        name: 'Kane Williamson',
        imageUrl: Assets.playersImgVirat,
        selectionPercentage: 21.6,
        points: 43,
        price: 8.7,
        role: 'Wicketkeeper', team: 'India',
      ),
      Player(
        name: 'Virat Kohli',
        imageUrl: Assets.playersImgRohit,
        selectionPercentage: 23.1,
        points: 45,
        price: 9.4,
        role: 'Batsman', team: 'India',
      ),
      Player(
        name: 'Joe Root',
        imageUrl: Assets.playersImgPlayer3,
        selectionPercentage: 17.8,
        points: 38,
        price: 8.3,
        role: 'Bowler', team: 'India',
      ),
      Player(
        name: 'Ben Stokes',
        imageUrl: Assets.playersImgPlayer4,
        selectionPercentage: 19.7,
        points: 40,
        price: 8.6,
        role: 'Allrounder', team: 'India',
      ),
      Player(
        name: 'Marnus Labuschagne',
        imageUrl: Assets.playersImgPlayer5,
        selectionPercentage: 16.4,
        points: 37,
        price: 8.2,
        role: 'Wicketkeeper', team: 'Pakistan',
      ),
      Player(
        name: 'Aaron Finch',
        imageUrl: Assets.playersImgPlayer6,
        selectionPercentage: 18.2,
        points: 39,
        price: 8.5,
        role: 'Batsman', team: 'Pakistan',
      ),
      Player(
        name: 'Glenn Maxwell',
        imageUrl: Assets.playersImgPlayer7,
        selectionPercentage: 20.9,
        points: 41,
        price: 8.8,
        role: 'Bowler', team: 'Pakistan',
      ),
      Player(
        name: 'Jos Buttler',
        imageUrl: Assets.playersImgVirat,
        selectionPercentage: 22.5,
        points: 42,
        price: 9.0,
        role: 'Allrounder', team: 'Pakistan',
      ),
      Player(
        name: 'Quinton de Kock',
        imageUrl: Assets.playersImgRohit,
        selectionPercentage: 24.3,
        points: 44,
        price: 9.3,
        role: 'Wicketkeeper', team: 'Pakistan',
      ),
      Player(
        name: 'Rohit Sharma',
        imageUrl: Assets.playersImgPlayer4,
        selectionPercentage: 23.9,
        points: 43,
        price: 9.2,
        role: 'Batsman', team: 'Pakistan',
      ),
      Player(
        name: 'Jasprit Bumrah',
        imageUrl: Assets.playersImgPlayer7,
        selectionPercentage: 21.7,
        points: 41,
        price: 8.9,
        role: 'Bowler', team: 'Pakistan',
      ),
      Player(
        name: 'Pat Cummins',
        imageUrl: Assets.playersImgPlayer6,
        selectionPercentage: 20.4,
        points: 40,
        price: 8.7,
        role: 'Allrounder', team: 'Pakistan',
      ),
      Player(
        name: 'Rashid Khan',
        imageUrl: Assets.playersImgVirat,
        selectionPercentage: 19.5,
        points: 39,
        price: 8.4,
        role: 'Wicketkeeper', team: 'Pakistan',
      ),
      Player(
        name: 'Shikhar Dhawan',
        imageUrl: Assets.playersImgPlayer5,
        selectionPercentage: 18.1,
        points: 38,
        price: 8.2,
        role: 'Batsman', team: 'Pakistan',
      ),
      Player(
        name: 'Andre Russell',
        imageUrl: Assets.playersImgPlayer3,
        selectionPercentage: 17.6,
        points: 37,
        price: 8.1,
        role: 'Bowler', team: 'Pakistan',
      ),
    ];

    List<Player> get players => _players;

     final List<Player> _selectedPlayers = [];

    List<Player> get selectedPlayers => _selectedPlayers;

    int get selectedPlayersCount => _players.where((player) => player.isSelected).length;
    int get selectedWKCount => selectedPlayers.where((player) => player.role.toLowerCase()=="Wicketkeeper".toLowerCase()).length;
    int get selectedBowlerCount => selectedPlayers.where((player) => player.role.toLowerCase()=="Bowler".toLowerCase()).length;
    int get selectedBatsmanCount => selectedPlayers.where((player) => player.role.toLowerCase()=="Batsman".toLowerCase()).length;
    int get selectedAllRounderCount => selectedPlayers.where((player) => player.role.toLowerCase()=="Allrounder".toLowerCase()).length;

    Player? captain;
    Player? viceCaptain;

    void togglePlayerSelection(int index, context) {
      _players[index].isSelected = !_players[index].isSelected;
      if (_players[index].isSelected) {
        _selectedPlayers.add(_players[index]);
      } else {
        _selectedPlayers.remove(_players[index]);
      }
      notifyListeners();
    }

    double get totalSelectedPlayersPrice {
      return 100-(_players
          .where((player) => player.isSelected)
          .fold(0.0, (sum, player) => sum + player.price));
    }


    void selectCaptain(Player player) {
      if (viceCaptain == player) {
        viceCaptain = null;
      }
      captain = player;
      notifyListeners();
    }

    void selectViceCaptain(Player player) {
      if (captain == player) {
        captain = null;
      }
      viceCaptain = player;
      notifyListeners();
    }

    void saveCurrentTeam(context) {
      final saveTeamData = Provider.of<TeamService>(context, listen: false);
      saveTeamData.saveTeam(_selectedPlayers, captain, viceCaptain);
      Navigator.pushReplacementNamed(context, AppRoutes.contestScreen, arguments: {"tabIndex":2});
      notifyListeners();
    }

    int _lineupSwitchUp = 0;

    int get lineupSwitchUp => _lineupSwitchUp;

    void setLineupSwitchUp(int newValue) {
      _lineupSwitchUp = newValue;
      notifyListeners();
    }
  }

  class Player {
    final String name;
    final String team;
    final String imageUrl;
    final double selectionPercentage;
    final int points;
    final double price;
    final String role;
    bool isSelected;

    Player({
      required this.name,
      required this.team,
      required this.imageUrl,
      required this.selectionPercentage,
      required this.points,
      required this.price,
      required this.role,
      this.isSelected = false,
    });
  }