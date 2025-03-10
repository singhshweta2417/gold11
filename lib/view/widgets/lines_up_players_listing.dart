import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gold11/view_model/game_view_model.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/player_view_model.dart';

class LineupPlayerListing extends StatefulWidget {
  const LineupPlayerListing({
    super.key,
  });

  @override
  State<LineupPlayerListing> createState() => _LineupPlayerListingState();
}

class _LineupPlayerListingState extends State<LineupPlayerListing> {
  @override
  Widget build(BuildContext context) {
    final gvmCon = Provider.of<GameViewModel>(context);
    final teamId = jsonDecode(gvmCon.selectedMatch.teamId ?? "");
    print("team id is $teamId");
    return Consumer<PlayerViewModel>(builder: (context, pvmCon, child) {
      final players = pvmCon.playerData.data!;
      final teamOne = players.where((e) => e.teamId == teamId[0]).toList();
      final teamTwo = players.where((e) => e.teamId == teamId[1]).toList();

      final teamOneAnnounced =
          teamOne.where((e) => e.playingStatus.toString() == '1').toList();
      final teamOneUnannounced =
          teamOne.where((e) => e.playingStatus.toString() == '2').toList();

      final teamTwoAnnounced =
          teamTwo.where((e) => e.playingStatus.toString() == '1').toList();
      final teamTwoUnannounced =
          teamTwo.where((e) => e.playingStatus.toString() == '2').toList();


      final teamOnePlayedLastMatch = teamOne
          .where((e) =>
      e.playingStatus.toString() == '0' && e.playedLastMatch.toString() == '1')
          .toList();

      final teamOneOtherTeam = teamOne
          .where((e) =>
      e.playingStatus.toString() == '0' && e.playedLastMatch.toString() == '0')
          .toList();

      final teamTwoPlayedLastMatch = teamTwo
          .where((e) =>
      e.playingStatus.toString() == '0' && e.playedLastMatch.toString() == '1')
          .toList();

      final teamTwoOtherTeam = teamTwo
          .where((e) =>
      e.playingStatus.toString() == '0' && e.playedLastMatch.toString() == '0')
          .toList();

      final teamOneSelectedCount =
          pvmCon.selectedPlayers.where((e) => e.teamId == teamId[0]).length;
      final teamTwoSelectedCount =
          pvmCon.selectedPlayers.where((e) => e.teamId == teamId[1]).length;
      final totalSelectedPlayers = pvmCon.selectedPlayers.length;
      return ListView(
        children: [
          teamOneAnnounced.isNotEmpty||teamTwoAnnounced.isNotEmpty
              ?    Column(
                children: [
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                        gradient: AppColor.greenGradient
                    ),
                  ),
                  Container(
                          width: 200,
                          height: 25,
                          decoration: const BoxDecoration(
                              color:
                    AppColor.activeButtonGreenColor,

                              borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5))),
                          child: const TextConst(
                            text: 'Announced',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            textColor: AppColor.whiteColor,
                          ),
                        ),
                ],
              ):
          teamOnePlayedLastMatch.isNotEmpty||teamTwoPlayedLastMatch.isNotEmpty
              ? Column(
            children: [
              Container(
                height: 1,
                decoration: const BoxDecoration(
                    gradient: AppColor.blueGradient

                ),
              ),
              Container(
                width: 200,
                height: 25,
                decoration: const BoxDecoration(
                    color:
                    AppColor.textBlueColor,

                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5))),
                child: const TextConst(
                  text: 'played Last match',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  textColor: AppColor.whiteColor,
                ),
              ),
            ],
          ):const SizedBox.shrink(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Sizes.screenWidth / 2.05,
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                      if (teamOneAnnounced.isNotEmpty) ...[
                        ...teamOneAnnounced.map((player) {
                          final playerIndex = players.indexOf(player);
                          final isSelectable = player.isSelected! ||
                              (teamOneSelectedCount < 10 &&
                                  totalSelectedPlayers < 11);
                          final indexColor = player.isSelected!
                              ? Colors.yellow.shade200.withOpacity(0.35)
                              : isSelectable
                                  ? AppColor.whiteColor
                                  : Colors.grey.shade300;
                          return _buildPlayerTile(
                            context,
                            player: player,
                            indexColor: indexColor,
                            isSelectable: isSelectable,
                            onTap: () {
                              if (isSelectable) {
                                pvmCon.togglePlayerSelection(playerIndex);
                              } else {
                                if (kDebugMode) print("Max players selected.");
                              }
                            },
                          );
                        }),
                      ]
                    else
                      ...teamOnePlayedLastMatch.map((player) {
                        final playerIndex = players.indexOf(player);
                        final isSelectable = player.isSelected! ||
                            (teamOneSelectedCount < 10 &&
                                totalSelectedPlayers < 11);
                        final indexColor = player.isSelected!
                            ? Colors.yellow.shade200.withOpacity(0.35)
                            : isSelectable
                            ? AppColor.whiteColor
                            : Colors.grey.shade300;

                        return _buildPlayerTile(
                          context,
                          player: player,
                          indexColor: indexColor,
                          isSelectable: isSelectable,
                          onTap: () {
                            if (isSelectable) {
                              pvmCon.togglePlayerSelection(playerIndex);
                            } else {
                              if (kDebugMode) print("Max players selected.");
                            }
                          },
                        );
                      }),
                    ]



                ),
              ),
              SizedBox(
                width: Sizes.screenWidth / 2.05,
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                      if (teamTwoAnnounced.isNotEmpty) ...[
                        ...teamTwoAnnounced.map((player) {
                          final playerIndex = players.indexOf(player);
                          final isSelectable = player.isSelected! ||
                              (teamTwoSelectedCount < 10 &&
                                  totalSelectedPlayers < 11);
                          final indexColor = player.isSelected!
                              ? Colors.yellow.shade200.withOpacity(0.35)
                              : isSelectable
                                  ? AppColor.whiteColor
                                  : Colors.grey.shade300;

                          return _buildPlayerTile(
                            context,
                            player: player,
                            indexColor: indexColor,
                            isSelectable: isSelectable,
                            onTap: () {
                              if (isSelectable) {
                                pvmCon.togglePlayerSelection(playerIndex);
                              } else {
                                if (kDebugMode) print("Max players selected.");
                              }
                            },
                          );
                        }),
                      ]else  ...teamTwoPlayedLastMatch.map((player) {
                        final playerIndex = players.indexOf(player);
                        final isSelectable = player.isSelected! ||
                            (teamTwoSelectedCount < 10 &&
                                totalSelectedPlayers < 11);
                        final indexColor = player.isSelected!
                            ? Colors.yellow.shade200.withOpacity(0.35)
                            : isSelectable
                            ? AppColor.whiteColor
                            : Colors.grey.shade300;

                        return _buildPlayerTile(
                          context,
                          player: player,
                          indexColor: indexColor,
                          isSelectable: isSelectable,
                          onTap: () {
                            if (isSelectable) {
                              pvmCon.togglePlayerSelection(playerIndex);
                            } else {
                              if (kDebugMode) print("Max players selected.");
                            }
                          },
                        );
                      }),
                  ],
                ),
              ),
            ],
          ),


          teamOneUnannounced.isNotEmpty && teamTwoUnannounced.isNotEmpty
              ?    Column(
            children: [
              Container(
                height: 1,
                decoration: const BoxDecoration(
                    gradient: AppColor.redGradient

                ),
              ),
              Container(
                width: 200,
                height: 25,
                decoration: const BoxDecoration(
                    color:
                    AppColor.primaryRedColor,

                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5))),
                child: const TextConst(
                  text: 'Announced',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  textColor: AppColor.whiteColor,
                ),
              ),
            ],
          )
              :teamOneOtherTeam.isNotEmpty||teamTwoOtherTeam.isNotEmpty?
          Column(
            children: [
              Container(
                height: 1,
                decoration: const BoxDecoration(
                    gradient: AppColor.grayGradient

                ),
              ),
              Container(
                width: 200,
                height: 25,
                decoration: const BoxDecoration(
                    color:
                    AppColor.textGreyColor,

                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5))),
                child: const TextConst(
                  text: 'Other Player',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  textColor: AppColor.whiteColor,
                ),
              ),
            ],
          ):const SizedBox.shrink(),



          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Sizes.screenWidth / 2.05,
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [

                    if (teamOneUnannounced.isNotEmpty) ...[
                      ...teamOneUnannounced.map((player) {
                        final playerIndex = players.indexOf(player);
                        final isSelectable = player.isSelected! ||
                            (teamOneSelectedCount < 10 &&
                                totalSelectedPlayers < 11);
                        final indexColor = player.isSelected!
                            ? Colors.yellow.shade200.withOpacity(0.35)
                            : isSelectable
                            ? AppColor.whiteColor
                            : Colors.grey.shade300;

                        return _buildPlayerTile(
                          context,
                          player: player,
                          indexColor: indexColor,
                          isSelectable: isSelectable,
                          onTap: () {
                            if (isSelectable) {
                              pvmCon.togglePlayerSelection(playerIndex);
                            } else {
                              if (kDebugMode) print("Max players selected.");
                            }
                          },
                        );
                      }),
                    ]
                    else ...teamOneOtherTeam.map((player) {
                      final playerIndex = players.indexOf(player);
                      final isSelectable = player.isSelected! ||
                          (teamOneSelectedCount < 10 &&
                              totalSelectedPlayers < 11);
                      final indexColor = player.isSelected!
                          ? Colors.yellow.shade200.withOpacity(0.35)
                          : isSelectable
                          ? AppColor.whiteColor
                          : Colors.grey.shade300;
                      return _buildPlayerTile(
                        context,
                        player: player,
                        indexColor: indexColor,
                        isSelectable: isSelectable,
                        onTap: () {
                          if (isSelectable) {
                            pvmCon.togglePlayerSelection(playerIndex);
                          } else {
                            if (kDebugMode) print("Max players selected.");
                          }
                        },
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(
                width: Sizes.screenWidth / 2.05,
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [

                    if (teamTwoUnannounced.isNotEmpty) ...[
                      ...teamTwoUnannounced.map((player) {
                        final playerIndex = players.indexOf(player);
                        final isSelectable = player.isSelected! ||
                            (teamTwoSelectedCount < 10 &&
                                totalSelectedPlayers < 11);
                        final indexColor = player.isSelected!
                            ? Colors.yellow.shade200.withOpacity(0.35)
                            : isSelectable
                            ? AppColor.whiteColor
                            : Colors.grey.shade300;

                        return SizedBox(
                          width: Sizes.screenWidth / 2.05,
                          child: _buildPlayerTile(
                            context,
                            player: player,
                            indexColor: indexColor,
                            isSelectable: isSelectable,
                            onTap: () {
                              if (isSelectable) {
                                pvmCon.togglePlayerSelection(playerIndex);
                              } else {
                                if (kDebugMode) print("Max players selected.");
                              }
                            },
                          ),
                        );
                      }),
                    ]
                    else   ...teamTwoOtherTeam.map((player) {
                      final playerIndex = players.indexOf(player);
                      final isSelectable = player.isSelected! ||
                          (teamTwoSelectedCount < 10 &&
                              totalSelectedPlayers < 11);
                      final indexColor = player.isSelected!
                          ? Colors.yellow.shade200.withOpacity(0.35)
                          : isSelectable
                          ? AppColor.whiteColor
                          : Colors.grey.shade300;

                      return SizedBox(
                        width: Sizes.screenWidth / 2.05,
                        child: _buildPlayerTile(
                          context,
                          player: player,
                          indexColor: indexColor,
                          isSelectable: isSelectable,
                          onTap: () {
                            if (isSelectable) {
                              pvmCon.togglePlayerSelection(playerIndex);
                            } else {
                              if (kDebugMode) print("Max players selected.");
                            }
                          },
                        ),
                      );
                    }),


                  ],
                ),
              ),

            ],
          ),
          SizedBox(height: Sizes.screenHeight*0.08,)


        ],
      );
    });
  }

  Widget _buildPlayerTile(BuildContext context,
      {required player,
        required Color indexColor,
        required bool isSelectable,
        required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ContainerConst(
        color: indexColor,
        onTap: onTap,
        padding:
        const EdgeInsets.only(right: 10, left: 10, top: 7, bottom: 7),
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColor.scaffoldBackgroundColor,
          ),
        ),
        child: Row(
          children: [
            // Player Image
            ContainerConst(
              height: 40,
              width: 40,
              color: AppColor.scaffoldBackgroundColor,
              image: DecorationImage(
                image: NetworkImage(player.playerImage ?? ""),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            Sizes.spaceWidth5,
            // Player Name and Details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextConst(
                  alignment: Alignment.centerLeft,
                  width: Sizes.screenWidth / 5,
                  overflow: TextOverflow.ellipsis,
                  text: player.playerName ?? "",
                  fontSize: Sizes.fontSizeOne,
                ),
                TextConst(
                  text: "${player.designationName} - ${player.seriesPoints} pts",
                  textColor: AppColor.textGreyColor,
                  fontSize: Sizes.fontSizeZero,
                ),

              ],
            ),
            const Spacer(),
            // Action Icon
            player.isSelected!
                ? const Icon(
              Icons.remove_circle_outline,
              color: AppColor.primaryRedColor,
            )
                : Icon(
              Icons.add_circle_outline_sharp,
              color: isSelectable
                  ? AppColor.activeButtonGreenColor
                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
