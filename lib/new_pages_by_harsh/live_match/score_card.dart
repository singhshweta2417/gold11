import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/model/game_data_model.dart';
import 'package:gold11/new_pages_by_harsh/all_player_view.dart';
import 'package:gold11/new_pages_by_harsh/model/score_card_model.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/app_url_const.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:http/http.dart' as http;

class ScorecardPage extends StatefulWidget {
  final GameData data;
  const ScorecardPage({super.key, required this.data});

  @override
  State<ScorecardPage> createState() => _ScorecardPageState();
}

class _ScorecardPageState extends State<ScorecardPage> {
  int? selectedIndex;
  int selectedHighlight = 0;
  @override
  void initState() {
    super.initState();
    getTeamsApi();
  }

  String selectedHighlightTeam = '';
  int? responseStatusCode;
  List<Teams> teams = [];
  List<MatchPlayer> homeScoreBoard = [];
  List<MatchPlayer> visitorScoreBoard = [];
  List<WicketFall> homeFallWicket = [];
  List<WicketFall> visitorFallWicket = [];
  String homeTeamName = '';
  String homeTeamScore = '';
  String homeTeamOvers = '';
  String homeTeamTotalExtra = '';
  String homeTeamExtra = '0.0';
  String homeTeamTotalScore = '0.0';
  String homeTeamTotalWickets = '0.0';

  String visitorTeamName = '';
  String visitorTeamScore = '';
  String visitorTeamOvers = '';
  String visitorTeamTotalExtra = '0.0';
  String visitorTeamExtra = '0.0';
  String visitorTotalScore = '0.0';
  String visitorTeamTotalWickets = '0.0';

  String matchStatus = '';

  Future<void> getTeamsApi() async {
    final userToken =
        Provider.of<SharedPrefViewModel>(context, listen: false).userToken;
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};
    final body = jsonEncode({
      "userid": userToken,
      "gameid": widget.data.gameId.toString(),
      "matchid": widget.data.id.toString(),
    });

    debugPrint('Request Body: $body');
    try {
      final response = await http.post(
        Uri.parse(AppApiUrls.scoreboards),
        headers: headers,
        body: body,
      );

      debugPrint('API Endpoint: ${AppApiUrls.scoreboards}');
      debugPrint('Response Status Code: ${response.statusCode}');
      setState(() {
        responseStatusCode = response.statusCode;
      });
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        matchStatus = responseBody['data']['matchstatus'];
        final List<dynamic> responseData = responseBody['data']['teams'];
        final List<dynamic> homeTeamData =
            responseBody['data']['home_score_board']['match_player'];
        final List<dynamic> visitorTeamData =
            responseBody['data']['visitor_score_board']['match_player'];
        final List<dynamic> homeTeamWicketFall =
            responseBody['data']['home_score_board']['wicket_fall'];
        final List<dynamic> visitorTeamWicketFall =
            responseBody['data']['visitor_score_board']['wicket_fall'];
        final Map<String, dynamic> homeData =
            responseBody['data']['home_score_board'];
        final Map<String, dynamic> visitorData =
            responseBody['data']['visitor_score_board'];
        homeTeamName = homeData['name'].toString();
        homeTeamScore = homeData['score'].toString();
        homeTeamOvers = homeData['overs'].toString();
        homeTeamTotalExtra = homeData['extra_details'].toString();
        homeTeamExtra = homeData['extra_total'].toString();
        homeTeamTotalScore = homeData['total_score'].toString();
        homeTeamTotalWickets = homeData['total_wickets'].toString();
        visitorTeamName = visitorData['name'].toString();
        visitorTeamScore = visitorData['score'].toString();
        visitorTeamOvers = visitorData['overs'].toString();
        visitorTeamTotalExtra = visitorData['extra_details'].toString();
        visitorTeamExtra = visitorData['extra_total'].toString();
        visitorTotalScore = visitorData['total_score'].toString();
        visitorTeamTotalWickets = visitorData['total_wickets'].toString();

        setState(() {
          matchStatus;
          teams = responseData.map((item) => Teams.fromJson(item)).toList();
          homeScoreBoard =
              homeTeamData.map((item) => MatchPlayer.fromJson(item)).toList();
          visitorScoreBoard = visitorTeamData
              .map((item) => MatchPlayer.fromJson(item))
              .toList();
          homeFallWicket = homeTeamWicketFall
              .map((item) => WicketFall.fromJson(item))
              .toList();
          visitorFallWicket = visitorTeamWicketFall
              .map((item) => WicketFall.fromJson(item))
              .toList();

          selectedHighlightTeam = teams[selectedHighlight].teamName ?? "";
        });
        debugPrint('Home Data: ${jsonEncode(homeData)}');
        debugPrint('matchStatus: $matchStatus');
        debugPrint('Home Team Score: $homeTeamScore');
        debugPrint('Home Team Overs: $homeTeamOvers');
        debugPrint('Home Team data: $homeTeamData');
        debugPrint('visitor Team data: $visitorTeamData');
      } else {
        setState(() {
          teams = [];
          homeScoreBoard = [];
          visitorScoreBoard = [];
        });

        if (response.statusCode == 400) {
          debugPrint('Data not found');
        } else {
          throw Exception(
              'Failed to load teams data. Status Code: ${response.statusCode}');
        }
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
      setState(() {
        teams = [];
        homeScoreBoard = [];
        visitorScoreBoard = [];
      });
    }
  }

  Future<void> _refreshMatches() async {
    getTeamsApi();
  }

  bool isFirstTileOpen = false;
  bool isSecondTileOpen = false;
  void _toggleExpansion(int index) {
    setState(() {
      if (index == 0) {
        isFirstTileOpen = !isFirstTileOpen;
        isSecondTileOpen = false; // Close second tile when the first opens
      } else {
        isSecondTileOpen = !isSecondTileOpen;
        isFirstTileOpen = false; // Close first tile when the second opens
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: Sizes.screenHeight * 0.05,
        width: Sizes.screenWidth,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            children: [
              Container(
                height: Sizes.screenHeight * 0.03,
                width: Sizes.screenWidth * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.orange.withOpacity(0.1),
                ),
                child: const TextConst(
                  text: 'Players In Your Team - In This Match',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  alignment: Alignment.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: AppColor.primaryRedColor,
        strokeWidth: 4.0,
        onRefresh: _refreshMatches,
        child: teams.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                // shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      ContainerConst(
                        onTap: () {},
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, top: 10, bottom: 18),
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: AppColor.scaffoldBackgroundColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Sizes.spaceWidth15,
                            TextConst(
                              text: "Highlight $selectedHighlightTeam",
                              fontWeight: FontWeight.w600,
                              textColor: AppColor.textGreyColor,
                              fontSize: Sizes.fontSizeThree,
                            ),
                            Sizes.spaceWidth25,
                            SizedBox(
                              height: Sizes.screenHeight * 0.06,
                              width: Sizes.screenWidth * 0.57,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: teams.length,
                                itemBuilder: (_, int i) {
                                  final data = teams[i];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedHighlight = i;
                                          selectedHighlightTeam =
                                              teams[i].teamName ?? '';
                                        });
                                      },
                                      child: ContainerConst(
                                        height: 40,
                                        width: Sizes.screenWidth * 0.2,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: selectedHighlight == i
                                              ? AppColor.activeButtonGreenColor
                                              : AppColor.textGreyColor,
                                        ),
                                        color: selectedHighlight == i
                                            ? AppColor.activeButtonGreenColor
                                                .withOpacity(0.05)
                                            : Colors.transparent,
                                        child: Column(
                                          children: [
                                            TextConst(
                                              text: data.teamName.toString(),
                                              fontWeight: FontWeight.w600,
                                              textColor: selectedHighlight == i
                                                  ? AppColor
                                                      .activeButtonGreenColor
                                                  : AppColor.textGreyColor,
                                              fontSize: Sizes.fontSizeTwo,
                                            ),
                                            TextConst(
                                              text: '${data.allPoint} pts',
                                              textColor: selectedHighlight == i
                                                  ? AppColor
                                                      .activeButtonGreenColor
                                                  : AppColor.textGreyColor,
                                              fontSize: Sizes.fontSizeOne,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      children: [
                        homeTeamOvers == '0'
                            ? const SizedBox.shrink()
                            : ContainerConst(
                                border: Border.all(
                                  color: Colors.orange.withOpacity(0.3),
                                ),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    dividerColor: Colors
                                        .transparent, // Remove the default border
                                  ),
                                  child: ExpansionTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Sizes.spaceWidth5,
                                        TextConst(
                                          width: 180,
                                          alignment: Alignment.centerLeft,
                                          text: homeTeamName
                                              .toString()
                                              .toUpperCase(),
                                          fontWeight: FontWeight.w700,
                                          textColor: AppColor.blackColor,
                                          fontSize: Sizes.fontSizeThree,
                                        ),
                                        TextConst(
                                          text: "(${homeTeamOvers.toString()})",
                                          fontWeight: FontWeight.w500,
                                          textColor: AppColor.textGreyColor,
                                        ),
                                        TextConst(
                                          text: homeTeamScore.toString(),
                                          width: 60,
                                          textColor: AppColor.blackColor,
                                          fontSize: Sizes.fontSizeThree,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                    tilePadding: EdgeInsets.zero,
                                    onExpansionChanged: (bool expanded) {
                                      _toggleExpansion(0);
                                    },
                                    initiallyExpanded: isFirstTileOpen,
                                    collapsedBackgroundColor:
                                        Colors.orange.withOpacity(0.1),
                                    backgroundColor: Colors.white,
                                    children: [
                                      ContainerConst(
                                        height: Sizes.screenHeight * 0.055,
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 1,
                                            color: AppColor.textGreyColor
                                                .withOpacity(0.1),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Sizes.spaceWidth5,
                                            TextConst(
                                              width: 170,
                                              alignment: Alignment.centerLeft,
                                              text: "Batter",
                                              fontWeight: FontWeight.w700,
                                              textColor: AppColor.textGreyColor,
                                              fontSize: Sizes.fontSizeTwo,
                                            ),
                                            TextConst(
                                              width: 20,
                                              text: "r".toUpperCase(),
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColor.textGreyColor,
                                            ),
                                            TextConst(
                                              width: 20,
                                              text: "b".toUpperCase(),
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColor.textGreyColor,
                                            ),
                                            TextConst(
                                              width: 20,
                                              text: "4s".toUpperCase(),
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColor.textGreyColor,
                                            ),
                                            TextConst(
                                              width: 20,
                                              text: "6s".toUpperCase(),
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColor.textGreyColor,
                                            ),
                                            TextConst(
                                              text: "s/r".toUpperCase(),
                                              width: 50,
                                              textColor: AppColor.textGreyColor,
                                              fontSize: Sizes.fontSizeTwo,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            Sizes.spaceWidth5,
                                          ],
                                        ),
                                      ),
                                      // Batters and Bowlers Sections
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: homeScoreBoard
                                              .where((data) => data.isBat == 1)
                                              .length,
                                          itemBuilder: (_, int index) {
                                            // Extract the sorted batter data
                                            final sortedBatters = homeScoreBoard
                                                .where(
                                                    (data) => data.isBat == 1)
                                                .toList()
                                              ..sort((a, b) => a.battingOrder
                                                  .compareTo(b.battingOrder));

                                            final batter = sortedBatters[index];

                                            // Get the playerlist for the selected team
                                            final playerlist =
                                                teams.isNotEmpty &&
                                                        teams.length >
                                                            selectedHighlight
                                                    ? teams[selectedHighlight]
                                                        .playerlist
                                                    : [];

                                            final selectedTeamPlayerIds =
                                                playerlist!
                                                    .map((player) =>
                                                        player.playerid)
                                                    .toList();

                                            final isMatchingPlayer =
                                                selectedTeamPlayerIds
                                                    .contains(batter.playerid);

                                            // Check if the batter is a captain or vice-captain
                                            final isCaptain = playerlist.any(
                                                (player) =>
                                                    player.playerid ==
                                                        batter.playerid &&
                                                    player.isCaptain == 1);
                                            final isViceCaptain =
                                                playerlist.any((player) =>
                                                    player.playerid ==
                                                        batter.playerid &&
                                                    player.isViceCaptain == 1);
                                            final homeTeamO = homeTeamOvers;
                                            final visitorTeamO =
                                                visitorTeamOvers;
                                            final teamOver = visitorTeamOvers;
                                            return batterData(
                                                batter,
                                                isMatchingPlayer,
                                                isCaptain,
                                                isViceCaptain,
                                                homeTeamO,
                                                visitorTeamO,
                                                teamOver);
                                          },
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 1.5, bottom: 1.5),
                                        child: ContainerConst(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 7),
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                              color: AppColor
                                                  .scaffoldBackgroundColor,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  TextConst(
                                                    width: 200,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    text: "EXTRAS",
                                                    fontWeight: FontWeight.w300,
                                                    textColor:
                                                        AppColor.blackColor,
                                                    fontSize:
                                                        Sizes.fontSizeThree,
                                                  ),
                                                  TextConst(
                                                    width: 200,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    text: homeTeamTotalExtra
                                                        .toString(),
                                                    fontWeight: FontWeight.w200,
                                                    textColor:
                                                        AppColor.blackColor,
                                                    fontSize: Sizes.fontSizeOne,
                                                  ),
                                                ],
                                              ),
                                              TextConst(
                                                alignment: Alignment.centerLeft,
                                                text: homeTeamExtra.toString(),
                                                fontWeight: FontWeight.w700,
                                                textColor: AppColor.blackColor,
                                                fontSize: Sizes.fontSizeThree,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 1.5, bottom: 1.5),
                                        child: ContainerConst(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 7),
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                              color: AppColor
                                                  .scaffoldBackgroundColor,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  TextConst(
                                                    width: 200,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    text: "TOTAL",
                                                    fontWeight: FontWeight.w600,
                                                    textColor:
                                                        AppColor.blackColor,
                                                    fontSize:
                                                        Sizes.fontSizeThree,
                                                  ),
                                                  TextConst(
                                                    width: 200,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    text:
                                                        '($homeTeamTotalWickets wicket, $homeTeamOvers overs)',
                                                    fontWeight: FontWeight.w200,
                                                    textColor:
                                                        AppColor.blackColor,
                                                    fontSize: Sizes.fontSizeOne,
                                                  ),
                                                ],
                                              ),
                                              TextConst(
                                                alignment: Alignment.centerLeft,
                                                text: homeTeamTotalScore
                                                    .toString(),
                                                fontWeight: FontWeight.w700,
                                                textColor: AppColor.blackColor,
                                                fontSize: Sizes.fontSizeThree,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Sizes.spaceHeight15,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Sizes.spaceWidth15,
                                          TextConst(
                                            width: 170,
                                            alignment: Alignment.centerLeft,
                                            text: "Did Not Bat",
                                            fontWeight: FontWeight.w700,
                                            textColor: AppColor.textGreyColor,
                                            fontSize: Sizes.fontSizeTwo,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: homeScoreBoard
                                              .where((data) => data.isBat == 0)
                                              .length,
                                          itemBuilder: (_, int i) {
                                            final batter = homeScoreBoard
                                                .where(
                                                    (data) => data.isBat == 0)
                                                .toList()[i];
                                            // Get the single player ID from the corresponding team
                                            final playerlist =
                                                teams.isNotEmpty &&
                                                        teams.length >
                                                            selectedHighlight
                                                    ? teams[selectedHighlight]
                                                        .playerlist
                                                    : [];

                                            final selectedTeamPlayerIds =
                                                playerlist!
                                                    .map((player) =>
                                                        player.playerid)
                                                    .toList();

                                            final isMatchingPlayer =
                                                selectedTeamPlayerIds
                                                    .contains(batter.playerid);
                                            // Check if the batter is a captain or vice-captain
                                            final isCaptain = playerlist.any(
                                                (player) =>
                                                    player.playerid ==
                                                        batter.playerid &&
                                                    player.isCaptain == 1);
                                            final isViceCaptain =
                                                playerlist.any((player) =>
                                                    player.playerid ==
                                                        batter.playerid &&
                                                    player.isViceCaptain == 1);

                                            return didNotBat(
                                                batter,
                                                isMatchingPlayer,
                                                isCaptain,
                                                isViceCaptain);
                                          },
                                        ),
                                      ),
                                      // Bowlers Section
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ContainerConst(
                                              height:
                                                  Sizes.screenHeight * 0.055,
                                              border: Border(
                                                bottom: BorderSide(
                                                  width: 1,
                                                  color: AppColor.textGreyColor
                                                      .withOpacity(0.1),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Sizes.spaceWidth5,
                                                  TextConst(
                                                    width: 170,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    text: "Bowler",
                                                    fontWeight: FontWeight.w700,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                    fontSize: Sizes.fontSizeTwo,
                                                  ),
                                                  TextConst(
                                                    width: 20,
                                                    text: "O".toUpperCase(),
                                                    fontWeight: FontWeight.w500,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                  ),
                                                  TextConst(
                                                    width: 20,
                                                    text: "M".toUpperCase(),
                                                    fontWeight: FontWeight.w500,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                  ),
                                                  TextConst(
                                                    width: 20,
                                                    text: "R".toUpperCase(),
                                                    fontWeight: FontWeight.w500,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                  ),
                                                  TextConst(
                                                    width: 20,
                                                    text: "W".toUpperCase(),
                                                    fontWeight: FontWeight.w500,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                  ),
                                                  TextConst(
                                                    text: "Eco".toUpperCase(),
                                                    width: 50,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                    fontSize: Sizes.fontSizeTwo,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  Sizes.spaceWidth5,
                                                ],
                                              ),
                                            ),
                                            // Bowlers List
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: visitorScoreBoard
                                                  .where((data) =>
                                                      data.isBowl == 1)
                                                  .length,
                                              itemBuilder: (_, int i) {
                                                final sortedBatters =
                                                    visitorScoreBoard
                                                        .where((data) =>
                                                            data.isBowl == 1)
                                                        .toList()
                                                      ..sort((a, b) => a
                                                          .bollingOrder
                                                          .compareTo(
                                                              b.bollingOrder));

                                                final bowler = sortedBatters[i];
                                                final playerlist = teams
                                                            .isNotEmpty &&
                                                        teams.length >
                                                            selectedHighlight
                                                    ? teams[selectedHighlight]
                                                        .playerlist
                                                    : [];
                                                final selectedTeamPlayerIds =
                                                    playerlist!
                                                        .map((player) =>
                                                            player.playerid)
                                                        .toList();

                                                final isMatchingPlayer =
                                                    selectedTeamPlayerIds
                                                        .contains(
                                                            bowler.playerid);

                                                // Check if the batter is a captain or vice-captain
                                                final isCaptain =
                                                    playerlist.any((player) =>
                                                        player.playerid ==
                                                            bowler.playerid &&
                                                        player.isCaptain == 1);
                                                final isViceCaptain =
                                                    playerlist.any((player) =>
                                                        player.playerid ==
                                                            bowler.playerid &&
                                                        player.isViceCaptain ==
                                                            1);
                                                return bowlerData(
                                                    bowler,
                                                    isMatchingPlayer,
                                                    isCaptain,
                                                    isViceCaptain);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ContainerConst(
                                              height:
                                                  Sizes.screenHeight * 0.055,
                                              border: Border(
                                                bottom: BorderSide(
                                                  width: 1,
                                                  color: AppColor.textGreyColor
                                                      .withOpacity(0.1),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Sizes.spaceWidth15,
                                                  TextConst(
                                                    width: 170,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    text: "Fall of Wickets",
                                                    fontWeight: FontWeight.w700,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                    fontSize: Sizes.fontSizeTwo,
                                                  ),
                                                  const Spacer(),
                                                  TextConst(
                                                    text: "Score".toUpperCase(),
                                                    fontWeight: FontWeight.w500,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                  ),
                                                  Sizes.spaceWidth15,
                                                  TextConst(
                                                    text: "Over".toUpperCase(),
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                    fontSize: Sizes.fontSizeTwo,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  Sizes.spaceWidth10,
                                                ],
                                              ),
                                            ),
                                            // Bowlers List
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: homeFallWicket.length,
                                              itemBuilder: (_, int i) {
                                                final fallWicketData =
                                                    homeFallWicket[i];
                                                return fallWicket(
                                                    fallWicketData);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        visitorTeamOvers == '0'
                            ? const SizedBox.shrink()
                            : ContainerConst(
                                border: Border.all(
                                  color:
                                      AppColor.textGreyColor.withOpacity(0.1),
                                ),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    dividerColor: Colors.transparent,
                                  ),
                                  child: ExpansionTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Sizes.spaceWidth5,
                                        TextConst(
                                          width: 180,
                                          alignment: Alignment.centerLeft,
                                          text: visitorTeamName
                                              .toString()
                                              .toUpperCase(),
                                          fontWeight: FontWeight.w700,
                                          textColor: AppColor.blackColor,
                                          fontSize: Sizes.fontSizeThree,
                                        ),
                                        TextConst(
                                          text:
                                              "(${visitorTeamOvers.toString()})",
                                          fontWeight: FontWeight.w500,
                                          textColor: AppColor.textGreyColor,
                                        ),
                                        TextConst(
                                          text: visitorTeamScore.toString(),
                                          width: 60,
                                          textColor: AppColor.blackColor,
                                          fontSize: Sizes.fontSizeThree,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                    onExpansionChanged: (bool expanded) {
                                      _toggleExpansion(1);
                                    },
                                    initiallyExpanded: isSecondTileOpen,
                                    tilePadding: EdgeInsets.zero,
                                    collapsedBackgroundColor:
                                        Colors.grey.withOpacity(0.1),
                                    backgroundColor: Colors.white,
                                    children: [
                                      ContainerConst(
                                        height: Sizes.screenHeight * 0.055,
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 1,
                                            color: AppColor.textGreyColor
                                                .withOpacity(0.1),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Sizes.spaceWidth5,
                                            TextConst(
                                              width: 170,
                                              alignment: Alignment.centerLeft,
                                              text: "Batter",
                                              fontWeight: FontWeight.w700,
                                              textColor: AppColor.textGreyColor,
                                              fontSize: Sizes.fontSizeTwo,
                                            ),
                                            TextConst(
                                              width: 20,
                                              text: "r".toUpperCase(),
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColor.textGreyColor,
                                            ),
                                            TextConst(
                                              width: 20,
                                              text: "b".toUpperCase(),
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColor.textGreyColor,
                                            ),
                                            TextConst(
                                              width: 20,
                                              text: "4s".toUpperCase(),
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColor.textGreyColor,
                                            ),
                                            TextConst(
                                              width: 20,
                                              text: "6s".toUpperCase(),
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColor.textGreyColor,
                                            ),
                                            TextConst(
                                              text: "s/r".toUpperCase(),
                                              width: 50,
                                              textColor: AppColor.textGreyColor,
                                              fontSize: Sizes.fontSizeTwo,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            Sizes.spaceWidth5,
                                          ],
                                        ),
                                      ),
                                      // Batters and Bowlers Sections
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: visitorScoreBoard
                                              .where((data) => data.isBat == 1)
                                              .length,
                                          itemBuilder: (_, int index) {
                                            // Extract the batter data
                                            final sortedBatters =
                                                visitorScoreBoard
                                                    .where((data) =>
                                                        data.isBat == 1)
                                                    .toList()
                                                  ..sort((a, b) =>
                                                      a.battingOrder.compareTo(
                                                          b.battingOrder));

                                            final batter = sortedBatters[index];

                                            // Get the single player ID from the corresponding team
                                            final playerlist =
                                                teams.isNotEmpty &&
                                                        teams.length >
                                                            selectedHighlight
                                                    ? teams[selectedHighlight]
                                                        .playerlist
                                                    : [];

                                            final selectedTeamPlayerIds =
                                                playerlist!
                                                    .map((player) =>
                                                        player.playerid)
                                                    .toList();

                                            final isMatchingPlayer =
                                                selectedTeamPlayerIds
                                                    .contains(batter.playerid);
                                            // Check if the batter is a captain or vice-captain
                                            final isCaptain = playerlist.any(
                                                (player) =>
                                                    player.playerid ==
                                                        batter.playerid &&
                                                    player.isCaptain == 1);
                                            final isViceCaptain =
                                                playerlist.any((player) =>
                                                    player.playerid ==
                                                        batter.playerid &&
                                                    player.isViceCaptain == 1);
                                            final homeTeamO = homeTeamOvers;
                                            final visitorTeamO =
                                                visitorTeamOvers;
                                            final teamOver = homeTeamOvers;

                                            return batterData(
                                                batter,
                                                isMatchingPlayer,
                                                isCaptain,
                                                isViceCaptain,
                                                homeTeamO,
                                                visitorTeamO,
                                                teamOver);
                                          },
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 1.5, bottom: 1.5),
                                        child: ContainerConst(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 7),
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                              color: AppColor
                                                  .scaffoldBackgroundColor,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  TextConst(
                                                    width: 200,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    text: "EXTRAS",
                                                    fontWeight: FontWeight.w300,
                                                    textColor:
                                                        AppColor.blackColor,
                                                    fontSize:
                                                        Sizes.fontSizeThree,
                                                  ),
                                                  TextConst(
                                                    width: 200,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    text: visitorTeamTotalExtra
                                                        .toString(),
                                                    fontWeight: FontWeight.w200,
                                                    textColor:
                                                        AppColor.blackColor,
                                                    fontSize: Sizes.fontSizeOne,
                                                  ),
                                                ],
                                              ),
                                              TextConst(
                                                alignment: Alignment.centerLeft,
                                                text:
                                                    visitorTeamExtra.toString(),
                                                fontWeight: FontWeight.w700,
                                                textColor: AppColor.blackColor,
                                                fontSize: Sizes.fontSizeThree,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 1.5, bottom: 1.5),
                                        child: ContainerConst(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 7),
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                              color: AppColor
                                                  .scaffoldBackgroundColor,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  TextConst(
                                                    width: 200,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    text: "TOTAL",
                                                    fontWeight: FontWeight.w600,
                                                    textColor:
                                                        AppColor.blackColor,
                                                    fontSize:
                                                        Sizes.fontSizeThree,
                                                  ),
                                                  TextConst(
                                                    width: 200,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    text:
                                                        '($visitorTeamTotalWickets wicket, $visitorTeamOvers overs)',
                                                    fontWeight: FontWeight.w200,
                                                    textColor:
                                                        AppColor.blackColor,
                                                    fontSize: Sizes.fontSizeOne,
                                                  ),
                                                ],
                                              ),
                                              TextConst(
                                                alignment: Alignment.centerLeft,
                                                text: visitorTotalScore,
                                                fontWeight: FontWeight.w700,
                                                textColor: AppColor.blackColor,
                                                fontSize: Sizes.fontSizeThree,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ContainerConst(
                                        height: Sizes.screenHeight * 0.055,
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 1,
                                            color: AppColor.textGreyColor
                                                .withOpacity(0.1),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Sizes.spaceWidth15,
                                            TextConst(
                                              width: 170,
                                              alignment: Alignment.centerLeft,
                                              text: "Did Not Bat",
                                              fontWeight: FontWeight.w700,
                                              textColor: AppColor.textGreyColor,
                                              fontSize: Sizes.fontSizeTwo,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: visitorScoreBoard
                                              .where((data) => data.isBat == 0)
                                              .length,
                                          itemBuilder: (_, int i) {
                                            final batter = visitorScoreBoard
                                                .where(
                                                    (data) => data.isBat == 0)
                                                .toList()[i];
                                            // Get the single player ID from the corresponding team
                                            final playerlist =
                                                teams.isNotEmpty &&
                                                        teams.length >
                                                            selectedHighlight
                                                    ? teams[selectedHighlight]
                                                        .playerlist
                                                    : [];
                                            final selectedTeamPlayerIds =
                                                playerlist!
                                                    .map((player) =>
                                                        player.playerid)
                                                    .toList();
                                            final isMatchingPlayer =
                                                selectedTeamPlayerIds
                                                    .contains(batter.playerid);

                                            // Check if the batter is a captain or vice-captain
                                            final isCaptain = playerlist.any(
                                                (player) =>
                                                    player.playerid ==
                                                        batter.playerid &&
                                                    player.isCaptain == 1);
                                            final isViceCaptain =
                                                playerlist.any((player) =>
                                                    player.playerid ==
                                                        batter.playerid &&
                                                    player.isViceCaptain == 1);

                                            return didNotBat(
                                                batter,
                                                isMatchingPlayer,
                                                isCaptain,
                                                isViceCaptain);
                                          },
                                        ),
                                      ),
                                      // Bowlers Section
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ContainerConst(
                                              height:
                                                  Sizes.screenHeight * 0.055,
                                              border: Border(
                                                bottom: BorderSide(
                                                  width: 1,
                                                  color: AppColor.textGreyColor
                                                      .withOpacity(0.1),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Sizes.spaceWidth5,
                                                  TextConst(
                                                    width: 170,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    text: "Bowler",
                                                    fontWeight: FontWeight.w700,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                    fontSize: Sizes.fontSizeTwo,
                                                  ),
                                                  TextConst(
                                                    width: 20,
                                                    text: "O".toUpperCase(),
                                                    fontWeight: FontWeight.w500,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                  ),
                                                  TextConst(
                                                    width: 20,
                                                    text: "M".toUpperCase(),
                                                    fontWeight: FontWeight.w500,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                  ),
                                                  TextConst(
                                                    width: 20,
                                                    text: "R".toUpperCase(),
                                                    fontWeight: FontWeight.w500,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                  ),
                                                  TextConst(
                                                    width: 20,
                                                    text: "W".toUpperCase(),
                                                    fontWeight: FontWeight.w500,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                  ),
                                                  TextConst(
                                                    text: "Eco".toUpperCase(),
                                                    width: 50,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                    fontSize: Sizes.fontSizeTwo,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  Sizes.spaceWidth5,
                                                ],
                                              ),
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: homeScoreBoard
                                                  .where((data) =>
                                                      data.isBowl == 1)
                                                  .length,
                                              itemBuilder: (_, int i) {
                                                final sortedBatters =
                                                    homeScoreBoard
                                                        .where((data) =>
                                                            data.isBowl == 1)
                                                        .toList()
                                                      ..sort((a, b) => a
                                                          .bollingOrder
                                                          .compareTo(
                                                              b.bollingOrder));

                                                final bowler = sortedBatters[i];
                                                // Get the single player ID from the corresponding team
                                                final playerlist = teams
                                                            .isNotEmpty &&
                                                        teams.length >
                                                            selectedHighlight
                                                    ? teams[selectedHighlight]
                                                        .playerlist
                                                    : [];

                                                final selectedTeamPlayerIds =
                                                    playerlist!
                                                        .map((player) =>
                                                            player.playerid)
                                                        .toList();

                                                final isMatchingPlayer =
                                                    selectedTeamPlayerIds
                                                        .contains(
                                                            bowler.playerid);
                                                final isCaptain =
                                                    playerlist.any((player) =>
                                                        player.playerid ==
                                                            bowler.playerid &&
                                                        player.isCaptain == 1);
                                                final isViceCaptain =
                                                    playerlist.any((player) =>
                                                        player.playerid ==
                                                            bowler.playerid &&
                                                        player.isViceCaptain ==
                                                            1);
                                                return bowlerData(
                                                    bowler,
                                                    isMatchingPlayer,
                                                    isCaptain,
                                                    isViceCaptain);
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ContainerConst(
                                                    height: Sizes.screenHeight *
                                                        0.055,
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 1,
                                                        color: AppColor
                                                            .textGreyColor
                                                            .withOpacity(0.1),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Sizes.spaceWidth15,
                                                        TextConst(
                                                          width: 170,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          text:
                                                              "Fall of Wickets",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          textColor: AppColor
                                                              .textGreyColor,
                                                          fontSize:
                                                              Sizes.fontSizeTwo,
                                                        ),
                                                        const Spacer(),
                                                        TextConst(
                                                          text: "Score"
                                                              .toUpperCase(),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          textColor: AppColor
                                                              .textGreyColor,
                                                        ),
                                                        Sizes.spaceWidth15,
                                                        TextConst(
                                                          text: "Over"
                                                              .toUpperCase(),
                                                          textColor: AppColor
                                                              .textGreyColor,
                                                          fontSize:
                                                              Sizes.fontSizeTwo,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        Sizes.spaceWidth10,
                                                      ],
                                                    ),
                                                  ),
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: visitorFallWicket
                                                        .length,
                                                    itemBuilder: (_, int i) {
                                                      final fallWicketData =
                                                          visitorFallWicket[i];
                                                      return fallWicket(
                                                          fallWicketData);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget batterData(
      MatchPlayer batter,
      bool isMatchingPlayer,
      bool isCaptain,
      bool isViceCaptain,
      String homeTeamO,
      String visitorTeamO,
      String teamOver) {
    String wicketStatus = batter.wicketData; // Get
    return Padding(
      padding: const EdgeInsets.only(top: 1.5),
      child: ContainerConst(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllPlayerView(
                matchId: batter.matchid.toString(),
                playerId: batter.playerid.toString(),
                teamId: batter.id.toString(),
                matchType: '1',
              ),
            ),
          );
        },
        color: isMatchingPlayer ? Colors.orange.withOpacity(0.1) : null,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColor.scaffoldBackgroundColor,
          ),
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ContainerConst(
                  height: 35,
                  width: 35,
                  image: DecorationImage(
                    image: NetworkImage(
                        batter.playerimage), // Assuming this is a URL string
                    fit: BoxFit.cover,
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
            Sizes.spaceWidth15,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                matchStatus == '2'
                    ? TextConst(
                        text: batter.playername,
                        fontWeight: wicketStatus == 'Not Out'
                            ? FontWeight.w700
                            : FontWeight.w400, // Directly check here
                        width: 120,
                        alignment: Alignment.centerLeft,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : TextConst(
                        text: batter.playername,
                        fontWeight: FontWeight.w400, // Directly check here
                        width: 120,
                        alignment: Alignment.centerLeft,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                matchStatus == '2'
                    ? TextConst(
                        text: wicketStatus == 'Not Out'
                            ? 'Playing'
                            : wicketStatus,
                        fontWeight: wicketStatus == 'Not Out'
                            ? FontWeight.w600
                            : FontWeight.w400,
                        fontSize: 10,
                        width: 120,
                        textColor: wicketStatus == 'Not Out'
                            ? AppColor.primaryRedColor
                            : AppColor.textGreyColor,
                        alignment: Alignment.centerLeft,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : TextConst(
                        text: wicketStatus,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        width: 120,
                        textColor: AppColor.textGreyColor,
                        alignment: Alignment.centerLeft,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ],
            ),
            Sizes.spaceWidth25,
            TextConst(
              text: batter.batsmanData?.run?.toString() ?? '0',
              width: 30,
              textColor: AppColor.blackColor,
              fontWeight: FontWeight.bold,
            ),
            TextConst(
              text: batter.batsmanData?.ball?.toString() ?? '0',
              width: 30,
              textColor: AppColor.blackColor,
            ),
            TextConst(
              text: batter.batsmanData?.fourX?.toString() ?? '0',
              width: 30,
              textColor: AppColor.blackColor,
            ),
            TextConst(
              text: batter.batsmanData?.sixX?.toString() ?? '0',
              width: 30,
              textColor: AppColor.blackColor,
            ),
            TextConst(
              text: batter.batsmanData?.strikeRate?.toString() ?? '0',
              width: 50,
              textColor: AppColor.blackColor,
            ),
          ],
        ),
      ),
    );
  }

  bowlerData(MatchPlayer bowler, bool isMatchingPlayer, bool isCaptain,
      bool isViceCaptain) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.5),
      child: ContainerConst(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllPlayerView(
                matchId: bowler.matchid.toString(),
                playerId: bowler.playerid.toString(),
                teamId: bowler.id.toString(),
                matchType: '1',
              ),
            ),
          );
        },
        color: isMatchingPlayer ? Colors.orange.withOpacity(0.1) : null,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColor.scaffoldBackgroundColor,
          ),
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ContainerConst(
                  height: 35,
                  width: 35,
                  image: DecorationImage(
                    image: NetworkImage(bowler.playerimage.toString()),
                    fit: BoxFit.cover,
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
            Sizes.spaceWidth15,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextConst(
                  text: bowler.playername.toString(),
                  fontWeight: FontWeight.w500,
                  width: 120,
                  alignment: Alignment.centerLeft,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Sizes.spaceWidth25,
            TextConst(
              text: bowler.bowlerData!.overs.toString(),
              width: 20,
              textColor: AppColor.blackColor,
              fontWeight: FontWeight.bold,
            ),
            TextConst(
              text: bowler.bowlerData!.medians.toString(),
              width: 30,
              textColor: AppColor.blackColor,
            ),
            TextConst(
              text: bowler.bowlerData!.runs.toString(),
              width: 30,
              textColor: AppColor.blackColor,
            ),
            TextConst(
              text: bowler.bowlerData!.wickets.toString(),
              width: 30,
              textColor: AppColor.blackColor,
            ),
            TextConst(
              text: bowler.bowlerData!.eco.toString(),
              width: 50,
              textColor: AppColor.blackColor,
            ),
          ],
        ),
      ),
    );
  }

  didNotBat(MatchPlayer bowler, bool isMatchingPlayer, bool isCaptain,
      bool isViceCaptain) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.5),
      child: ContainerConst(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllPlayerView(
                matchId: bowler.matchid.toString(),
                playerId: bowler.playerid.toString(),
                teamId: bowler.id.toString(),
                matchType: '1',
              ),
            ),
          );
        },
        color: isMatchingPlayer ? Colors.orange.withOpacity(0.1) : null,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColor.scaffoldBackgroundColor,
          ),
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ContainerConst(
                  height: 35,
                  width: 35,
                  image: DecorationImage(
                    image: NetworkImage(bowler.playerimage.toString()),
                    fit: BoxFit.cover,
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
            Sizes.spaceWidth15,
            TextConst(
              text: bowler.playername.toString(),
              fontWeight: FontWeight.w500,
              width: 120,
              alignment: Alignment.centerLeft,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  fallWicket(WicketFall fallWicketData) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.5),
      child: ContainerConst(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColor.scaffoldBackgroundColor,
          ),
        ),
        child: Row(
          children: [
            Sizes.spaceWidth15,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextConst(
                  text: fallWicketData.playername.toString(),
                  fontWeight: FontWeight.w500,
                  width: 150,
                  alignment: Alignment.centerLeft,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const Spacer(),
            TextConst(
              text:
                  "${fallWicketData.wicketFallScore.toString()} / ${fallWicketData.wicketDown.toString()}",
              textColor: AppColor.blackColor,
            ),
            Sizes.spaceWidth15,
            TextConst(
              text: fallWicketData.wicketFallBall.toString(),
              width: 50,
              textColor: AppColor.blackColor,
            ),
          ],
        ),
      ),
    );
  }
}
