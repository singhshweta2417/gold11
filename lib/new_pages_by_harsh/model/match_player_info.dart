class MatchPlayerInfo {
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
  List<EventData>? eventData;

  MatchPlayerInfo(
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
      this.eventData});

  MatchPlayerInfo.fromJson(Map<String, dynamic> json) {
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
