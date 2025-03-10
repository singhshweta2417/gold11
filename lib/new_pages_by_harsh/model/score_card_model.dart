
class MatchPlayer {
  dynamic id;
  dynamic matchid;
  dynamic playerid;
  dynamic sportsmonkPid;
  dynamic teamid;
  dynamic isPlaying;
  dynamic thirdPartySeasonId;
  dynamic totalPoint;
  dynamic battingPoint;
  dynamic bollingPoint;
  dynamic fieldingPoint;
  dynamic playingPoint;
  dynamic singleDoubleRun;
  dynamic fours;
  dynamic sixes;
  dynamic wicket;
  dynamic score;
  dynamic isBat;
  dynamic isBowl;
  BowlerData? bowlerData;
  BatsmanData? batsmanData;
  dynamic runOutBy;
  dynamic catchBy;
  dynamic bowledBy;
  dynamic wicketType;
  dynamic wicketFallBall;
  dynamic wicketFallScore;
  dynamic battingOrder;
  dynamic bollingOrder;
  dynamic isOut;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic playername;
  dynamic playerimage;
  dynamic teamname;
  dynamic designationName;
  dynamic selBy;
  dynamic cBy;
  dynamic vcBy;
  dynamic wicketData;

  MatchPlayer(
      {this.id,
        this.matchid,
        this.playerid,
        this.sportsmonkPid,
        this.teamid,
        this.isPlaying,
        this.thirdPartySeasonId,
        this.totalPoint,
        this.battingPoint,
        this.bollingPoint,
        this.fieldingPoint,
        this.playingPoint,
        this.singleDoubleRun,
        this.fours,
        this.sixes,
        this.wicket,
        this.score,
        this.isBat,
        this.isBowl,
        this.bowlerData,
        this.batsmanData,
        this.runOutBy,
        this.catchBy,
        this.bowledBy,
        this.wicketType,
        this.wicketFallBall,
        this.wicketFallScore,
        this.battingOrder,
        this.bollingOrder,
        this.isOut,
        this.createdAt,
        this.updatedAt,
        this.playername,
        this.playerimage,
        this.teamname,
        this.designationName,
        this.selBy,
        this.cBy,
        this.vcBy,
        this.wicketData});

  MatchPlayer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchid = json['matchid'];
    playerid = json['playerid'];
    sportsmonkPid = json['sportsmonk_pid'];
    teamid = json['teamid'];
    isPlaying = json['is_playing'];
    thirdPartySeasonId = json['third_party_season_id'];
    totalPoint = json['total_point'];
    battingPoint = json['batting_point'];
    bollingPoint = json['bolling_point'];
    fieldingPoint = json['fielding_point'];
    playingPoint = json['playing_point'];
    singleDoubleRun = json['single_double_run'];
    fours = json['fours'];
    sixes = json['sixes'];
    wicket = json['wicket'];
    score = json['score'];
    isBat = json['is_bat'];
    isBowl = json['is_bowl'];
    bowlerData = json['bowler_data'] != null
        ? BowlerData.fromJson(json['bowler_data'])
        : null;
    batsmanData = json['batsman_data'] != null
        ? BatsmanData.fromJson(json['batsman_data'])
        : null;
    runOutBy = json['run_out_by'];
    catchBy = json['catch_by'];
    bowledBy = json['bowled_by'];
    wicketType = json['wicket_type'];
    wicketFallBall = json['wicket_fall_ball'];
    wicketFallScore = json['wicket_fall_score'];
    battingOrder = json['batting_order'];
    bollingOrder = json['bolling_order'];
    isOut = json['is_out'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    playername = json['playername'];
    playerimage = json['playerimage'];
    teamname = json['teamname'];
    designationName = json['designation_name'];
    selBy = json['sel_by'];
    cBy = json['c_by'];
    vcBy = json['vc_by'];
    wicketData = json['Wicket_data'];
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
    data['batting_point'] = battingPoint;
    data['bolling_point'] = bollingPoint;
    data['fielding_point'] = fieldingPoint;
    data['playing_point'] = playingPoint;
    data['single_double_run'] = singleDoubleRun;
    data['fours'] = fours;
    data['sixes'] = sixes;
    data['wicket'] = wicket;
    data['score'] = score;
    data['is_bat'] = isBat;
    data['is_bowl'] = isBowl;
    if (bowlerData != null) {
      data['bowler_data'] = bowlerData!.toJson();
    }
    if (batsmanData != null) {
      data['batsman_data'] = batsmanData!.toJson();
    }
    data['run_out_by'] = runOutBy;
    data['catch_by'] = catchBy;
    data['bowled_by'] = bowledBy;
    data['wicket_type'] = wicketType;
    data['wicket_fall_ball'] = wicketFallBall;
    data['wicket_fall_score'] = wicketFallScore;
    data['batting_order'] = battingOrder;
    data['bolling_order'] = bollingOrder;
    data['is_out'] = isOut;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['playername'] = playername;
    data['playerimage'] = playerimage;
    data['teamname'] = teamname;
    data['designation_name'] = designationName;
    data['sel_by'] = selBy;
    data['c_by'] = cBy;
    data['vc_by'] = vcBy;
    data['Wicket_data'] = wicketData;
    return data;
  }
}

class BowlerData {
  dynamic overs;
  dynamic medians;
  dynamic runs;
  dynamic wickets;
  dynamic eco;

  BowlerData({this.overs, this.medians, this.runs, this.wickets, this.eco});

  BowlerData.fromJson(Map<String, dynamic> json) {
    overs = json['overs'];
    medians = json['medians'];
    runs = json['runs'];
    wickets = json['wickets'];
    eco = json['eco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['overs'] = overs;
    data['medians'] = medians;
    data['runs'] = runs;
    data['wickets'] = wickets;
    data['eco'] = eco;
    return data;
  }
}

class BatsmanData {
  dynamic run;
  dynamic ball;
  dynamic fourX;
  dynamic sixX;
  dynamic strikeRate;

  BatsmanData({this.run, this.ball, this.fourX, this.sixX, this.strikeRate});

  BatsmanData.fromJson(Map<String, dynamic> json) {
    run = json['run'];
    ball = json['ball'];
    fourX = json['four_x'];
    sixX = json['six_x'];
    strikeRate = json['strike_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['run'] = run;
    data['ball'] = ball;
    data['four_x'] = fourX;
    data['six_x'] = sixX;
    data['strike_rate'] = strikeRate;
    return data;
  }
}

class WicketFall {
  dynamic playerid;
  dynamic sportsmonkPid;
  dynamic teamid;
  dynamic wicketFallBall;
  dynamic wicketFallScore;
  dynamic playername;
  dynamic playerimage;
  dynamic teamname;
  dynamic designationName;
  dynamic wicketDown;

  WicketFall(
      {this.playerid,
        this.sportsmonkPid,
        this.teamid,
        this.wicketFallBall,
        this.wicketFallScore,
        this.playername,
        this.playerimage,
        this.teamname,
        this.designationName,
        this.wicketDown});

  WicketFall.fromJson(Map<String, dynamic> json) {
    playerid = json['playerid'];
    sportsmonkPid = json['sportsmonk_pid'];
    teamid = json['teamid'];
    wicketFallBall = json['wicket_fall_ball'];
    wicketFallScore = json['wicket_fall_score'];
    playername = json['playername'];
    playerimage = json['playerimage'];
    teamname = json['teamname'];
    designationName = json['designation_name'];
    wicketDown = json['wicket_down'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['playerid'] = playerid;
    data['sportsmonk_pid'] = sportsmonkPid;
    data['teamid'] = teamid;
    data['wicket_fall_ball'] = wicketFallBall;
    data['wicket_fall_score'] = wicketFallScore;
    data['playername'] = playername;
    data['playerimage'] = playerimage;
    data['teamname'] = teamname;
    data['designation_name'] = designationName;
    data['wicket_down'] = wicketDown;
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
  dynamic homeTeamid;
  dynamic visitorteamId;
  dynamic hometeamName;
  dynamic visitorteamName;
  List<Playerlist>? playerlist;

  Teams(
      {this.id,
        this.gameid,
        this.matchId,
        this.userid,
        this.teamName,
        this.createdAt,
        this.updatedAt,
        this.allPoint,
        this.homeTeamid,
        this.visitorteamId,
        this.hometeamName,
        this.visitorteamName,
        this.playerlist});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameid = json['gameid'];
    matchId = json['match_id'];
    userid = json['userid'];
    teamName = json['team_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    allPoint = json['all_point'];
    homeTeamid = json['home_teamid'];
    visitorteamId = json['visitorteam_id'];
    hometeamName = json['hometeam_name'];
    visitorteamName = json['visitorteam_name'];
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
    data['home_teamid'] = homeTeamid;
    data['visitorteam_id'] = visitorteamId;
    data['hometeam_name'] = hometeamName;
    data['visitorteam_name'] = visitorteamName;
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
