class MyContestLeaderBoardModel {
  int? id;
  dynamic gameid;
  dynamic matchId;
  dynamic userid;
  dynamic teamName;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic allPoint;
  dynamic ranks;
  dynamic username;
  dynamic winingZone;
  dynamic userimage;
  dynamic matchstatus;
  dynamic winningNote;
  dynamic winP;

  MyContestLeaderBoardModel(
      {this.id,
        this.gameid,
        this.matchId,
        this.userid,
        this.teamName,
        this.createdAt,
        this.updatedAt,
        this.allPoint,
        this.ranks,
        this.username,
        this.winingZone,
        this.userimage,
        this.matchstatus,
        this.winningNote,
        this.winP,
      });

  MyContestLeaderBoardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameid = json['gameid'];
    matchId = json['match_id'];
    userid = json['userid'];
    teamName = json['team_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    allPoint = json['all_point'];
    ranks = json['ranks'];
    username = json['username'];
    winingZone = json['wining_zone'];
    userimage = json['userimage'];
    matchstatus = json['matchstatus'];
    winningNote = json['winning_note'];
    winP = json['winp'];
  }
}




