
class MyLiveContest {
  dynamic id;
  dynamic gameId;
  dynamic myMatchId;
  dynamic userId;
  dynamic contestId;
  dynamic myTeamId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic name;
  dynamic type;
  dynamic entryFee;
  dynamic totalSpot;
  dynamic entryCount;
  dynamic prizePool;
  dynamic contestSuccessType;
  dynamic firstPrize;
  dynamic entryLimit;
  dynamic numOfJoinedTeam;
  dynamic teamNames;
  dynamic myTeamIdList;
  dynamic matchstatus;
  List<LiveTeams>? teamsData;

  MyLiveContest({
    this.id,
    this.gameId,
    this.myMatchId,
    this.userId,
    this.contestId,
    this.myTeamId,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.type,
    this.entryFee,
    this.totalSpot,
    this.entryCount,
    this.prizePool,
    this.contestSuccessType,
    this.firstPrize,
    this.entryLimit,
    this.numOfJoinedTeam,
    this.teamNames,
    this.myTeamIdList,
    this.teamsData,
    this.matchstatus,
  });

  MyLiveContest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameId = json['gameid'];
    myMatchId = json['my_match_id'];
    userId = json['user_id'];
    contestId = json['contest_id'];
    myTeamId = json['my_teamid'];
    createdAt = json['ceated_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    type = json['type'];
    entryFee = json['entry_fee'];
    totalSpot = json['total_spot'];
    entryCount = json['entry_count'];
    prizePool = json['prize_pool'];
    contestSuccessType = json['contest_success_type'];
    firstPrize = json['first_prize'];
    entryLimit = json['entry_limit'];
    numOfJoinedTeam = json['num_of_joined_team'];
    teamNames = json['team_names'];
    myTeamIdList = json['my_team_id'];
    matchstatus = json['matchstatus'];

    if (json['teams'] != null) {
      teamsData = <LiveTeams>[];
      json['teams'].forEach((v) {
        teamsData!.add(LiveTeams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gameid'] = gameId;
    data['my_match_id'] = myMatchId;
    data['user_id'] = userId;
    data['contest_id'] = contestId;
    data['my_teamid'] = myTeamId;
    data['ceated_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['type'] = type;
    data['entry_fee'] = entryFee;
    data['total_spot'] = totalSpot;
    data['entry_count'] = entryCount;
    data['prize_pool'] = prizePool;
    data['contest_success_type'] = contestSuccessType;
    data['first_prize'] = firstPrize;
    data['entry_limit'] = entryLimit;
    data['num_of_joined_team'] = numOfJoinedTeam;
    data['team_names'] = teamNames;
    data['my_team_id'] = myTeamIdList;
    data['matchstatus'] = matchstatus;
    if (teamsData != null) {
      data['teams'] = teamsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class LiveTeams {
  dynamic id;
  dynamic gameId;
  dynamic matchId;
  dynamic userId;
  dynamic teamName;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic allPoint;
  dynamic ranks;
  dynamic username;
  dynamic winningNote;
  dynamic winingZone;
  dynamic winp;
  dynamic matchstatus;

  LiveTeams({
    this.id,
    this.gameId,
    this.matchId,
    this.userId,
    this.teamName,
    this.createdAt,
    this.updatedAt,
    this.allPoint,
    this.ranks,
    this.username,
    this.winningNote,
    this.winingZone,
    this.winp,
    this.matchstatus,
  });

  LiveTeams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameId = json['gameid'];
    matchId = json['match_id'];
    userId = json['userid'];
    teamName = json['team_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    allPoint = json['all_point'];
    ranks = json['ranks'];
    username = json['username'];
    winningNote = json['winning_note'];
    winingZone = json['wining_zone'];
    winp = json['winp'];
    matchstatus = json['matchstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gameid'] = gameId;
    data['match_id'] = matchId;
    data['userid'] = userId;
    data['team_name'] = teamName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['all_point'] = allPoint;
    data['ranks'] = ranks;
    data['username'] = username;
    data['winning_note'] = winningNote;
    data['wining_zone'] = winingZone;
    data['winp'] = winp;
    data['matchstatus'] = matchstatus;
    return data;
  }
}