import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/model/contest_data_model.dart';
import 'package:gold11/model/contest_detail_model.dart';
import 'package:gold11/new_pages_by_harsh/live_match/constant/player_view.dart';
import 'package:gold11/new_pages_by_harsh/model/live_my_constant.dart';
import 'package:gold11/new_pages_by_harsh/model/live_team_preview_model.dart';
import 'package:gold11/new_pages_by_harsh/model/my_contest_leader_board.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/app_url_const.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/player_view_model.dart';
import 'package:gold11/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LiveTeamPreview extends StatefulWidget {
  final int type;
  final Leaderboard? data;
  final MyContestLeaderBoardModel? data2;
  final LiveTeams? data3;
  final Teams? data4;

  const LiveTeamPreview({
    super.key,
    required this.type,
    required this.data,
    required this.data2,
    required this.data3,
    required this.data4,
  });

  @override
  State<LiveTeamPreview> createState() => _LiveTeamPreviewState();
}

class _LiveTeamPreviewState extends State<LiveTeamPreview> {
  int wkCount = 0;
  int batterCount = 0;
  int allRounderCount = 0;
  int bowlersCount = 0;

  List<LiveTeamPreviewModel> wkPlayers = [];
  List<LiveTeamPreviewModel> batter = [];
  List<LiveTeamPreviewModel> allRounder = [];
  List<LiveTeamPreviewModel> bowlers = [];
  int? responseStatusCode;
  List<LiveTeamPreviewModel> myLiveTeamPreviewItems = [];

  @override
  void initState() {
    super.initState();
    myLiveTeamPreviewItemsApi();
  }

  void _filterPlayersByDesignation() {
    wkPlayers = myLiveTeamPreviewItems
        .where((player) => player.designationName == 'WK')
        .toList();
    wkCount = wkPlayers.length;

    batter = myLiveTeamPreviewItems
        .where((player) => player.designationName == 'BAT')
        .toList();
    batterCount = batter.length;

    allRounder = myLiveTeamPreviewItems
        .where((player) => player.designationName == 'AR')
        .toList();
    allRounderCount = allRounder.length;

    bowlers = myLiveTeamPreviewItems
        .where((player) => player.designationName == 'BOWL')
        .toList();
    bowlersCount = bowlers.length;
  }

  @override
  Widget build(BuildContext context) {
    final matchStatus = widget.type == 1
        ? widget.data2!.matchstatus
        : widget.type == 2
        ? widget.data3!.matchstatus
        : widget.type == 3
        ? widget.data4!.matchstatus
        : widget.data!.matchstatus;
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
        topRight: Radius.circular(20)),
                image: DecorationImage(
                  image: AssetImage(Assets.assetsPredctonBgPtch),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  matchStatus == 2|| matchStatus == 3
                      ? liveAppBar()
                      : appBarSection(),

                  const SizedBox(height: 60,),
                  _buildSection('Wicket-Keeper', wkPlayers),
                  const SizedBox(height: 40,),
                  _buildSection('Batter', batter),
                  const SizedBox(height: 40,),
                  _buildSection('All-Rounder', allRounder),
                  const SizedBox(height: 40,),
                  _buildSection('Bowlers', bowlers),
                  const SizedBox(height: 40,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<LiveTeamPreviewModel> players) {
    return Column(
      children: [
        Text(
          title.toUpperCase(),
          style: GoogleFonts.mcLaren(color: AppColor.whiteColor),
        ),
        LivePlayerView(wkPlayers: players, homeTeamId: homeTeamId.toString()),
      ],
    );
  }

  String? homeTeamId;
  String? homeTeamNameData;
  String? visitorTeamName;
  String? homeTeamPlayerCount;
  String? visitorTeamPlayerCount;
  Future<void> myLiveTeamPreviewItemsApi() async {
    final matchId = widget.type == 1
        ? widget.data2!.matchId
        : widget.type == 2
            ? widget.data3!.matchId
        : widget.type == 3
        ? widget.data4!.matchId
            : widget.data!.matchId;
    final gameId = widget.type == 1
        ? widget.data2!.gameid
        : widget.type == 2
            ? widget.data3!.gameId
        : widget.type == 3
        ? widget.data4!.gameid
            : widget.data!.gameid;
    final teamId = widget.type == 1
        ? widget.data2!.id
        : widget.type == 2
            ? widget.data3!.id
        : widget.type == 3
        ? widget.data4!.id
            : widget.data!.id;
    final userToken =
        Provider.of<SharedPrefViewModel>(context, listen: false).userToken;
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};
    final body = jsonEncode({
      "userid": userToken,
      "matchid": matchId,
      "gameid": gameId,
      "teamid": teamId,
    });

    try {
      final response = await http.post(
        Uri.parse(AppApiUrls.liveTeamPreview),
        headers: headers,
        body: body,
      );

      responseStatusCode = response.statusCode;
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'] as List;
        homeTeamId = json.decode(response.body)['home_teamid'].toString();
        homeTeamNameData =
            json.decode(response.body)['hometeam_name'].toString();
        visitorTeamName =
            json.decode(response.body)['visitorteam_name'].toString();
        homeTeamPlayerCount =
            json.decode(response.body)['home_team_player_count'].toString();
        visitorTeamPlayerCount =
            json.decode(response.body)['visitor_team_player_count'].toString();

        setState(() {
          myLiveTeamPreviewItems = responseData
              .map((item) => LiveTeamPreviewModel.fromJson(item))
              .toList();
          _filterPlayersByDesignation();
        });
      } else {
        debugPrint('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
    }
  }

  Widget appBarSection() {
    final userName = widget.type == 1
        ? widget.data2!.username
        : widget.type == 2
            ? widget.data3!.username
        : widget.type == 3
        ?
        Provider.of<ProfileViewModel>(context).userProfile!.data!.name
            : widget.data!.username;
    final teamName = widget.type == 1
        ? widget.data2!.teamName
        : widget.type == 2
            ? widget.data3!.teamName
            : widget.type == 3
                ? widget.data4!.teamName
                : widget.data!.teamName;

    // final matchData = Provider.of<GameViewModel>(context).selectedMatch;
    return Consumer<PlayerViewModel>(builder: (context, provider, child) {
      return ContainerConst(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        color: Colors.black87,
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.clear,
                  color: AppColor.whiteColor,
                  size: 25,
                ),
              ),
              title: Row(
                children: [
                  TextConst(
                    text: userName.toString(),
                    textColor: AppColor.whiteColor,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.fontSizeThree,
                  ),
                  ContainerConst(
                    color: AppColor.blackColor,
                    borderRadius: BorderRadius.circular(5),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      teamName ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: AppColor.scaffoldBackgroundColor.withOpacity(0.1),
            ),
            Sizes.spaceHeight5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextConst(
                      text: "Players",
                      textColor:
                          AppColor.scaffoldBackgroundColor.withOpacity(0.7),
                      fontSize: Sizes.fontSizeOne,
                      alignment: Alignment.centerLeft,
                    ),
                    Row(
                      children: [
                        TextConst(
                          text: "${myLiveTeamPreviewItems.length}",
                          textColor: AppColor.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.fontSizeThree,
                        ),
                        TextConst(
                          text: "/11",
                          textColor:
                              AppColor.scaffoldBackgroundColor.withOpacity(0.7),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    ContainerConst(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(5),
                      height: 25,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        homeTeamNameData.toString(),
                        // matchData.homeTeamShortName ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                    Sizes.spaceWidth5,
                    TextConst(
                      text: homeTeamPlayerCount.toString(),
                      textColor: AppColor.whiteColor,
                      fontSize: Sizes.fontSizeThree,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                TextConst(
                  text: ":",
                  textColor: AppColor.scaffoldBackgroundColor.withOpacity(0.7),
                  width: 20,
                ),
                Row(
                  children: [
                    TextConst(
                      text: visitorTeamPlayerCount.toString(),
                      textColor: AppColor.whiteColor,
                      fontSize: Sizes.fontSizeThree,
                      fontWeight: FontWeight.w600,
                    ),
                    Sizes.spaceWidth5,
                    ContainerConst(
                      color: AppColor.blackColor,
                      borderRadius: BorderRadius.circular(5),
                      height: 25,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        visitorTeamName.toString(),
                        // matchData.visitorTeamShortName ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget liveAppBar() {
    final teamName = widget.type == 1
        ? widget.data2!.teamName
        : widget.type == 2
        ? widget.data3!.teamName
        : widget.type == 3
        ? widget.data4!.teamName
        : widget.data!.teamName;
    final allPoint = widget.type == 1
        ? widget.data2!.allPoint
        : widget.type == 2
        ? widget.data3!.allPoint
        : widget.type == 3
        ? widget.data4!.allPoint
        : widget.data!.allPoint;

    final username = widget.type == 1
        ? widget.data2!.username
        : widget.type == 2
        ? widget.data3!.username
        : widget.type == 3
        ?  Provider.of<ProfileViewModel>(context)
        .userProfile!
        .data!
        .userName
        : widget.data!.username;
    return Consumer<PlayerViewModel>(builder: (context, provider, child) {
      return Container(
        height: Sizes.screenHeight * 0.09,
        width: Sizes.screenWidth,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(Icons.close,color: AppColor.whiteColor,)),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextConst(
                      text:username.toString(),
                      textColor: AppColor.whiteColor,
                      alignment: Alignment.centerLeft,
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.fontSizeThree,
                    ),
                    const SizedBox(width: 10,),
                    ContainerConst(
                      color: AppColor.blackColor,
                      borderRadius: BorderRadius.circular(5),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        teamName ?? "",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextConst(
                      text: allPoint.toString(),
                      textColor: AppColor.whiteColor,
                      alignment: Alignment.centerLeft,
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.fontSizeThree,
                    ),
                    TextConst(
                      text: ' pts',
                      textColor: AppColor.whiteColor,
                      alignment: Alignment.centerLeft,
                      fontWeight: FontWeight.w500,
                      fontSize: Sizes.fontSizeOne,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            IconButton(onPressed: (){}, icon: const Icon(Icons.share,color: AppColor.whiteColor,)),

            ContainerConst(
              margin: const EdgeInsets.only(right: 15),
              // width: ,
              shape: BoxShape.circle,
              padding: const EdgeInsets.all(5),
              border: Border.all(color: Colors.white, width: 1),
              child: Text(
                "PTS",
                style: TextStyle(fontSize: Sizes.fontSizeOne, color: Colors.white),
              ),
            ),
          ],
        ),
      );
    });
  }
}
