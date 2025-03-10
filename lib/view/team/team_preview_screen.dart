import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gold11/model/player_designation_model.dart';
import 'package:gold11/view_model/player_view_model.dart';
import 'package:gold11/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';

import '../../view_model/game_view_model.dart';

class TeamPreviewScreen extends StatefulWidget {
  const TeamPreviewScreen({super.key});

  @override
  State<TeamPreviewScreen> createState() => _TeamPreviewScreenState();
}

class _TeamPreviewScreenState extends State<TeamPreviewScreen> {


  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(builder: (context, provider, child) {
      return ContainerConst(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBarSection(),
            Expanded(
              child: ContainerConst(
                  width: Sizes.screenWidth,
                  alignment: Alignment.topCenter,
                  image: const DecorationImage(
                      image: AssetImage(Assets.assetsPredctonBgPtch),
                      fit: BoxFit.fill),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.playerDesignation.data!.length,
                      itemBuilder: (_, i) {
                        return ContainerConst(
                          margin: const EdgeInsets.only(top: 7),
                          height: Sizes.screenHeight / 5,
                          width: Sizes.screenWidth,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          child: playerListing(
                              provider.playerDesignation.data![i]),
                        );
                      })),
            )
          ],
        ),
      );
    });
  }

  Widget appBarSection() {
    final matchData = Provider.of<GameViewModel>(context).selectedMatch;
    return Consumer<PlayerViewModel>(builder: (context, provider, child) {
      final playerCount = provider.selectedPlayersCount;
      final gvmCon = Provider.of<GameViewModel>(context);
      final teamId = jsonDecode(gvmCon.selectedMatch.teamId ?? "");

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
              title: TextConst(
                text: Provider.of<ProfileViewModel>(context)
                    .userProfile!
                    .data!
                    .name,
                textColor: AppColor.whiteColor,
                alignment: Alignment.centerLeft,
                fontWeight: FontWeight.w600,
                fontSize: Sizes.fontSizeThree,
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
                          text: "$playerCount",
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
                      text:
                          "${provider.selectedPlayers.where((data) => data.teamId == teamId[0] && data.isSelected == true).length}",
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
                      text:
                          "${provider.selectedPlayers.where((data) => data.teamId == teamId[1] && data.isSelected == true).length}",
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextConst(
                      text: "Credits Left",
                      textColor:
                          AppColor.scaffoldBackgroundColor.withOpacity(0.7),
                      fontSize: Sizes.fontSizeOne,
                      alignment: Alignment.centerRight,
                    ),
                    TextConst(
                      text:
                          provider.totalSelectedPlayersPrice.toStringAsFixed(0),
                      textColor: AppColor.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.fontSizeThree,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
  Widget playerListing(DesignationData designationData) {
    final gvmCon = Provider.of<GameViewModel>(context);
    final teamId = jsonDecode(gvmCon.selectedMatch.teamId ?? "");
    return Consumer<PlayerViewModel>(builder: (context, provider, child) {
      final playerList = provider.selectedPlayers
          .where((e) => e.designationId == designationData.id || e.designationName == designationData.shortTerm)
          .toList();
      return Column(
        children: [
          TextConst(
            text: designationData.title.toString(),
            textColor: AppColor.whiteColor,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.fontSizeOne,
          ),
          Sizes.spaceHeight10,
          Wrap(
            spacing:playerList.length==5?Sizes.screenWidth / 5:playerList.length==6?Sizes.screenWidth/8:playerList.length==7?Sizes.screenWidth/10: Sizes.screenWidth / 15,
            runSpacing: 10.0,
            alignment: WrapAlignment.spaceEvenly,
            children: List.generate(
              playerList.length,
              (i) {
                final player = playerList[i];
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if(provider.captain != null && provider.captain!.id == player.id)
                    Positioned(
                      top: -5,
                      left: -8,
                      child: ContainerConst(
                        width: MediaQuery.of(context).size.width / 15,
                        padding: const EdgeInsets.all(2),
                        border: Border.all(
                          color: player.teamId == teamId[1]
                              ? AppColor.whiteColor
                              : AppColor.textGreyColor,
                          width: 1.5,
                        ),
                        shape: BoxShape.circle,
                        color:player.teamId == teamId[1]
                            ? AppColor.textGreyColor
                            : AppColor.whiteColor,
                        child: TextConst(
                          text:"C",
                          textColor: player.teamId == teamId[1]
                              ? AppColor.whiteColor
                              : AppColor.textGreyColor,
                          fontSize: Sizes.fontSizeZero,
                        ),
                      ),
                    ),
                    if(provider.viceCaptain != null && provider.viceCaptain!.id == player.id)
                      Positioned(
                        top: -5,
                        left: -8,
                        child: ContainerConst(
                          width: MediaQuery.of(context).size.width / 15,
                          padding: const EdgeInsets.all(2),
                          border: Border.all(
                            color: player.teamId == teamId[1]
                                ? AppColor.whiteColor
                                : AppColor.textGreyColor,
                            width: 1.5,
                          ),
                          shape: BoxShape.circle,
                          color:player.teamId == teamId[1]
                              ? AppColor.textGreyColor
                              : AppColor.whiteColor,
                          child: TextConst(
                            text:"VC",
                            textColor: player.teamId == teamId[1]
                                ? AppColor.whiteColor
                                : AppColor.textGreyColor,
                            fontSize: Sizes.fontSizeZero,
                          ),
                        ),
                      ),
                    SizedBox(
                      width: Sizes.screenWidth/8,
                      child: Column(
                        children: [
                          ContainerConst(
                            height: 40,
                            width: 40,
                            image: DecorationImage(
                                image: NetworkImage(player.playerImage ?? ""),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter),
                            alignment: Alignment.bottomCenter,
                          ),
                          ContainerConst(
                              borderRadius: BorderRadius.circular(4),
                              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                              color: player.teamId == teamId[1]
                                  ? AppColor.blackColor
                                  : AppColor.whiteColor,
                              child: TextConst(
                                text: player.playerName ?? "",
                                fontSize: Sizes.fontSizeZero / 1.5,
                                textColor: player.teamId == teamId[1]
                                    ? AppColor.whiteColor
                                    : Colors.black,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
