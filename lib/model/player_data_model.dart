class PlayerDataModel {
  List<PlayerData>? data;
  String? msg;
  String? status;
  dynamic lineUp;

  PlayerDataModel({this.data, this.msg, this.status,this.lineUp});

  PlayerDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PlayerData>[];
      json['data'].forEach((v) {
        data!.add(PlayerData.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
    lineUp = json['lineup'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['status'] = status;
    data['lineup'] = lineUp;
    return data;
  }
}

class PlayerData {
  int? id;
  int? pid;
  int? thirdPartySeasonId;
  int? teamId;
  int? isPlaying;
  int? creditPoints;
  int? seriesPoints;
  String? createdDate;
  String? modifiedDate;
  String? playerName;
  String? playerImage;
  int? designationId;
  String? designationName;
  String? teamName;
  dynamic teamShortName;
  dynamic sportsMonkPid;
  dynamic playingStatus;
  dynamic playedLastMatch;
  dynamic cBy;
  dynamic vcBy;
  bool? isSelected;

  PlayerData(
      {this.id,
      this.pid,
      this.thirdPartySeasonId,
      this.teamId,
      this.isPlaying,
      this.creditPoints,
      this.seriesPoints,
      this.createdDate,
      this.modifiedDate,
      this.playerName,
      this.playerImage,
      this.designationId,
      this.designationName,
      this.teamName,
      this.teamShortName,
      this.sportsMonkPid,
      this.playingStatus,
      this.playedLastMatch,
      this.cBy,
      this.vcBy,
      this.isSelected = false});

  PlayerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    thirdPartySeasonId = json['third_party_season_id'];
    teamId = json['teamid'];
    isPlaying = json['is_playing'];
    creditPoints = json['credit_points'];
    seriesPoints = json['series_points'];
    createdDate = json['created_date'];
    modifiedDate = json['modified_date'];
    playerName = json['playername'];
    playerImage = json['player_image'];
    designationId = json['designation_id'];
    designationName = json['designation_name'];
    teamName = json['teamname'];
    teamShortName = json['teamshortname'];
    sportsMonkPid = json['sportsmonk_pid'];
    playingStatus = json['playigstatus'];
    playedLastMatch = json['played_last_match'];
    cBy = json['c_by'];
    vcBy = json['vc_by'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pid'] = pid;
    data['third_party_season_id'] = thirdPartySeasonId;
    data['teamid'] = teamId;
    data['is_playing'] = isPlaying;
    data['credit_points'] = creditPoints;
    data['series_points'] = seriesPoints;
    data['created_date'] = createdDate;
    data['modified_date'] = modifiedDate;
    data['playername'] = playerName;
    data['player_image'] = playerImage;
    data['designation_id'] = designationId;
    data['designation_name'] = designationName;
    data['teamname'] = teamName;
    data['teamshortname'] = teamShortName;
    data['sportsmonk_pid'] = sportsMonkPid;
    data['playigstatus'] = playingStatus;
    data['played_last_match'] = playedLastMatch;
    data['c_by'] = cBy;
    data['vc_by'] = vcBy;
    return data;
  }
}
