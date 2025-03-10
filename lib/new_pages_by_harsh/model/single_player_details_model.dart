class SinglePlayerDetailsModel {
  PersonalDetails? personalDetails;
  TourFantacyStates? tourFantacyStates;
  List<Data>? data;
  dynamic msg;
  dynamic status;


  SinglePlayerDetailsModel(
      {this.personalDetails,
        this.tourFantacyStates,
        this.data,
        this.msg,
        this.status});

  SinglePlayerDetailsModel.fromJson(Map<String, dynamic> json) {
    personalDetails = json['personal_details'] != null
        ? PersonalDetails.fromJson(json['personal_details'])
        : null;
    tourFantacyStates = json['tour_fantacy_states'] != null
        ? TourFantacyStates.fromJson(json['tour_fantacy_states'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

}

class PersonalDetails {
  dynamic name;
  dynamic playerImage;
  dynamic points;
  dynamic creditPoints;
  dynamic designation;
  dynamic bat;
  dynamic bowl;
  dynamic nationality;
  dynamic dob;
  dynamic playingStatus;

  PersonalDetails(
      {this.name,
        this.playerImage,
        this.points,
        this.creditPoints,
        this.designation,
        this.bat,
        this.bowl,
        this.nationality,
        this.dob,
        this.playingStatus});

  PersonalDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    playerImage = json['player_image'];
    points = json['points'];
    creditPoints = json['credit_points'];
    designation = json['designation'];
    bat = json['bat'];
    bowl = json['bowl'];
    nationality = json['nationality'];
    dob = json['dob'];
    playingStatus = json['playing_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['player_image'] = playerImage;
    data['points'] = points;
    data['credit_points'] = creditPoints;
    data['designation'] = designation;
    data['bat'] = bat;
    data['bowl'] = bowl;
    data['nationality'] = nationality;
    data['dob'] = dob;
    data['playing_status'] = playingStatus;
    return data;
  }
}

class TourFantacyStates {
  dynamic matchPlayed;
  dynamic avgPoints;

  TourFantacyStates({this.matchPlayed, this.avgPoints});

  TourFantacyStates.fromJson(Map<String, dynamic> json) {
    matchPlayed = json['match_played'];
    avgPoints = json['avg_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['match_played'] = matchPlayed;
    data['avg_points'] = avgPoints;
    return data;
  }
}

class Data {
  dynamic id;
  dynamic matchid;
  dynamic playerid;
  dynamic sportsmonkPid;
  dynamic teamid;
  dynamic isPlaying;
  dynamic isSubtitute;
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
  dynamic bowlerData;
  dynamic batsmanData;
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
  dynamic creditPoints;
  dynamic selectedBy;
  dynamic wicketsP;
  dynamic singleRun;
  dynamic sixP;
  dynamic foursP;
  dynamic startDate;
  dynamic hometeamShortName;
  dynamic visitorteamShortName;
  dynamic hometeamId;
  dynamic visitorteamId;
  dynamic oppositeTeam;
  List<EventData>? eventData;

  Data(
      {this.id,
        this.matchid,
        this.playerid,
        this.sportsmonkPid,
        this.teamid,
        this.isPlaying,
        this.isSubtitute,
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
        this.creditPoints,
        this.selectedBy,
        this.wicketsP,
        this.singleRun,
        this.sixP,
        this.foursP,
        this.startDate,
        this.hometeamShortName,
        this.visitorteamShortName,
        this.hometeamId,
        this.visitorteamId,
        this.oppositeTeam,
        this.eventData});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchid = json['matchid'];
    playerid = json['playerid'];
    sportsmonkPid = json['sportsmonk_pid'];
    teamid = json['teamid'];
    isPlaying = json['is_playing'];
    isSubtitute = json['is_subtitute'];
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
    bowlerData = json['bowler_data'];
    batsmanData = json['batsman_data'];
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
    creditPoints = json['credit_points'];
    selectedBy = json['selected_by'];
    wicketsP = json['wickets_p'];
    singleRun = json['single_run'];
    sixP = json['six_p'];
    foursP = json['fours_p'];
    startDate = json['start_date'];
    hometeamShortName = json['hometeam_short_name'];
    visitorteamShortName = json['visitorteam_short_name'];
    hometeamId = json['hometeam_id'];
    visitorteamId = json['visitorteam_id'];
    oppositeTeam = json['opposite_team'];
    if (json['event_data'] != null) {
      eventData = <EventData>[];
      json['event_data'].forEach((v) {
        eventData!.add(EventData.fromJson(v));
      });
    }
  }

}

class EventData {
  dynamic event;
  dynamic points;
  dynamic actual;

  EventData({this.event, this.points, this.actual});

  EventData.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    points = json['points'];
    actual = json['actual'];
  }

}
