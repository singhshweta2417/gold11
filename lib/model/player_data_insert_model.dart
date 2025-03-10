class PlayerDataInsertModel {
  String? id;
  String? playerId;
  String? sportsMonkPid;
  String? isCaptain;
  String? isViceCaptain;
  String? designationName;
  String? teamId;

  PlayerDataInsertModel({
    this.id,
    this.playerId,
    this.sportsMonkPid,
    this.isCaptain,
    this.isViceCaptain,
    this.designationName,
    this.teamId,
  });

  PlayerDataInsertModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playerId = json['playerid'];
    sportsMonkPid = json['sportsmonk_pid'];
    isCaptain = json['is_captain'];
    isViceCaptain = json['is_vice_captain'];
    designationName = json['designation_name'];
    teamId = json['teamid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['playerid'] = playerId;
    data['sportsmonk_pid'] = sportsMonkPid;
    data['is_captain'] = isCaptain;
    data['is_vice_captain'] = isViceCaptain;
    data['designation_name'] = designationName;
    data['teamid'] = teamId;
    return data;
  }
}
