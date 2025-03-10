class TeamDataModel {
  List<TeamData>? data;
  dynamic msg;
  dynamic status;

  TeamDataModel({this.data, this.msg, this.status});

  TeamDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TeamData>[];
      json['data'].forEach((v) {
        data!.add(TeamData.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class TeamData {
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
  dynamic aR;
  dynamic bAT;
  dynamic bOWL;
  dynamic wK;
  dynamic homeTeamId;
  dynamic visitorTeamId;
  dynamic homeTeamName;
  dynamic visitorTeamName;
  dynamic homeTeamPlayerCount;
  dynamic visitorTeamPlayerCount;
  dynamic matchStatus;
  List<TeamPlayerList>? playerList;
  dynamic joinedStatus;


  TeamData(
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
      this.aR,
      this.bAT,
      this.bOWL,
      this.wK,
      this.homeTeamId,
      this.visitorTeamId,
      this.homeTeamName,
      this.visitorTeamName,
      this.homeTeamPlayerCount,
      this.visitorTeamPlayerCount,
      this.matchStatus,
      this.playerList,
      this.joinedStatus
      });

  TeamData.fromJson(Map<String, dynamic> json) {
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
    aR = json['AR'];
    bAT = json['BAT'];
    bOWL = json['BOWL'];
    wK = json['WK'];
    homeTeamId = json['home_teamid'];
    visitorTeamId = json['visitorteam_id'];
    homeTeamName = json['hometeam_name'];
    visitorTeamName = json['visitorteam_name'];
    homeTeamPlayerCount = json['home_team_player_count'];
    visitorTeamPlayerCount = json['visitor_team_player_count'];
    matchStatus = json['matchstatus'];
    if (json['playerlist'] != null) {
      playerList = <TeamPlayerList>[];
      json['playerlist'].forEach((v) {
        playerList!.add(TeamPlayerList.fromJson(v));
      });
    }
    joinedStatus = json["joined_status"];
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
    data['AR'] = aR;
    data['BAT'] = bAT;
    data['BOWL'] = bOWL;
    data['WK'] = wK;
    data['home_teamid'] = homeTeamId;
    data['visitorteam_id'] = visitorTeamId;
    data['hometeam_name'] = homeTeamName;
    data['visitorteam_name'] = visitorTeamName;
    data['home_team_player_count'] = homeTeamPlayerCount;
    data['visitor_team_player_count'] = visitorTeamPlayerCount;
    if (playerList != null) {
      data['playerlist'] = playerList!.map((v) => v.toJson()).toList();
    }
    data["joined_status"]= joinedStatus;
    return data;
  }
}

class TeamPlayerList {
  dynamic id;
  dynamic matchId;
  dynamic myTeamId;
  dynamic playerId;
  dynamic sportsMonkPid;
  dynamic designationName;
  dynamic isCaptain;
  dynamic isViceCaptain;
  dynamic teamId;
  dynamic totalPoint;
  dynamic battingPoint;
  dynamic bollingPoint;
  dynamic fieldingPoint;
  dynamic playingPoint;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic playerName;
  dynamic playerImage;
  dynamic teamName;
  dynamic selBy;
  dynamic cBy;
  dynamic vcBy;

  TeamPlayerList({
    this.id,
    this.matchId,
    this.myTeamId,
    this.playerId,
    this.sportsMonkPid,
    this.designationName,
    this.isCaptain,
    this.isViceCaptain,
    this.teamId,
    this.totalPoint,
    this.battingPoint,
    this.bollingPoint,
    this.fieldingPoint,
    this.playingPoint,
    this.createdAt,
    this.updatedAt,
    this.playerName,
    this.playerImage,
    this.teamName,
    this.selBy,
    this.cBy,
    this.vcBy,
  });

  TeamPlayerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['matchid'];
    myTeamId = json['my_teamid'];
    playerId = json['playerid'];
    sportsMonkPid = json['sportsmonk_pid'];
    designationName = json['designation_name'];
    isCaptain = json['is_captain'];
    isViceCaptain = json['is_vice_captain'];
    teamId = json['teamid'];
    totalPoint = json['total_point'];
    battingPoint = json['batting_point'];
    bollingPoint = json['bolling_point'];
    fieldingPoint = json['fielding_point'];
    playingPoint = json['playing_point'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    playerName = json['player_name'];
    playerImage = json['player_image'];
    teamName = json['teamname'];
    selBy = json['sel_by'];
    cBy = json['c_by'];
    vcBy = json['vc_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['matchid'] = matchId;
    data['my_teamid'] = myTeamId;
    data['playerid'] = playerId;
    data['sportsmonk_pid'] = sportsMonkPid;
    data['designation_name'] = designationName;
    data['is_captain'] = isCaptain;
    data['is_vice_captain'] = isViceCaptain;
    data['teamid'] = teamId;
    data['total_point'] = totalPoint;
    data['batting_point'] = battingPoint;
    data['bolling_point'] = bollingPoint;
    data['fielding_point'] = fieldingPoint;
    data['playing_point'] = playingPoint;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['player_name'] = playerName;
    data['player_image'] = playerImage;
    data['teamname'] = teamName;
    data['sel_by'] = selBy;
    data['c_by'] = cBy;
    data['vc_by'] = vcBy;
    return data;
  }
}
