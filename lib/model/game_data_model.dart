class GamesDataModel {
  List<GameData>? upcoming;
  List<GameData>? live;
  List<GameData>? complete;
  List<GameData>? myUpcomingMatch;
  String? msg;
  String? status;

  GamesDataModel(
      {this.upcoming, this.live, this.complete, this.msg, this.status});

  GamesDataModel.fromJson(Map<String, dynamic> json) {
    if (json['upcoming'] != null) {
      upcoming = <GameData>[];
      json['upcoming'].forEach((v) {
        upcoming!.add(GameData.fromJson(v));
      });
    }
    if (json['live'] != null) {
      live = <GameData>[];
      json['live'].forEach((v) {
        live!.add(GameData.fromJson(v));
      });
    }
    if (json['complete'] != null) {
      complete = <GameData>[];
      json['complete'].forEach((v) {
        complete!.add(GameData.fromJson(v));
      });
    }
    if (json['my_upcoming_match'] != null) {
      myUpcomingMatch = <GameData>[];
      json['my_upcoming_match'].forEach((v) {
        myUpcomingMatch!.add(GameData.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (upcoming != null) {
      data['upcoming'] = upcoming!.map((v) => v.toJson()).toList();
    }
    if (live != null) {
      data['live'] = live!.map((v) => v.toJson()).toList();
    }
    if (complete != null) {
      data['complete'] = complete!.map((v) => v.toJson()).toList();
    }
    if (myUpcomingMatch != null) {
      data['my_upcoming_match'] = myUpcomingMatch!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class GameData {
  dynamic id;
  dynamic name;
  int? gameId;
  int? matchTeamId;
  int? seriesId;
  int? status;
  String? teamId;
  int? type;
  dynamic startDate;
  dynamic endDate;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic seriesName;
  String? matchType;
  String? homeTeamId;
  String? visitorTeamId;
  String? homeTeamName;
  String? visitorTeamName;
  String? homeTeamImage;
  String? visitorTeamImage;
  String? homeTeamShortName;
  String? visitorTeamShortName;
  dynamic isLineUp;
  dynamic megaContest;
  dynamic totalJoinedContest;
  dynamic totalJoinedTeam;
  dynamic totalWinnings;
  dynamic note;
  dynamic homeTeamScore;
  dynamic homeTeamWicket;
  dynamic homeTeamOvers;
  dynamic visitorTeamScore;
  dynamic visitorTeamWicket;
  dynamic visitorTeamOvers;
  dynamic sportsMonkMatchId;
  GameData(
      {this.id,
        this.name,
        this.gameId,
        this.matchTeamId,
        this.seriesId,
        this.status,
        this.teamId,
        this.type,
        this.startDate,
        this.endDate,
        this.createdAt,
        this.updatedAt,
        this.seriesName,
        this.matchType,
        this.homeTeamId,
        this.visitorTeamId,
        this.homeTeamName,
        this.visitorTeamName,
        this.homeTeamImage,
        this.visitorTeamImage,
        this.homeTeamShortName,
        this.visitorTeamShortName,
        this.isLineUp,
        this.megaContest,
        this.totalJoinedContest,
        this.totalJoinedTeam,
        this.totalWinnings,
        this.note,
        this.homeTeamScore,
        this.homeTeamWicket,
        this.homeTeamOvers,
        this.visitorTeamScore,
        this.visitorTeamWicket,
        this.visitorTeamOvers,
        this.sportsMonkMatchId,
      });

  GameData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gameId = json['game_id'];
    matchTeamId = json['matchtype_id'];
    seriesId = json['series_id'];
    status = json['status'];
    teamId = json['team_id'];
    type = json['type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    seriesName = json['seriesname'];
    matchType = json['matchtype'];
    homeTeamId = json['home_teamid'];
    visitorTeamId = json['visitorteam_id'];
    homeTeamName = json['hometeam_name'];
    visitorTeamName = json['visitorteam_name'];
    homeTeamImage = json['hometeam_image'];
    visitorTeamImage = json['visitorteam_image'];
    homeTeamShortName = json['hometeam_short_name'];
    visitorTeamShortName = json['visitorteam_short_name'];
    isLineUp = json['is_lineup'];
    megaContest = json['megaContest'];
    totalJoinedContest = json['total_joined_contest'];
    totalJoinedTeam = json['total_joined_team'];
    totalWinnings = json['total_winnings'];
    note = json['note'];
    homeTeamScore = json['home_team_score'];
    homeTeamWicket = json['home_team_wicket'];
    homeTeamOvers = json['home_team_overs'];
    visitorTeamScore = json['visitor_team_score'];
    visitorTeamWicket = json['visitor_team_wicket'];
    visitorTeamOvers = json['visitor_team_overs'];
    sportsMonkMatchId = json['sportsmonk_match_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['game_id'] = gameId;
    data['matchtype_id'] = matchTeamId;
    data['series_id'] = seriesId;
    data['status'] = status;
    data['team_id'] = teamId;
    data['type'] = type;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['seriesname'] = seriesName;
    data['matchtype'] = matchType;
    data['home_teamid'] = homeTeamId;
    data['visitorteam_id'] = visitorTeamId;
    data['hometeam_name'] = homeTeamName;
    data['visitorteam_name'] = visitorTeamName;
    data['hometeam_image'] = visitorTeamName;
    data['visitorteam_image'] = visitorTeamName;
    data['hometeam_short_name'] = homeTeamShortName;
    data['visitorteam_short_name'] = visitorTeamShortName;
    data['is_lineup'] = isLineUp;
    data['megaContest'] = megaContest;
    data['total_joined_contest'] = totalJoinedContest;
    data['total_joined_team'] = totalJoinedTeam;
    data['total_winnings'] = totalWinnings;
    data['note'] = note;
    data['home_team_score'] = homeTeamScore;
    data['home_team_wicket'] = homeTeamWicket;
    data['home_team_overs'] = homeTeamOvers;
    data['visitor_team_score'] = visitorTeamScore;
    data['visitor_team_wicket'] = visitorTeamWicket;
    data['visitor_team_overs'] = visitorTeamOvers;
    data['sportsmonk_match_id'] = sportsMonkMatchId;
    return data;
  }
}
