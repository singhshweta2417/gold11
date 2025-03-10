


import 'package:gold11/model/team_data_model.dart';

class ContestDataModel {
  dynamic matchName;
  dynamic seasonId;
  dynamic team1;
  dynamic team2;
  List<ContestList>? contestList;
  List<MyContest>? myContest;
  dynamic msg;
  dynamic status;

  ContestDataModel(
      {this.matchName,
        this.seasonId,
        this.team1,
        this.team2,
        this.contestList,
        this.myContest,
        this.msg,
        this.status});

  ContestDataModel.fromJson(Map<String, dynamic> json) {
    matchName = json['matchName'];
    seasonId = json['season_id'];
    team1 = json['team1'];
    team2 = json['team2'];
    if (json['contestlist'] != null) {
      contestList = <ContestList>[];
      json['contestlist'].forEach((v) {
        contestList!.add(ContestList.fromJson(v));
      });
    }
    if (json['mycontest'] != null) {
      myContest = <MyContest>[];
      json['mycontest'].forEach((v) {
        myContest!.add(MyContest.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['matchName'] = matchName;
    data['season_id'] = seasonId;
    data['team1'] = team1;
    data['team2'] = team2;
    if (contestList != null) {
      data['contestlist'] = contestList!.map((v) => v.toJson()).toList();
    }
    if (myContest != null) {
      data['mycontest'] = myContest!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class ContestList {
  dynamic id;
  dynamic gameId;
  dynamic matchId;
  dynamic name;
  dynamic type;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic prizePool;
  dynamic entryFee;
  dynamic totalSpot;
  dynamic entryCount;
  dynamic contestSuccessType;
  dynamic firstPrize;
  dynamic entryLimit;
  dynamic spotFilled;
  dynamic leftSpot;
  dynamic myJoinedCount;
  dynamic entry;
  dynamic desprice;


  ContestList(
      {this.id,
        this.gameId,
        this.matchId,
        this.name,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.prizePool,
        this.entryFee,
        this.totalSpot,
        this.entryCount,
        this.contestSuccessType,
        this.firstPrize,
        this.entryLimit,
        this.spotFilled,
        this.leftSpot,
        this.myJoinedCount,
        this.entry,
        this.desprice
      });

  ContestList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameId = json['game_id'];
    matchId = json['match_id'];
    name = json['name'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    prizePool = json['prize_pool'];
    entryFee = json['entry_fee'];
    totalSpot = json['total_spot'];
    entryCount = json['entry_count'];
    contestSuccessType = json['contest_success_type'];
    firstPrize = json['first_prize'];
    entryLimit = json['entry_limit'];
    spotFilled = json['filled_spot'];
    leftSpot = json['left_spot'];
    myJoinedCount = json['my_joined_count'];
    entry = json['entry'];
    desprice = json['desprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['game_id'] = gameId;
    data['match_id'] = matchId;
    data['name'] = name;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['prize_pool'] = prizePool;
    data['entry_fee'] = entryFee;
    data['total_spot'] = totalSpot;
    data['entry_count'] = entryCount;
    data['contest_success_type'] = contestSuccessType;
    data['first_prize'] = firstPrize;
    data['entry_limit'] = entryLimit;
    data['filled_spot'] = spotFilled;
    data['left_spot'] = leftSpot;
    data['my_joined_count'] = myJoinedCount;
    data['entry'] = entry;
    data['desprice'] = desprice;
    return data;
  }
}

class MyContest {
  dynamic id;
  dynamic gameId;
  dynamic myMatchId;
  dynamic userId;
  dynamic contestId;
  dynamic myTeamid;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic name;
  dynamic type;
  dynamic entryFee;
  dynamic totalSpot;
  dynamic entryCount;
  dynamic contestSuccessType;
  dynamic firstPrize;
  dynamic entryLimit;
  dynamic numOfJoinedTeam;
  dynamic teamNames;
  dynamic myTeamId;
  List<Teams>? teams;
  dynamic leftSpots;

  MyContest(
      {this.id,
        this.gameId,
        this.myMatchId,
        this.userId,
        this.contestId,
        this.myTeamid,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.type,
        this.entryFee,
        this.totalSpot,
        this.entryCount,
        this.contestSuccessType,
        this.firstPrize,
        this.entryLimit,
        this.numOfJoinedTeam,
        this.teamNames,
        this.myTeamId,
        this.teams,
        this.leftSpots
      });

  MyContest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameId = json['gameid'];
    myMatchId = json['my_match_id'];
    userId = json['user_id'];
    contestId = json['contest_id'];
    myTeamid = json['my_teamid'];
    createdAt = json['ceated_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    type = json['type'];
    entryFee = json['entry_fee'];
    totalSpot = json['total_spot'];
    entryCount = json['entry_count'];
    contestSuccessType = json['contest_success_type'];
    firstPrize = json['first_prize'];
    entryLimit = json['entry_limit'];
    numOfJoinedTeam = json['num_of_joined_team'];
    teamNames = json['team_names'];
    myTeamId = json['my_team_id'];
    leftSpots= json["left_spot"];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(Teams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gameid'] = gameId;
    data['my_match_id'] = myMatchId;
    data['user_id'] = userId;
    data['contest_id'] = contestId;
    data['my_teamid'] = myTeamid;
    data['ceated_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['type'] = type;
    data['entry_fee'] = entryFee;
    data['total_spot'] = totalSpot;
    data['entry_count'] = entryCount;
    data['contest_success_type'] = contestSuccessType;
    data['first_prize'] = firstPrize;
    data['entry_limit'] = entryLimit;
    data['num_of_joined_team'] = numOfJoinedTeam;
    data['team_names'] = teamNames;
    data['my_team_id'] = myTeamId;
    data["left_spot"]= leftSpots;
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teams {
  dynamic id;
  dynamic gameid;
  dynamic matchId;
  dynamic userid;
  dynamic teamName;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic allPoint;
  dynamic captainName;
  dynamic captainImage;
  dynamic viceCaptainName;
  dynamic viceCaptainImage;
  dynamic matchstatus;
  List<TeamPlayerList>? playerlist;

  Teams(
      {this.id,
        this.gameid,
        this.matchId,
        this.userid,
        this.teamName,
        this.createdAt,
        this.updatedAt,
        this.allPoint,
        this.captainName,
        this.captainImage,
        this.viceCaptainName,
        this.viceCaptainImage,
        this.matchstatus,
      this.playerlist
      });

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameid = json['gameid'];
    matchId = json['match_id'];
    userid = json['userid'];
    teamName = json['team_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    allPoint = json['all_point'];
    captainName = json['captain_name'];
    captainImage = json['captain_image'];
    viceCaptainName = json['vice_captain_name'];
    viceCaptainImage = json['vice_captain_image'];
    matchstatus = json['matchstatus'];
    if (json['playerlist'] != null) {
      playerlist = <TeamPlayerList>[];
      json['playerlist'].forEach((v) {
        playerlist!.add(TeamPlayerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gameid'] = gameid;
    data['match_id'] = matchId;
    data['userid'] = userid;
    data['team_name'] = teamName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['all_point'] = allPoint;
    data['captain_name'] = captainName;
    data['captain_image'] = captainImage;
    data['vice_captain_name'] = viceCaptainName;
    data['vice_captain_image'] = viceCaptainImage;
    data['matchstatus'] = matchstatus;
    return data;
  }
}




