
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/model/team_data_model.dart';
import 'package:gold11/new_pages_by_harsh/constant_list.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/game_view_model.dart';
import 'package:gold11/view_model/player_view_model.dart';
import 'package:gold11/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class TeamPreview extends StatefulWidget {
  final TeamData data;
  const TeamPreview({super.key, required this.data});
  @override
  State<TeamPreview> createState() => _TeamPreviewState();
}

class _TeamPreviewState extends State<TeamPreview> {
  late int wkCount;
  late int batterCount;
  late int allRounderCount;
  late int bowlersCount;
  late List<TeamPlayerList> wkPlayers;
  late List<TeamPlayerList> batter;
  late List<TeamPlayerList> allRounder;
  late List<TeamPlayerList> bowlers;
  @override
  void initState() {
    super.initState();
    _getWKPlayers();
    _getBatter();
    _getAllRounder();
    _getAllBowler();
  }

  void _getWKPlayers() {
    if (widget.data.playerList != null && widget.data.playerList!.isNotEmpty) {
      wkPlayers = widget.data.playerList!
          .where((player) => player.designationName == 'WK')
          .toList();
      wkCount = wkPlayers.length;
    } else {
      wkPlayers = [];
      wkCount = 0; // Initialize count to zero
    }
  }

  void _getBatter() {
    if (widget.data.playerList != null && widget.data.playerList!.isNotEmpty) {
      batter = widget.data.playerList!
          .where((player) => player.designationName == 'BAT')
          .toList();
      batterCount = batter.length;
    } else {
      batter = [];
      batterCount = 0; // Initialize count to zero
    }
  }

  void _getAllRounder() {
    if (widget.data.playerList != null && widget.data.playerList!.isNotEmpty) {
      allRounder = widget.data.playerList!
          .where((player) => player.designationName == 'AR')
          .toList();
      allRounderCount = allRounder.length;
    } else {
      allRounder = [];
      allRounderCount = 0;
    }
  }

  void _getAllBowler() {
    if (widget.data.playerList != null && widget.data.playerList!.isNotEmpty) {
      bowlers = widget.data.playerList!
          .where((player) => player.designationName == 'BOWL')
          .toList();
      bowlersCount = bowlers.length;
    } else {
      bowlers = [];
      bowlersCount = 0;
    }
  }

  int getHomeTeamPlayerLength() {
    if (widget.data.playerList != null && widget.data.playerList!.isNotEmpty) {
      return widget.data.playerList!
          .where((player) =>
              player.teamId.toString() == widget.data.homeTeamId.toString())
          .length;
    }
    return 0;
  }

  int getVisitorPlayerLength() {
    if (widget.data.playerList != null && widget.data.playerList!.isNotEmpty) {
      return widget.data.playerList!
          .where((player) =>
              player.teamId.toString() == widget.data.visitorTeamPlayerCount)
          .length;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.transparent,
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.data.matchStatus == 2||widget.data.matchStatus == 3
                        ? liveAppBar()
                        : appBarSection(),
                    const SizedBox(height: 60,),
                    Text(
                      'Wicket-Keeper'.toUpperCase(),
                      style: GoogleFonts.mcLaren(color: AppColor.whiteColor),
                    ),
                    WicketKeeperWidget(wkPlayers: wkPlayers, data: widget.data),
                    const SizedBox(height: 40,),
                    Text(
                      'Batter'.toUpperCase(),
                      style: GoogleFonts.mcLaren(color: AppColor.whiteColor),
                    ),
                    WicketKeeperWidget(wkPlayers: batter, data: widget.data),
                    const SizedBox(height: 40,),
                    Text(
                      'All- Rounder'.toUpperCase(),
                      style: GoogleFonts.mcLaren(color: AppColor.whiteColor),
                    ),
                    WicketKeeperWidget(wkPlayers: allRounder, data: widget.data),
                    const SizedBox(height: 40,),
                    Text(
                      'Bowlers'.toUpperCase(),
                      style: GoogleFonts.mcLaren(color: AppColor.whiteColor),
                    ),
                    WicketKeeperWidget(wkPlayers: bowlers, data: widget.data),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBarSection() {
    final matchData = Provider.of<GameViewModel>(context).selectedMatch;
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
                    text: Provider.of<ProfileViewModel>(context)
                        .userProfile!
                        .data!
                        .userName,
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
                      widget.data.teamName ?? "",
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
                          text: "${widget.data.playerList!.length}",
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
                        matchData.homeTeamShortName ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                    Sizes.spaceWidth5,
                    TextConst(
                      text: widget.data.homeTeamPlayerCount.toString(),
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
                      text: widget.data.visitorTeamPlayerCount.toString(),
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
                        matchData.visitorTeamShortName ?? "",
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
                      text:
                      Provider.of<ProfileViewModel>(context)
                          .userProfile!
                          .data!
                          .userName,
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
                        widget.data.teamName ?? "",
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
                      text: '${widget.data.allPoint} ',
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
