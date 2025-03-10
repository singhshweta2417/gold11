import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/view/team/team_preview_screen.dart';
import 'package:gold11/view_model/player_view_model.dart';

import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../../utils/route/app_routes.dart';
import '../../view_model/game_view_model.dart';
import '../const_widget/button_const.dart';
import '../const_widget/container_const.dart';
import '../const_widget/text_const.dart';
import '../widgets/lines_up_players_listing.dart';

class PastLineUpPlayersScreen extends StatefulWidget {
  @override
  _PastLineUpPlayersScreenState createState() =>
      _PastLineUpPlayersScreenState();
}

class _PastLineUpPlayersScreenState extends State<PastLineUpPlayersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: appBarWidget(),
      body: const LineupPlayerListing(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionContent(),
    );
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      backgroundColor: AppColor.blackColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight * 3.2),
        child: ContainerConst(
          color: AppColor.whiteColor,
          gradient: LinearGradient(
              colors: [
                AppColor.blackColor,
                AppColor.blackColor,
                AppColor.blackColor,
                Colors.grey.shade900
              ],
              begin: Alignment.centerLeft,
              end: FractionalOffset.centerRight,
              tileMode: TileMode.mirror),
          child: Column(
            children: [
              ContainerConst(
                height: kToolbarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    Sizes.spaceWidth10,
                    appBarTitle(),
                    const Spacer(),
                    appBarAction(),
                    Sizes.spaceWidth10,
                  ],
                ),
              ),
              Sizes.spaceHeight15,
              teamCountIndicator(),
              Sizes.spaceHeight10,
              Consumer<GameViewModel>(builder: (context, gvmCom, child) {
                final teamId = jsonDecode(gvmCom.selectedMatch.teamId ?? "");
                return ContainerConst(
                  height: kToolbarHeight,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 8.75),
                  color: AppColor.whiteColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ContainerConst(
                            shape: BoxShape.circle,
                            width: 40,
                            height: 40,
                            image: DecorationImage(
                                image: NetworkImage(
                                    gvmCom.selectedMatch.homeTeamImage ?? ""),
                                fit: BoxFit.cover),
                          ),
                          Sizes.spaceWidth5,
                          TextConst(
                            text: gvmCom.selectedMatch.homeTeamShortName ?? "",
                            fontWeight: FontWeight.bold,
                          ),
                          Consumer<PlayerViewModel>(
                              builder: (context, pvmCon, _) {
                            return TextConst(
                              text:
                                  "(${pvmCon.selectedPlayers.where((data) => data.teamId == teamId[0] && data.isSelected == true).length})",
                              fontSize: Sizes.fontSizeOne,
                            );
                          }),
                        ],
                      ),
                      optionSwitch(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Consumer<PlayerViewModel>(
                              builder: (context, pvmCon, _) {
                            return TextConst(
                              text:
                                  "(${pvmCon.selectedPlayers.where((data) => data.teamId == teamId[1] && data.isSelected == true).length})",
                              fontSize: Sizes.fontSizeOne,
                            );
                          }),
                          TextConst(
                            text:
                                gvmCom.selectedMatch.visitorTeamShortName ?? "",
                            fontWeight: FontWeight.bold,
                          ),
                          Sizes.spaceWidth5,
                          ContainerConst(
                            shape: BoxShape.circle,
                            width: 40,
                            height: 40,
                            image: DecorationImage(
                                image: NetworkImage(
                                    gvmCom.selectedMatch.visitorTeamImage ??
                                        ""),
                                fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              ContainerConst(
                  height: kToolbarHeight / 2,
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  color: Colors.blueGrey.shade50,
                  child: TextConst(
                    text:
                        "Note: Lineup will be available some time befire this match starts.",
                    fontSize: Sizes.fontSizeZero,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarAction() {
    return Text(
      "2h 30m left",
      style: TextStyle(fontSize: Sizes.fontSizeOne, color: Colors.white),
    );
  }

  Widget appBarTitle() {
    return TextConst(
      text: "Past Batting Order",
      textColor: AppColor.whiteColor,
      fontSize: Sizes.fontSizeLarge / 1.25,
      alignment: FractionalOffset.centerLeft,
      fontWeight: FontWeight.w600,
    );
  }

  Widget teamCountIndicator() {
    return Consumer<PlayerViewModel>(builder: (context, provider, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(11, (i) {
          Color color = i < provider.selectedPlayersCount
              ? AppColor.activeButtonGreenColor
              : AppColor.whiteColor;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Transform(
              transform: Matrix4.skewX(-0.5),
              child: ContainerConst(
                height: Sizes.screenWidth / 50,
                width: Sizes.screenWidth / 13,
                color: color,
              ),
            ),
          );
        }),
      );
    });
  }

  Widget optionSwitch() {
    return Consumer<PlayerViewModel>(builder: (context, provider, child) {
      return ContainerConst(
        borderRadius: BorderRadius.circular(20),
        width: Sizes.screenWidth / 2.7,
        color: AppColor.scaffoldBackgroundColor,
        border: Border.all(color: AppColor.textGreyColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ContainerConst(
              onTap: () {
                provider.setLineupSwitchUp(0);
              },
              borderRadius: BorderRadius.circular(20),
              border: provider.lineupSwitchUp == 0
                  ? Border.all(
                      color: AppColor.blackColor.withOpacity(
                        0.2,
                      ),
                      width: 2)
                  : null,
              padding: const EdgeInsets.symmetric(vertical: 4),
              width: Sizes.screenWidth / 5.6,
              color: provider.lineupSwitchUp == 0 ? AppColor.blackColor : null,
              child: TextConst(
                text: "Points",
                fontWeight: provider.lineupSwitchUp == 0
                    ? FontWeight.w600
                    : FontWeight.normal,
                textColor: provider.lineupSwitchUp == 0
                    ? AppColor.whiteColor
                    : AppColor.textGreyColor,
              ),
            ),
            ContainerConst(
              onTap: () {
                provider.setLineupSwitchUp(1);
              },
              borderRadius: BorderRadius.circular(20),
              border: provider.lineupSwitchUp == 1
                  ? Border.all(
                      color: AppColor.blackColor.withOpacity(
                        0.2,
                      ),
                      width: 2)
                  : null,
              padding: const EdgeInsets.symmetric(vertical: 4),
              width: Sizes.screenWidth / 5.6,
              color: provider.lineupSwitchUp == 1 ? AppColor.blackColor : null,
              child: TextConst(
                text: "% Sel by",
                fontWeight: provider.lineupSwitchUp == 1
                    ? FontWeight.w600
                    : FontWeight.normal,
                textColor: provider.lineupSwitchUp == 1
                    ? AppColor.whiteColor
                    : AppColor.textGreyColor,
              ),
            ),
          ],
        ),
      );
    });
  }

  // Widget floatingActionContent() {
  //   return Consumer<PlayerViewModel>(builder: (context, provider, child) {
  //     return ContainerConst(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           ButtonConst(
  //             onTap: () {
  //               showModalBottomSheet(
  //                   isScrollControlled: true,
  //                   context: context,
  //                   builder: (_) {
  //                     return const TeamPreviewScreen();
  //                   });
  //             },
  //             borderRadius: BorderRadius.circular(25),
  //             label: "preview".toUpperCase(),
  //             width: Sizes.screenWidth / 3.5,
  //             height: 40,
  //             icon: Icons.remove_red_eye,
  //             iconColor: AppColor.whiteColor,
  //             color: AppColor.blackColor,
  //             textColor: AppColor.whiteColor,
  //           ),
  //           Sizes.spaceWidth15,
  //           ButtonConst(
  //             onTap: () {
  //               if (provider.selectedPlayersCount == 11) {
  //                 Navigator.pushNamed(context, AppRoutes.chooseTeamCAndVC);
  //               } else {
  //                 if (kDebugMode) {
  //                   print("please complete the team to proceed");
  //                 }
  //               }
  //             },
  //             label: "next".toUpperCase(),
  //             height: 40,
  //             borderRadius: BorderRadius.circular(25),
  //             width: 90,
  //             color: provider.selectedPlayersCount == 11
  //                 ? AppColor.activeButtonGreenColor
  //                 : Colors.grey.shade500,
  //             textColor: AppColor.whiteColor,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }
  Widget floatingActionContent() {
    return Consumer2<PlayerViewModel, GameViewModel>(
        builder: (context, playerProvider, gameProvider, child) {
      final selectedPlayerCount = playerProvider.selectedPlayers.length;
      final teamIds = jsonDecode(gameProvider.selectedMatch.teamId ?? "[]");

      final team1PlayerCount = playerProvider.selectedPlayers
          .where((e) => e.teamId == teamIds[1]) // Assuming teamIds[1] is Team 1
          .length;
      final team2PlayerCount = playerProvider.selectedPlayers
          .where((e) => e.teamId == teamIds[0]) // Assuming teamIds[0] is Team 2
          .length;

      final allDesignationsSelected =
          playerProvider.playerDesignation.data!.every((designation) {
        return playerProvider.selectedPlayers.any((e) =>
            e.designationId == designation.id ||
            e.designationName.toString().toLowerCase() ==
                designation.shortTerm.toString().toLowerCase());
      });

      final isElevenPlayersSelected = selectedPlayerCount == 11;
      final isMinOnePlayerEachTeam =
          team1PlayerCount > 0 && team2PlayerCount > 0;
      return ContainerConst(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonConst(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (_) {
                      return const TeamPreviewScreen();
                    });
              },
              borderRadius: BorderRadius.circular(25),
              label: "preview".toUpperCase(),
              width: Sizes.screenWidth / 3.5,
              height: 40,
              icon: Icons.remove_red_eye,
              iconColor: AppColor.whiteColor,
              color: AppColor.blackColor,
              textColor: AppColor.whiteColor,
            ),
            Sizes.spaceWidth15,
            ButtonConst(
              onTap: () {
                if (isElevenPlayersSelected &&
                    allDesignationsSelected &&
                    isMinOnePlayerEachTeam) {
                  Navigator.pushNamed(context, AppRoutes.chooseTeamCAndVC);
                } else {
                  if (kDebugMode) {
                    print(
                        "Please select exactly 11 players, with at least one player from each team, to proceed");
                  }
                }
              },
              label: "next".toUpperCase(),
              height: 40,
              borderRadius: BorderRadius.circular(25),
              width: 90,
              color: (isElevenPlayersSelected &&
                      allDesignationsSelected &&
                      isMinOnePlayerEachTeam)
                  ? AppColor.activeButtonGreenColor
                  : Colors.grey.shade500,
              textColor: AppColor.whiteColor,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      );
    });
  }
}
