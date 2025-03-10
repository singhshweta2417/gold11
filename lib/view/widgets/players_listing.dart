import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gold11/model/player_data_model.dart';
import 'package:gold11/new_pages_by_harsh/single_player_detail.dart';
import 'package:gold11/view_model/game_view_model.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/player_view_model.dart';
import '../../model/player_designation_model.dart';

class PlayersListingUI extends StatefulWidget {
  final DesignationData isPlayerType;
  const PlayersListingUI({super.key, required this.isPlayerType});

  @override
  State<PlayersListingUI> createState() => _PlayersListingUIState();
}

class _PlayersListingUIState extends State<PlayersListingUI> {
  late List<int> teamIds;

  @override
  Widget build(BuildContext context) {
    return Consumer2<PlayerViewModel, GameViewModel>(
        builder: (context, playerProvider, gameProvider, child) {
      final playerData = playerProvider.playerData.data!
          .where((e) =>
              e.designationId.toString() == widget.isPlayerType.id.toString() ||
              e.designationName!.toLowerCase() ==
                  widget.isPlayerType.shortTerm!.toLowerCase())
          .toList(growable: true);

      final maxPlayersSelected = playerProvider.selectedPlayersCount >= 11;

      final announcementPlayers = playerData
          .where((player) => player.playingStatus.toString() == '1')
          .toList();
      final unannouncementPlayers = playerData
          .where((player) => player.playingStatus.toString() == '2')
          .toList();
      final allPlayers = playerData
          .where((player) => player.playingStatus.toString() == '0')
          .toList();
      teamIds =
          List<int>.from(jsonDecode(gameProvider.selectedMatch.teamId ?? "[]"));

      final Map<String, List<PlayerData>> categorizedPlayers = {
        'Announced': announcementPlayers,
        'Unannounced': unannouncementPlayers,
        '': allPlayers,
      };

      return ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          TextConst(
            text: 'Select 1 - 8  ${playerData[0].designationName}',
            fontWeight: FontWeight.bold,
            fontSize: 14,
            textColor: AppColor.blackColor,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              TextConst(
                text: 'Selected By '.toUpperCase(),
                fontWeight: FontWeight.w300,
                fontSize: 14,
                textColor: AppColor.blackColor,
              ),
              const Spacer(),
              TextConst(
                text: 'Points'.toUpperCase(),
                fontWeight: FontWeight.w300,
                fontSize: 14,
                textColor: AppColor.blackColor,
              ),
              const SizedBox(
                width: 10,
              ),
              TextConst(
                text: 'credits ↓'.toUpperCase(),
                fontWeight: FontWeight.w300,
                fontSize: 14,
                textColor: AppColor.blackColor,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          ...categorizedPlayers.entries.map((entry) {
            return Column(
              children: [
                entry.value.isNotEmpty
                    ? _buildPlayerList(
                        entry.value,
                        playerProvider,
                        maxPlayersSelected,
                        entry.key,
                      )
                    : const SizedBox.shrink(),
              ],
            );
          }),
          const SizedBox(height: 80),
        ],
      );
    });
  }

  Widget _buildPlayerList(
    List<PlayerData> playerData,
    PlayerViewModel playerProvider,
    bool maxPlayersSelected,
    String title,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: title == ''
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: title == 'Announced'
                            ? AppColor.greenGradient
                            : AppColor.redGradient,
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 25,
                      decoration: BoxDecoration(
                          color: title == 'Announced'
                              ? AppColor.activeButtonGreenColor
                              : AppColor.primaryRedColor,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5))),
                      child: TextConst(
                        text: title,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        textColor: AppColor.whiteColor,
                      ),
                    ),
                  ],
                ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: playerData.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, int i) {
            final player = playerData[i];
            final playerIndex = playerProvider.playerData.data!.indexOf(player);

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

            bool isSelectable = player.isSelected! || // Allow deselection
                (totalSelectedPlayers < maxTotalPlayers &&
                    (((player.designationName == "WK" &&
                                wkCount < maxPlayersPerRole) ||
                            (player.designationName == "BAT" &&
                                batCount < maxPlayersPerRole) ||
                            (player.designationName == "AR" &&
                                arCount < maxPlayersPerRole) ||
                            (player.designationName == "BOWL" &&
                                bowlCount < maxPlayersPerRole)) &&
                        ((player.teamId == teamIds[1] &&
                                !isMaxPlayersForTeam1) ||
                            (player.teamId == teamIds[0] &&
                                !isMaxPlayersForTeam2))));

            playerProvider.canAddPlayer(player.designationName!);
            if (!playerProvider.canAddPlayer(player.designationName!) &&
                !player.isSelected!) {
              isSelectable = false;
            }
            final indexColor = player.isSelected!
                ? Colors.yellow.shade200.withOpacity(0.35)
                : isSelectable
                    ? AppColor.whiteColor
                    : Colors.grey.shade300;

            return Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: ContainerConst(
                color: indexColor,
                onTap: () {
                  if (isSelectable) {
                    playerProvider.togglePlayerSelection(playerIndex);
                  } else {
                    if (kDebugMode) {
                      print(
                          "Max players selected for the team. Cannot select more.");
                    }
                  }
                },
                padding: const EdgeInsets.only(
                    right: 10, left: 10, top: 7, bottom: 7),
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: AppColor.scaffoldBackgroundColor,
                  ),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        ContainerConst(
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (_) {
                                  return SinglePlayerDetail(
                                      data: player, playerIndex: playerIndex);
                                });
                          },
                          height: 60,
                          width: 60,
                          image: DecorationImage(
                            image: NetworkImage(player.playerImage ?? ""),
                            fit: BoxFit.fill,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 2,
                          child: ContainerConst(
                            height: 15,
                            width: 40,
                            borderRadius: BorderRadius.circular(5),
                            color: AppColor.whiteColor,
                            child: TextConst(
                              alignment: Alignment.center,
                              text: player.teamShortName ?? "",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 2,
                          child: ContainerConst(
                            height: 15,
                            width: 15,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColor.textGreyColor),
                            color: AppColor.whiteColor,
                            child: const Center(
                              child: TextConst(
                                alignment: Alignment.center,
                                text: 'i',
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Sizes.spaceWidth5,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextConst(
                          alignment: Alignment.topLeft,
                          text: player.playerName ?? "",
                          fontWeight: FontWeight.w600,
                          width: 150,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            player.playingStatus.toString() == '0'
                                ? const SizedBox.shrink()
                                : TextConst(
                                    text: " • ",
                                    fontSize: 25,
                                    textColor: player.playingStatus
                                                .toString() ==
                                            '1'
                                        ? AppColor.activeButtonGreenColor
                                        : player.playingStatus.toString() == '2'
                                            ? AppColor.primaryRedColor
                                            : Colors.transparent,
                                  ),
                            Container(
                              height: 15,
                              width: 2,
                              color: Colors.black54,
                            ),
                            TextConst(
                              text: " Sel by ${player.seriesPoints} % ",
                              textColor: AppColor.textGreyColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    TextConst(
                      text: player.seriesPoints.toString(),
                      textColor: AppColor.textGreyColor,
                      width: 50,
                    ),
                    TextConst(
                      text: player.creditPoints.toString(),
                      fontWeight: FontWeight.w600,
                      width: 50,
                    ),
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
          },
        ),
      ],
    );
  }
}
