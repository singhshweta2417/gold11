import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gold11/model/game_data_model.dart';
import 'package:gold11/new_pages_by_harsh/all_player_view.dart';
import 'package:gold11/new_pages_by_harsh/model/sate_model.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/app_url_const.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:provider/provider.dart';

class LiveStats extends StatefulWidget {
  final GameData data;
  const LiveStats({super.key, required this.data});

  @override
  State<LiveStats> createState() => _LiveStatsState();
}

class _LiveStatsState extends State<LiveStats> {
  int selectedHighlight = 0;
  String? selectedHighlightTeam;
  List<TeamsData> teamsData = [];
  List<MatchPlayer> matchPlayerData = [];



  @override
  void initState() {
    super.initState();
    teamStatesData();
  }

  Future<void> teamStatesData() async {
    final userToken =
        Provider.of<SharedPrefViewModel>(context, listen: false).userToken;
    final  matchId = widget.data.id.toString();
    final  gameId = widget.data.gameId.toString();
    final response = await http.get(
      Uri.parse('${AppApiUrls.getLiveTeamState}$gameId/$userToken/$matchId'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> responseData = data['teams'];
      final List<dynamic> matchPlayers = data['match_player'];
      final List<TeamsData> loadedTeams =
          responseData.map((item) => TeamsData.fromJson(item)).toList();
      final List<MatchPlayer> matchPlayer =
          matchPlayers.map((item) => MatchPlayer.fromJson(item)).toList();
      setState(() {
        teamsData = loadedTeams;
        matchPlayerData = matchPlayer;
        selectedHighlightTeam = teamsData[selectedHighlight].teamName ?? "";
      });
    } else {
      if (response.statusCode == 400 && kDebugMode) {
      }
      setState(() {
        teamsData = [];
        matchPlayerData = [];
      });
      throw Exception('Failed to load data');
    }
  }
  Future<void> _refreshMatches() async {
    teamStatesData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      RefreshIndicator(
        color: Colors.white,
        backgroundColor: AppColor.primaryRedColor,
        strokeWidth: 4.0,
        onRefresh: _refreshMatches,
        child: teamsData.isEmpty?const Center(child: CircularProgressIndicator()):
        Column(
          children: [
            _buildExpansionTile(),

                _buildPlayerStats()

          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile() {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextConst(
            text: "Players start at match level",
            fontWeight: FontWeight.w500,
            textColor: AppColor.textGreyColor,
            fontSize: 12,
          ),
          TextConst(
            text: "Highlight $selectedHighlightTeam",
            fontWeight: FontWeight.w600,
            textColor: AppColor.textGreyColor,
            fontSize: Sizes.fontSizeTwo,
          ),
        ],
      ),
      children: [
        SizedBox(
          height: Sizes.screenHeight * 0.06,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: teamsData.length,
            itemBuilder: (_, int i) {
              return _buildTeamHighlight(i);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTeamHighlight(int index) {
    final team = teamsData[index];
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedHighlight = index;
            selectedHighlightTeam = teamsData[index].teamName ?? '';
          });
        },
        child: ContainerConst(
          height: 40,
          width: Sizes.screenWidth * 0.2,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: selectedHighlight == index
                ? AppColor.blackColor
                : AppColor.textGreyColor,
          ),
          color: selectedHighlight == index
              ? AppColor.blackColor
              : Colors.transparent,
          child: Column(
            children: [
              TextConst(
                text: team.teamName ?? "",
                fontWeight: FontWeight.w600,
                textColor: selectedHighlight == index
                    ? AppColor.whiteColor
                    : AppColor.textGreyColor,
                fontSize: Sizes.fontSizeTwo,
              ),
              TextConst(
                text: "${team.allPoint ?? 0} Pts",
                textColor: selectedHighlight == index
                    ? AppColor.whiteColor
                    : AppColor.textGreyColor,
                fontSize: Sizes.fontSizeOne,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerStats() {
    return Expanded(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPlayerList(),
              _buildPlayerStatsDetails(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerList() {
    return ContainerConst(
      width: Sizes.screenWidth * 0.5,
      child: Column(
        children: [
          ContainerConst(
            height: 40,
            border: Border.all(
              width: 1,
              color: AppColor.scaffoldBackgroundColor,
            ),
            child: TextConst(
              alignment: Alignment.centerLeft,
              width: 180,
              text: "Players".toUpperCase(),
              fontWeight: FontWeight.w500,
              textColor: AppColor.textGreyColor,
            ),
          ),
          Column(
            children: List.generate(
              matchPlayerData.length,
              (index) {
                return _buildPlayerItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsHeader() {
    return ContainerConst(
      width: Sizes.screenWidth * 0.7,
      height: 40,
      border: Border.all(
        width: 1,
        color: AppColor.scaffoldBackgroundColor,
      ),
      child: Row(
        children: [
          TextConst(
            text: "Points ↓ ".toUpperCase(),
            fontWeight: FontWeight.w500,
            width: 65,
          ),
          const TextConst(
            text: "% SEL BY",
            width: 65,
            textColor: AppColor.textGreyColor,
          ),
          const TextConst(
            text: "% C BY",
            width: 65,
            textColor: AppColor.textGreyColor,
          ),
          const TextConst(
            text: "% VC BY",
            width: 65,
            textColor: AppColor.textGreyColor,
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerItem(int index) {
    if (index >= matchPlayerData.length ||
        teamsData.isEmpty ||
        selectedHighlight >= teamsData.length ||
        teamsData[selectedHighlight].playerlist == null) {
      return const SizedBox.shrink();
    }

    final matchPlayer = matchPlayerData[index];
    final teamPlayerList = teamsData[selectedHighlight].playerlist!;

    final isMatchingPlayer = teamPlayerList.any(
      (teamPlayer) => teamPlayer.playerid == matchPlayer.playerid,
    );

    final matchingPlayer = teamPlayerList.firstWhere(
        (player) => player.playerid == matchPlayer.playerid,
        orElse: () =>
            Playerlist()
        );

    bool isCaptain = matchingPlayer.isCaptain == 1;
    bool isViceCaptain = matchingPlayer.isViceCaptain == 1;

    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllPlayerView(
              matchId: matchPlayer.matchid.toString(),
              playerId: matchPlayer.playerid.toString(),
              teamId: matchPlayer.id.toString(),
              matchType: '1',
            ),
          ),
        );
      },
      child: Container(
        height: Sizes.screenHeight * 0.06,
        color: isMatchingPlayer
            ? Colors.orange.withOpacity(0.1)
            : Colors.transparent,
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ContainerConst(
                  height: 40,
                  width: 40,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(matchPlayer.playerimage ?? ""),
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                  ),
                ),
                if (isCaptain || isViceCaptain)
                  Positioned(
                    top: -5,
                    right: -8,
                    child: ContainerConst(
                      width: MediaQuery.of(context).size.width / 20,
                      padding: const EdgeInsets.all(1),
                      border: Border.all(
                        color: isMatchingPlayer
                            ? AppColor.whiteColor
                            : AppColor.textGreyColor,
                        width: 1.5,
                      ),
                      shape: BoxShape.circle,
                      color: isMatchingPlayer
                          ? AppColor.textGreyColor
                          : AppColor.whiteColor,
                      child: TextConst(
                        text: isCaptain ? "C" : 'VC',
                        textColor: isMatchingPlayer
                            ? AppColor.whiteColor
                            : AppColor.textGreyColor,
                        fontSize: 8,
                      ),
                    ),
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 130,
                  child: TextConst(
                    alignment: Alignment.bottomLeft,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: matchPlayer.playername ?? "Unknown Player",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextConst(
                  text:
                      "${matchPlayer.teamname ?? "Unknown Team"} - ${matchPlayer.designationName ?? ""}",
                  textColor: AppColor.textGreyColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerStatsDetails() {
    return ContainerConst(
      width: Sizes.screenWidth * 0.5,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            _buildStatsHeader(),
            Column(
              children: List.generate(
                  matchPlayerData.length, (index) {
                return _buildPlayerStatsRow(index);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerStatsRow(int index) {
    if (index >= matchPlayerData.length ||
        teamsData.isEmpty ||
        selectedHighlight >= teamsData.length ||
        teamsData[selectedHighlight].playerlist == null) {
      return const SizedBox.shrink();
    }

    final matchPlayer = matchPlayerData[index];
    final teamPlayerList = teamsData[selectedHighlight].playerlist!;

    final isMatchingPlayer = teamPlayerList.any(
          (teamPlayer) => teamPlayer.playerid == matchPlayer.playerid,
    );

    final points = isMatchingPlayer
        ? teamPlayerList.firstWhere(
            (teamPlayer) => teamPlayer.playerid == matchPlayer.playerid,
        orElse: () => Playerlist())
        .totalPoint
        : matchPlayer.totalPoint;
    final selBy = isMatchingPlayer
        ? "${teamPlayerList.firstWhere(
            (teamPlayer) => teamPlayer.playerid == matchPlayer.playerid,
        orElse: () => Playerlist())
        .selBy ?? "0"}%"
        : '${matchPlayer.selBy}%';

    final cBy = isMatchingPlayer
        ? "${teamPlayerList.firstWhere(
            (teamPlayer) => teamPlayer.playerid == matchPlayer.playerid,
        orElse: () => Playerlist())
        .cBy ?? "0"}"
        : matchPlayer.cBy ?? "0";

    final vcBy = isMatchingPlayer
        ? "${teamPlayerList.firstWhere(
            (teamPlayer) => teamPlayer.playerid == matchPlayer.playerid,
        orElse: () => Playerlist())
        .vcBy ?? "0"}"
        : matchPlayer.vcBy ?? "0";

    return Container(
      color: isMatchingPlayer
          ? Colors.orange.withOpacity(0.1)
          : AppColor.whiteColor,
      height: Sizes.screenHeight * 0.06,
      width: Sizes.screenWidth * 0.7,
      child: Row(
        children: [
          TextConst(
            text: points ?? "0",
            width: 65,
            textColor: AppColor.blackColor,
          ),
          TextConst(
            text: selBy,
            textColor: AppColor.textGreyColor,
            width: 65,
          ),
          TextConst(
            text: cBy,
            textColor: AppColor.blackColor,
            width: 65,
          ),
          TextConst(
            text: vcBy,
            textColor: AppColor.textGreyColor,
            width: 65,
          ),
        ],
      ),
    );
  }

}
