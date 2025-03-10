class AllPlayerInfoModel {
  dynamic id;
  dynamic matchId;
  dynamic playerId;
  dynamic sportsMonkPid;
  dynamic teamId;
  dynamic isPlaying;
  dynamic isSubTitute;
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
  dynamic playerName;
  dynamic playerImage;
  dynamic creditPoints;
  dynamic selectedBy;
  dynamic wicketsP;
  dynamic singleRun;
  dynamic sixP;
  dynamic foursP;
  List<EventData>? eventData;

  AllPlayerInfoModel(
      {this.id,
      this.matchId,
      this.playerId,
      this.sportsMonkPid,
      this.teamId,
      this.isPlaying,
      this.isSubTitute,
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
      this.playerName,
      this.playerImage,
      this.creditPoints,
      this.selectedBy,
      this.wicketsP,
      this.singleRun,
      this.sixP,
      this.foursP,
      this.eventData});

  AllPlayerInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['matchid'];
    playerId = json['playerid'];
    sportsMonkPid = json['sportsmonk_pid'];
    teamId = json['teamid'];
    isPlaying = json['is_playing'];
    isSubTitute = json['is_subtitute'];
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
    playerName = json['playername'];
    playerImage = json['playerimage'];
    creditPoints = json['credit_points'];
    selectedBy = json['selected_by'];
    wicketsP = json['wickets_p'];
    singleRun = json['single_run'];
    sixP = json['six_p'];
    foursP = json['fours_p'];
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
