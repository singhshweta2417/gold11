import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gold11/model/player_data_model.dart';
import 'package:gold11/new_pages_by_harsh/model/single_player_details_model.dart';
import 'package:gold11/new_pages_by_harsh/my_contest/expension_tile.dart';
import 'package:gold11/res/app_url_const.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/game_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:gold11/view_model/player_view_model.dart';

class SinglePlayerDetail extends StatefulWidget {
  final PlayerData data;
  final int playerIndex;
  const SinglePlayerDetail({super.key, required this.data, required  this.playerIndex});

  @override
  State<SinglePlayerDetail> createState() => _SinglePlayerDetailState();
}

class _SinglePlayerDetailState extends State<SinglePlayerDetail> {
  @override
  void initState() {
    super.initState();
    playerInfo();
  }

  late List<int> teamIds;

  @override
  Widget build(BuildContext context) {
    const constPadding = EdgeInsets.only(top: 12, right: 20, left: 20);
    const constPaddingHorizontal = EdgeInsets.symmetric(horizontal: 20);

    return Consumer2<PlayerViewModel, GameViewModel>(
      builder: (context, playerProvider, gameProvider, child) {
        teamIds =
        List<int>.from(jsonDecode(gameProvider.selectedMatch.teamId ?? "[]"));
        final wkCount = playerProvider.selectedWKPlayersCount;
        final batCount = playerProvider.selectedBATPlayersCount;
        final arCount = playerProvider.selectedARPlayersCount;
        final bowlCount = playerProvider.selectedBOWLPlayersCount;

        const maxPlayersPerRole = 8;
        const maxTotalPlayers = 11;
        const maxPlayersPerTeam = 10;

        final team1PlayerCount = playerProvider.selectedPlayers
            .where((e) => e.teamId == teamIds[1])
            .length;
        final team2PlayerCount = playerProvider.selectedPlayers
            .where((e) => e.teamId == teamIds[0])
            .length;

        final isMaxPlayersForTeam1 = team1PlayerCount >= maxPlayersPerTeam;
        final isMaxPlayersForTeam2 = team2PlayerCount >= maxPlayersPerTeam;

        final totalSelectedPlayers = playerProvider.selectedPlayers.length;

        bool isSelectable = widget.data.isSelected! || // Allow deselection
            (totalSelectedPlayers < maxTotalPlayers &&
                (((widget.data.designationName == "WK" && wkCount < maxPlayersPerRole) ||
                    (widget.data.designationName == "BAT" && batCount < maxPlayersPerRole) ||
                    (widget.data.designationName == "AR" && arCount < maxPlayersPerRole) ||
                    (widget.data.designationName == "BOWL" && bowlCount < maxPlayersPerRole)) &&
                    ((widget.data.teamId == teamIds[1] && !isMaxPlayersForTeam1) ||
                        (widget.data.teamId == teamIds[0] && !isMaxPlayersForTeam2))));



        return Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              ContainerConst(
                height: Sizes.screenHeight * 0.95,
                width: Sizes.screenWidth,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.lightBlue.shade50.withOpacity(0.4),
                child: Column(
                  children: [
                    topBlackContainer(constPadding),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          topWhiteContainer(constPadding),
                          Sizes.spaceHeight20,
                          tourFantasyStats(constPaddingHorizontal, constPadding),
                          Sizes.spaceHeight20,
                          inMyTeams(constPaddingHorizontal, constPadding),
                          Sizes.spaceHeight20,
                          matchWiseFantasyStats(constPaddingHorizontal, constPadding),
                          Sizes.spaceHeight35,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 30,
                left: Sizes.screenWidth * 0.3,
                right: Sizes.screenWidth * 0.3,
                child: widget.data.isSelected!
                    ? ButtonConst(
                  label: 'Remove from team'.toUpperCase(),
                  color: AppColor.whiteColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  border: Border.all(width: 1, color: Colors.grey),
                  textColor: AppColor.blackColor,
                  onTap: () {
                    playerProvider.togglePlayerSelection(widget.playerIndex);
                    Navigator.pop(context);
                  },
                )
                    : ButtonConst(
                  label: 'Add to team'.toUpperCase(),
                  color: AppColor.activeButtonGreenColor,
                  textColor: AppColor.whiteColor,
                    onTap: () {
                      if (isSelectable) {
                        playerProvider.togglePlayerSelection(widget.playerIndex);
                        Navigator.pop(context);
                      } else if (team1PlayerCount == maxPlayersPerTeam || team2PlayerCount == maxPlayersPerTeam) {
                        Navigator.pop(context);
                        Utils.showErrorMessage(context, "Maximum 10 players can be selected from one team.");
                      } else if (totalSelectedPlayers == maxTotalPlayers) {
                        Navigator.pop(context);
                        Utils.showErrorMessage(context, "11 players already selected. Tap 'Next'.");
                      } else {
                        Navigator.pop(context);
                        Utils.showErrorMessage(context,
                            "Maximum of 8 ${widget.data.designationName} players per team.");
                      }
                    }

                  // onTap: () {
                  //   if (isSelectable) {
                  //     playerProvider.togglePlayerSelection(widget.playerIndex);
                  //     Navigator.pop(context);
                  //   } else if (team1PlayerCount == maxPlayersPerTeam ||
                  //       team2PlayerCount == maxPlayersPerTeam) {
                  //     showError("Maximum 10 players can be selected from one team.");
                  //   } else if (totalSelectedPlayers == maxTotalPlayers) {
                  //     showError("11 players already selected. Tap 'Next'.");
                  //   } else {
                  //     showError(
                  //         "Maximum of 8 ${widget.data.designationName} players per team.");
                  //   }
                  // },
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  expensionWidget(
    String header,
    String subText,
    int side,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextConst(
          padding: const EdgeInsets.all(0),
          alignment: Alignment.centerLeft,
          text: header,
          fontWeight: FontWeight.w500,
          textColor: AppColor.textGreyColor,
          fontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
        TextConst(
          padding: const EdgeInsets.all(0),
          alignment: side == 2
              ? Alignment.center
              : side == 1
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
          text: subText,
          fontWeight: FontWeight.w500,
          textColor: AppColor.blackColor,
          fontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  ContainerConst topBlackContainer(EdgeInsets constPadding) {
    return ContainerConst(
      padding: constPadding,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      height: Sizes.screenHeight * 0.22,
      width: Sizes.screenWidth,
      color: AppColor.blackColor,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.clear,
                    size: 32,
                    color: AppColor.whiteColor,
                  )),
              Sizes.spaceWidth20,
              const TextConst(
                alignment: Alignment.center,
                text: 'Player Info',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                textColor: AppColor.whiteColor,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Stack(
                children: [
                  ContainerConst(
                    height: 120,
                    width: 100,
                  child:

                    CachedNetworkImage(
                      imageUrl: playerImage.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    child: ContainerConst(
                      height: 15,
                      width: 40,
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.whiteColor,
                      child: TextConst(
                        alignment: Alignment.center,
                        text: playerDesignation.toString().toUpperCase(),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Sizes.spaceWidth35,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Sizes.spaceHeight10,
                  const TextConst(
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.center,
                    text: "Points",
                    fontWeight: FontWeight.w500,
                    textColor: Colors.grey,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                  TextConst(
                    padding: const EdgeInsets.all(0),
                    alignment: Alignment.center,
                    text: playerPoints.toString(),
                    fontWeight: FontWeight.w900,
                    textColor: AppColor.whiteColor,
                    fontSize: 25,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Sizes.spaceWidth35,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Sizes.spaceHeight10,
                  const TextConst(
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.center,
                    text: "Points",
                    fontWeight: FontWeight.w500,
                    textColor: Colors.grey,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                  TextConst(
                    padding: const EdgeInsets.all(0),
                    alignment: Alignment.center,
                    text: creditPoints.toString(),
                    fontWeight: FontWeight.w900,
                    textColor: AppColor.whiteColor,
                    fontSize: 25,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  ContainerConst topWhiteContainer(EdgeInsets constPadding) {
    String formattedDate = "N/A"; // Default value for fallback
    if (dob.isNotEmpty) {
      try {
        DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(dob);
        formattedDate = DateFormat('MMM d, yyyy').format(parsedDate);
      } catch (e) {
      }
    }
    return ContainerConst(
      padding: constPadding,
      color: AppColor.whiteColor,
      child: Column(
        children: [
          TextConst(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerLeft,
            text: playerName.toString(),
            fontWeight: FontWeight.w800,
            textColor: AppColor.blackColor,
            fontSize: 20,
            overflow: TextOverflow.ellipsis,
          ),
          Sizes.spaceHeight10,
          Row(
            children: [
              TextConst(
                padding: const EdgeInsets.all(0),
                alignment: Alignment.centerLeft,
                text: "${playerDesignation.toString()},",
                fontWeight: FontWeight.w500,
                textColor: AppColor.blackColor,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
              TextConst(
                padding: const EdgeInsets.all(0),
                alignment: Alignment.centerLeft,
                text: "${playerBat=='null'?'':playerBat.toString()}, ${playerBowl=='null'?'':playerBowl.toString()}",
                fontWeight: FontWeight.w500,
                textColor: AppColor.textGreyColor,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Sizes.spaceHeight10,
          Row(
            children: [
              TextConst(
                padding: const EdgeInsets.all(0),
                alignment: Alignment.centerLeft,
                text: "Nationality: ${nationality.toString()}",
                fontWeight: FontWeight.w500,
                textColor: AppColor.textGreyColor,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
              Sizes.spaceWidth10,
              const ContainerConst(
                height: 12,
                width: 2,
                color: AppColor.textGreyColor,
              ),
              Sizes.spaceWidth10,
              TextConst(
                padding: const EdgeInsets.all(0),
                alignment: Alignment.centerLeft,
                text: "Born $formattedDate",
                fontWeight: FontWeight.w500,
                textColor: AppColor.textGreyColor,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Sizes.spaceHeight10,
          playingStatus.toString() != '2'
              ? Row(
                  children: [
                    ContainerConst(
                      height: 5,
                      width: 5,
                      shape: BoxShape.circle,
                      color: playingStatus.toString() == '0'
                          ? Colors.indigo.shade900
                          : AppColor.primaryRedColor,
                    ),
                    Sizes.spaceWidth10,
                    TextConst(
                      padding: const EdgeInsets.all(0),
                      alignment: Alignment.centerLeft,
                      text: playingStatus.toString() == '0'
                          ? "Played last match"
                          : playingStatus.toString() == '1'
                              ? 'Announced'
                              : '',
                      fontWeight: FontWeight.w500,
                      textColor: playingStatus.toString() == '0'
                          ? Colors.indigo.shade900
                          : AppColor.primaryRedColor,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          Sizes.spaceHeight10,
        ],
      ),
    );
  }

  Column tourFantasyStats(
      EdgeInsets constPaddingHorizontal, EdgeInsets constPadding) {
    return Column(
      children: [
        Padding(
          padding: constPaddingHorizontal,
          child: const TextConst(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerLeft,
            text: "Tour Fantasy Stats",
            fontWeight: FontWeight.w700,
            textColor: AppColor.blackColor,
            fontSize: 16,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Sizes.spaceHeight20,
        Padding(
          padding: constPaddingHorizontal,
          child: ContainerConst(
            padding: constPadding,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: AppColor.whiteColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const TextConst(
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.centerLeft,
                          text: "Matches Played",
                          fontWeight: FontWeight.w500,
                          textColor: AppColor.textGreyColor,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        TextConst(
                          padding: const EdgeInsets.all(0),
                          alignment: Alignment.centerLeft,
                          text: matchPlayed.toString(),
                          fontWeight: FontWeight.w800,
                          textColor: AppColor.blackColor,
                          fontSize: 25,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Sizes.spaceWidth10,
                    const ContainerConst(
                      height: 40,
                      width: 1,
                      color: AppColor.textGreyColor,
                    ),
                    Sizes.spaceWidth10,
                    Column(
                      children: [
                        const TextConst(
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.centerLeft,
                          text: "Avg. Points",
                          fontWeight: FontWeight.w500,
                          textColor: AppColor.textGreyColor,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        TextConst(
                          padding: const EdgeInsets.all(0),
                          alignment: Alignment.centerLeft,
                          text: avgPoints.toString(),
                          fontWeight: FontWeight.w800,
                          textColor: AppColor.blackColor,
                          fontSize: 25,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                Sizes.spaceHeight10,
              ],
            ),
          ),
        )
      ],
    );
  }

  Column inMyTeams(EdgeInsets constPaddingHorizontal, EdgeInsets constPadding) {
    return Column(
      children: [
        Padding(
          padding: constPaddingHorizontal,
          child: const TextConst(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerLeft,
            text: "In My Teams",
            fontWeight: FontWeight.w700,
            textColor: AppColor.blackColor,
            fontSize: 16,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Sizes.spaceHeight20,
        Padding(
          padding: constPaddingHorizontal,
          child: ContainerConst(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            padding: constPadding,
            color: AppColor.whiteColor,
            child: const Column(
              children: [
                TextConst(
                  padding: EdgeInsets.all(0),
                  alignment: Alignment.centerLeft,
                  text: "you've not added this player in any team",
                  fontWeight: FontWeight.w400,
                  textColor: AppColor.textGreyColor,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
                Sizes.spaceHeight10,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column matchWiseFantasyStats(
      EdgeInsets constPaddingHorizontal, EdgeInsets constPadding) {
    return playerInfoDetail.isEmpty?
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Sizes.spaceHeight20,
        TextConst(
          padding: EdgeInsets.all(0),
          alignment: Alignment.center,
          text: "No info available for this player yet",
          fontWeight: FontWeight.w400,
          textColor: AppColor.textGreyColor,
          fontSize: 14,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ):
      Column(
      children: [
        Padding(
          padding: constPaddingHorizontal,
          child: const TextConst(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerLeft,
            text: "Matchwise Fantasy Stats",
            fontWeight: FontWeight.w700,
            textColor: AppColor.blackColor,
            fontSize: 16,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Sizes.spaceHeight20,
        ListView.builder(
          shrinkWrap: true,
          itemCount: playerInfoDetail.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final data = playerInfoDetail[index];
            DateTime parsedDate = DateTime.parse(data.startDate!);
            String formattedDate2 =
                DateFormat('dd MMM yyyy').format(parsedDate);
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Padding(
                padding: constPaddingHorizontal,
                child: ContainerConst(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  //  padding: constPadding,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],

                  border: Border.all(color: Colors.grey.withOpacity(0.4)),
                  child: Column(
                    children: [
                      CustomExpansionTile(
                        header: Padding(
                          padding: constPadding,
                          child: SizedBox(
                            width: Sizes.screenWidth * 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextConst(
                                  padding: EdgeInsets.all(0),
                                  alignment: Alignment.centerLeft,
                                  text: "vs",
                                  fontWeight: FontWeight.w500,
                                  textColor: AppColor.textGreyColor,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Sizes.spaceWidth5,
                                TextConst(
                                  padding: const EdgeInsets.all(0),
                                  alignment: Alignment.centerLeft,
                                  text: data.oppositeTeam.toString(),
                                  fontWeight: FontWeight.w500,
                                  textColor: AppColor.blackColor,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        header2: Padding(
                          padding: constPadding,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TextConst(
                                    padding: const EdgeInsets.all(0),
                                    alignment: Alignment.centerLeft,
                                    text: formattedDate2.toString(),
                                    fontWeight: FontWeight.w500,
                                    textColor: AppColor.textGreyColor,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Sizes.spaceWidth5,
                                  const ContainerConst(
                                    height: 10,
                                    width: 1,
                                    color: AppColor.textGreyColor,
                                  ),
                                  Sizes.spaceWidth5,
                                  const TextConst(
                                    padding: EdgeInsets.all(0),
                                    alignment: Alignment.centerLeft,
                                    text: "ABD Elected to bat first",
                                    fontWeight: FontWeight.w400,
                                    textColor: AppColor.textGreyColor,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  expensionWidget(
                                      'Selected By', '${data.selectedBy}%', 1),
                                  expensionWidget(
                                      'Points', '${data.totalPoint}', 2),
                                  expensionWidget(
                                      'Credits', '${data.creditPoints}', 3),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  expensionWidget(
                                      'Batting Pts', '${data.battingPoint}', 1),
                                  expensionWidget(
                                      'Bowling Pts', '${data.bollingPoint}', 2),
                                  expensionWidget(
                                      'Other Pts', '${data.fieldingPoint}', 3),
                                ],
                              ),
                            ],
                          ),
                        ),
                        iconColor: AppColor.blackColor,
                        children: [
                          Sizes.spaceHeight15,
                          ContainerConst(
                            padding: constPadding,
                            width: Sizes.screenWidth,
                            color: Colors.lightBlue.shade50.withOpacity(0.4),
                            child: const Column(
                              children: [
                                TextConst(
                                  padding: EdgeInsets.all(0),
                                  alignment: Alignment.centerLeft,
                                  text: "Points Break",
                                  fontWeight: FontWeight.w500,
                                  textColor: AppColor.blackColor,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Sizes.spaceHeight15,
                              ],
                            ),
                          ),
                          Sizes.spaceHeight15,
                          Padding(
                            padding: constPadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextConst(
                                  padding: const EdgeInsets.all(0),
                                  alignment: Alignment.centerLeft,
                                  text: "Event",
                                  width: Sizes.screenWidth * 0.3,
                                  fontWeight: FontWeight.w500,
                                  textColor: AppColor.textGreyColor,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const TextConst(
                                  padding: EdgeInsets.all(0),
                                  alignment: Alignment.center,
                                  text: "Points",
                                  fontWeight: FontWeight.w500,
                                  textColor: AppColor.textGreyColor,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const TextConst(
                                  padding: EdgeInsets.all(0),
                                  alignment: Alignment.center,
                                  text: "Actual",
                                  fontWeight: FontWeight.w500,
                                  textColor: AppColor.textGreyColor,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Sizes.spaceHeight10,
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.eventData!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final subData = data.eventData![index];
                              return Padding(
                                padding: constPadding,
                                child: Column(
                                  children: [
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TextConst(
                                          padding: const EdgeInsets.all(0),
                                          alignment: Alignment.centerLeft,
                                          text: subData.event.toString(),
                                          fontWeight: FontWeight.w500,
                                          textColor: AppColor.blackColor,
                                          fontSize: 14,
                                          width: Sizes.screenWidth * 0.3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        TextConst(
                                          padding: const EdgeInsets.all(0),
                                          alignment: Alignment.center,
                                          text: subData.points.toString(),
                                          fontWeight: FontWeight.w500,
                                          textColor: AppColor.blackColor,
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        TextConst(
                                          padding: const EdgeInsets.all(0),
                                          alignment: Alignment.centerRight,
                                          text: subData.actual.toString(),
                                          fontWeight: FontWeight.w500,
                                          textColor: AppColor.blackColor,
                                          fontSize: 14,
                                          width: 70,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Sizes.spaceHeight10,
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  int? responseStatusCode;

  List<Data> playerInfoDetail = [];
  String playerName='-';
  String playerImage='-';
  String playerPoints='-';
  String playerTeam='-';
  String creditPoints='-';
  String playerDesignation='-';
  String playerBat='-';
  String playerBowl='-';
  String nationality='-';
  String dob = '0';
  String playingStatus='-';
  String matchPlayed='-';
  String avgPoints='-';

  Future<void> playerInfo() async {
    final matchId =
        Provider.of<GameViewModel>(context, listen: false).selectedMatch.id;
    final playerId = widget.data.pid;
    final gameID =
        Provider.of<GameViewModel>(context, listen: false).selectedGameTypeId;
    final seasonID = widget.data.thirdPartySeasonId;
    final headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    final body = json.encode({
      'type': '1',
      'matchid': matchId.toString(),
      'gameid': gameID.toString(),
      'playerid': playerId.toString(),
      'season_id': seasonID.toString()
    });
    try {
      final response = await http.post(
        Uri.parse(AppApiUrls.playerInfo),
        headers: headers,
        body: body,
      );
      setState(() {
        responseStatusCode = response.statusCode;
      });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> responseData2 = responseData['data'];
        final playerDetails = responseData['personal_details'];
        final tourFantasy = responseData['tour_fantacy_states'];
        setState(() {
          responseData;
          playerInfoDetail =
              responseData2.map((item) => Data.fromJson(item)).toList();
          playerName = playerDetails['name'].toString();
          playerImage = playerDetails['player_image'].toString();
          playerPoints = playerDetails['points'].toString();
          creditPoints = playerDetails['credit_points'].toString();
          playerDesignation = playerDetails['designation'].toString();
          playerBat = playerDetails['bat'].toString();
          playerBowl = playerDetails['bowl'].toString();
          nationality = playerDetails['nationality'].toString();
          dob = playerDetails['dob'].toString();
          playingStatus = playerDetails['playing_status'].toString();
          matchPlayed = tourFantasy['match_played'].toString();
          avgPoints = tourFantasy['avg_points'].toString();
        });
      } else if (response.statusCode == 400) {
        setState(() {
          playerInfoDetail = [];
        });
        if (kDebugMode) {
          print('Data not found');
        }
      } else {
        throw Exception(
            'Failed to load data with status code ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
    }
  }
}
