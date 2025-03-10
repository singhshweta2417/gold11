import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view_model/player_view_model.dart';

import '../../res/sizes_const.dart';
import '../const_widget/text_const.dart';

class ChooseCAndVcFromSelectedPlayersListing extends StatelessWidget {
  const ChooseCAndVcFromSelectedPlayersListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(builder: (context, pvmCon, child) {
      // final maxPlayersSelected = provider.selectedPlayersCount >= 11;
      return ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          shrinkWrap: true,
          itemCount: pvmCon.selectedPlayers.length,
          itemBuilder: (_, int i) {
            final player = pvmCon.selectedPlayers[i];
            const indexColor = AppColor.whiteColor;
            return Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: ContainerConst(
                color: indexColor,
                onTap: () {},
                padding: const EdgeInsets.only(
                    right: 10, left: 10, top: 7, bottom: 7),
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: AppColor.scaffoldBackgroundColor)),
                child: Row(
                  children: [
                    ContainerConst(
                      height: 60,
                      width: 60,
                      image: DecorationImage(
                          image: NetworkImage(player.playerImage ?? ""),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter),
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(CupertinoIcons.info,
                              size: 15, color: Colors.grey.shade400),
                          Container(
                            decoration: const BoxDecoration(
                                color: AppColor.scaffoldBackgroundColorTwo,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextConst(
                                  text: player.teamShortName ?? "",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                                const TextConst(
                                  text: "/",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                                TextConst(
                                  text: player.designationName ?? "",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Sizes.spaceWidth5,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextConst(
                          text: player.playerName ?? "",
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.fontSizeOne,
                          width: 150,
                          alignment: Alignment.centerLeft,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        TextConst(
                          text: '${player.seriesPoints}  pts',
                          textColor: AppColor.textGreyColor,
                          fontSize: Sizes.fontSizeOne,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        ContainerConst(
                          onTap: () {
                            pvmCon.selectCaptain(player);
                          },
                          padding: const EdgeInsets.all(10),
                          border: Border.all(
                              color:
                                  pvmCon.captain == null && pvmCon.captain == player
                                      ? AppColor.blackColor
                                      : Colors.grey.shade400,
                              width: 1.5),
                          shape: BoxShape.circle,
                          color: pvmCon.captain != null &&
                                  pvmCon.captain!.pid == player.pid
                              ? AppColor.blackColor
                              : Colors.transparent,
                          child: TextConst(
                            fontWeight: FontWeight.w600,
                            width: 50,
                            text: pvmCon.captain != null &&
                                    pvmCon.captain!.pid == player.pid ? "2X" : "C",
                            textColor:
                                pvmCon.captain != null && pvmCon.captain == player
                                    ? AppColor.whiteColor
                                    : Colors.grey.shade500,
                            fontSize: Sizes.fontSizeOne,
                          ),
                        ),
                        TextConst(
                          fontSize: Sizes.fontSizeZero,
                          alignment: Alignment.centerLeft,
                          textColor: AppColor.textGreyColor,
                          fontWeight: FontWeight.w600,
                          text: "${player.cBy} %",
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ContainerConst(
                          onTap: () {
                            pvmCon.selectViceCaptain(player);
                          },
                          padding: const EdgeInsets.all(10),
                          border: Border.all(
                              color: pvmCon.captain != null &&
                                      pvmCon.viceCaptain == player
                                  ? AppColor.blackColor
                                  : Colors.grey.shade400,
                              width: 1.5),
                          shape: BoxShape.circle,
                          color: pvmCon.viceCaptain != null &&
                                  pvmCon.viceCaptain!.pid == player.pid
                              ? AppColor.blackColor
                              : Colors.transparent,
                          child: TextConst(
                            fontWeight: FontWeight.w600,
                            width: 50,
                            text: pvmCon.viceCaptain != null &&
                                    pvmCon.viceCaptain!.pid == player.pid
                                ? "1.5X"
                                : "VC",
                            textColor: pvmCon.viceCaptain != null &&
                                    pvmCon.viceCaptain == player
                                ? AppColor.whiteColor
                                : Colors.grey.shade500,
                            fontSize: Sizes.fontSizeOne,
                          ),
                        ),
                        TextConst(
                          fontSize: Sizes.fontSizeZero,
                          alignment: Alignment.centerLeft,
                          textColor: AppColor.textGreyColor,
                          fontWeight: FontWeight.w600,
                          text: "${player.vcBy} %",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }
}
