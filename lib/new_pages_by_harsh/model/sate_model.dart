
class MatchPlayer {
  dynamic id;
  dynamic matchid;
  dynamic playerid;
  dynamic sportsmonkPid;
  dynamic teamid;
  dynamic isPlaying;
  dynamic thirdPartySeasonId;
  dynamic totalPoint;
  dynamic bollingPoint;
  dynamic fieldingPoint;
  dynamic playingPoint;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic playername;
  dynamic playerimage;
  dynamic teamname;
  dynamic designationName;
  dynamic selBy;
  dynamic cBy;
  dynamic vcBy;

  MatchPlayer(
      {this.id,
        this.matchid,
        this.playerid,
        this.sportsmonkPid,
        this.teamid,
        this.isPlaying,
        this.thirdPartySeasonId,
        this.totalPoint,
        this.bollingPoint,
        this.fieldingPoint,
        this.playingPoint,
        this.createdAt,
        this.updatedAt,
        this.playername,
        this.playerimage,
        this.teamname,
        this.designationName,
        this.selBy,
        this.cBy,
        this.vcBy});

  MatchPlayer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchid = json['matchid'];
    playerid = json['playerid'];
    sportsmonkPid = json['sportsmonk_pid'];
    teamid = json['teamid'];
    isPlaying = json['is_playing'];
    thirdPartySeasonId = json['third_party_season_id'];
    totalPoint = json['total_point'];
    bollingPoint = json['bolling_point'];
    fieldingPoint = json['fielding_point'];
    playingPoint = json['playing_point'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    playername = json['playername'];
    playerimage = json['playerimage'];
    teamname = json['teamname'];
    designationName = json['designation_name'];
    selBy = json['sel_by'];
    cBy = json['c_by'];
    vcBy = json['vc_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['matchid'] = matchid;
    data['playerid'] = playerid;
    data['sportsmonk_pid'] = sportsmonkPid;
    data['teamid'] = teamid;
    data['is_playing'] = isPlaying;
    data['third_party_season_id'] = thirdPartySeasonId;
    data['total_point'] = totalPoint;
    data['bolling_point'] = bollingPoint;
    data['fielding_point'] = fieldingPoint;
    data['playing_point'] = playingPoint;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['playername'] = playername;
    data['playerimage'] = playerimage;
    data['teamname'] = teamname;
    data['designation_name'] = designationName;
    data['sel_by'] = selBy;
    data['c_by'] = cBy;
    data['vc_by'] = vcBy;
    return data;
  }
}

class TeamsData {
  dynamic id;
  dynamic gameid;
  dynamic matchId;
  dynamic userid;
  dynamic teamName;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic allPoint;
  dynamic visitorTeamId;
  dynamic hometeam_id;
  List<Playerlist>? playerlist;

  TeamsData(
      {this.id,
        this.gameid,
        this.matchId,
        this.userid,
        this.teamName,
        this.createdAt,
        this.updatedAt,
        this.allPoint,
         this.visitorTeamId,
         this.hometeam_id,
        this.playerlist});

  TeamsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameid = json['gameid'];
    matchId = json['match_id'];
    userid = json['userid'];
    teamName = json['team_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    allPoint = json['all_point'];
    visitorTeamId = json['visitorteam_id'];
    hometeam_id = json['hometeam_id'];
    if (json['playerlist'] != null) {
      playerlist = <Playerlist>[];
      json['playerlist'].forEach((v) {
        playerlist!.add(Playerlist.fromJson(v));
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
    if (playerlist != null) {
      data['playerlist'] = playerlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Playerlist {
  dynamic id;
  dynamic matchid;
  dynamic myTeamid;
  dynamic playerid;
  dynamic sportsmonkPid;
  dynamic designationName;
  dynamic isCaptain;
  dynamic isViceCaptain;
  dynamic teamid;
  dynamic totalPoint;
  dynamic battingPoint;
  dynamic bollingPoint;
  dynamic fieldingPoint;
  dynamic playingPoint;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic playerName;
  dynamic playerImage;
  dynamic teamname;
  dynamic selBy;
  dynamic cBy;
  dynamic vcBy;

  Playerlist(
      {this.id,
        this.matchid,
        this.myTeamid,
        this.playerid,
        this.sportsmonkPid,
        this.designationName,
        this.isCaptain,
        this.isViceCaptain,
        this.teamid,
        this.totalPoint,
        this.battingPoint,
        this.bollingPoint,
        this.fieldingPoint,
        this.playingPoint,
        this.createdAt,
        this.updatedAt,
        this.playerName,
        this.playerImage,
        this.teamname,
        this.selBy,
        this.cBy,
        this.vcBy});

  Playerlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchid = json['matchid'];
    myTeamid = json['my_teamid'];
    playerid = json['playerid'];
    sportsmonkPid = json['sportsmonk_pid'];
    designationName = json['designation_name'];
    isCaptain = json['is_captain'];
    isViceCaptain = json['is_vice_captain'];
    teamid = json['teamid'];
    totalPoint = json['total_point'];
    battingPoint = json['batting_point'];
    bollingPoint = json['bolling_point'];
    fieldingPoint = json['fielding_point'];
    playingPoint = json['playing_point'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    playerName = json['player_name'];
    playerImage = json['player_image'];
    teamname = json['teamname'];
    selBy = json['sel_by'];
    cBy = json['c_by'];
    vcBy = json['vc_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['matchid'] = matchid;
    data['my_teamid'] = myTeamid;
    data['playerid'] = playerid;
    data['sportsmonk_pid'] = sportsmonkPid;
    data['designation_name'] = designationName;
    data['is_captain'] = isCaptain;
    data['is_vice_captain'] = isViceCaptain;
    data['teamid'] = teamid;
    data['total_point'] = totalPoint;
    data['batting_point'] = battingPoint;
    data['bolling_point'] = bollingPoint;
    data['fielding_point'] = fieldingPoint;
    data['playing_point'] = playingPoint;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['player_name'] = playerName;
    data['player_image'] = playerImage;
    data['teamname'] = teamname;
    data['sel_by'] = selBy;
    data['c_by'] = cBy;
    data['vc_by'] = vcBy;
    return data;
  }
}


