class LiveTeamPreviewModel {
  int? id;
  int? matchid;
  int? myTeamid;
  int? playerid;
  int? sportsmonkPid;
  String? designationName;
  int? isCaptain;
  int? isViceCaptain;
  int? teamid;
  String? totalPoint;
  String? battingPoint;
  String? bollingPoint;
  String? fieldingPoint;
  String? playingPoint;
  String? createdAt;
  String? updatedAt;
  String? playerName;
  String? playerImage;
  String? teamname;
  String? selBy;
  String? cBy;
  String? vcBy;

  LiveTeamPreviewModel(
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

  LiveTeamPreviewModel.fromJson(Map<String, dynamic> json) {
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
}
