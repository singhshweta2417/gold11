import 'package:flutter/material.dart';
import 'package:gold11/view/contest/contest_detail.dart';
import 'package:provider/provider.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/dedline_passed_screen.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/contest_view_model.dart';
import 'package:gold11/view_model/player_view_model.dart';

import '../contest/joiin_contest_bottom_sheet.dart';

class ContestsList extends StatelessWidget {
  final String? time;
  const ContestsList({super.key, this.time});

  bool _isTimeValid(String? contestTime) {
    if (contestTime == null || contestTime.isEmpty) {
      return false; // Updated null check
    }
    try {
      final currentTime = DateTime.now();
      final parsedContestTime = DateTime.parse(contestTime);
      return parsedContestTime.isAfter(currentTime) ||
          parsedContestTime.isAtSameMomentAs(currentTime);
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContestViewModel>(
        builder: (context, contestProvider, child) {
      final contests = contestProvider.contestData.contestList;
      switch (contestProvider.dataState) {
        case ContestDataState.loading:
          return Utils.loadingRed;
        case ContestDataState.success:
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            shrinkWrap: true,
            itemCount: contests!.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              String formatCurrency(int value) {
                if (value >= 10000000) {
                  double crores = value / 10000000;
                  String formattedCrores = crores == crores.toInt()
                      ? '${crores.toInt()} Crores'
                      : '${crores.toStringAsFixed(2)} Crores';
                  return formattedCrores;
                } else if (value >= 100000) {
                  double lakhs = value / 100000;
                  String formattedLakhs = lakhs == lakhs.toInt()
                      ? '${lakhs.toInt()} Lakhs'
                      : '${lakhs.toStringAsFixed(2)} Lakhs';
                  return formattedLakhs;
                } else {
                  return '$value';
                }
              }

              final contest = contests[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ContainerConst(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey
                          .withOpacity(0.5), // Shadow color with opacity
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                  onTap: () {
                    if (time == null || _isTimeValid(time)) {
                      contestProvider.setEnableJoinContestBottomSheet(true);
                      contestProvider.setSelectedContestData(contest);
                      contestProvider.getContestDetail(
                          context, contest.id.toString());
                      // Navigator.pushReplacementNamed(
                      //     context, AppRoutes.contestDetailScreen,
                      //     arguments: {"contestDetail": contest});
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContestDetailScreen(
                                    data: contest,
                                    args: {"contestDetail": contest},
                                  )));
                    } else {
                      showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return const DedlinePassedScreen();
                          });
                    }
                  },
                  color: AppColor.whiteColor,
                  border: Border.all(width: 0.5, color: AppColor.textGreyColor),
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            Image.asset(
                              Assets.assetsVerifyed,
                              width: 18,
                            ),
                            TextConst(
                              text: "Prize Pool",
                              alignment: Alignment.centerLeft,
                              fontSize: Sizes.fontSizeOne,
                              textColor: AppColor.textGreyColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        subtitle: TextConst(
                          text:
                              "₹${formatCurrency(int.parse(contest.prizePool))}",
                          width: Sizes.screenWidth / 2.5,
                          alignment: Alignment.centerLeft,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextConst(
                              text: contest.name ?? "Not avl",
                              width: Sizes.screenWidth / 2.5,
                              alignment: Alignment.centerRight,
                              textColor: AppColor.textGreyColor,
                              fontSize: Sizes.fontSizeOne,
                            ),
                            contest.entry.toString() ==
                                    contest.myJoinedCount.toString()
                                ? const SizedBox.shrink()
                                : contest.entryLimit == 'Single' &&
                                        contest.myJoinedCount == 1
                                    ? const SizedBox.shrink()
                                    : contest.leftSpot == 0
                                        ? const SizedBox.shrink()
                                        : InkWell(
                                            onTap: () async {
                                              if (time == null ||
                                                  _isTimeValid(time)) {
                                                contestProvider
                                                    .setEnableJoinContestBottomSheet(
                                                        true);
                                                contestProvider
                                                    .setSelectedContestData(
                                                        contest);
                                                await Provider.of<
                                                            PlayerViewModel>(
                                                        context,
                                                        listen: false)
                                                    .getPlayers(context);
                                                if (Provider.of<
                                                            PlayerViewModel>(
                                                        context,
                                                        listen: false)
                                                    .teamData!
                                                    .data!
                                                    .isEmpty) {
                                                  Navigator.pushReplacementNamed(
                                                      context,
                                                      AppRoutes
                                                          .createTeamScreen);
                                                } else if (Provider.of<
                                                                PlayerViewModel>(
                                                            context,
                                                            listen: false)
                                                        .teamData!
                                                        .data!
                                                        .length ==
                                                    1) {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (_) {
                                                        return const JoinContestBottomSheetScreen();
                                                      });
                                                } else {
                                                  Navigator.pushNamed(
                                                      context,
                                                      AppRoutes
                                                          .selectTeamScreen);
                                                }
                                              } else {
                                                return showModalBottomSheet(
                                                    context: context,
                                                    builder: (_) {
                                                      return const DedlinePassedScreen();
                                                    });
                                              }
                                            },
                                            child: Container(
                                              width: Sizes.screenWidth * 0.18,
                                              height:
                                                  Sizes.screenHeight * 0.038,
                                              decoration: BoxDecoration(
                                                gradient: AppColor
                                                    .greenButtonGradient2,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              alignment: Alignment.center,
                                              child: contest.desprice == "1"
                                                  ? Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "₹${contest.entryFee} ",
                                                          style:
                                                              const TextStyle(
                                                            color: AppColor
                                                                .whiteColor,
                                                            fontSize: 14,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            decorationColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          "₹${contest.desprice}",
                                                          style:
                                                              const TextStyle(
                                                            color: AppColor
                                                                .whiteColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Text(
                                                      "₹${contest.entryFee}",
                                                      style: const TextStyle(
                                                        color:
                                                            AppColor.whiteColor,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                            ),
                                          )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextConst(
                              text: contest.leftSpot == 0
                                  ? 'Full'
                                  : "${contest.leftSpot} spots left",
                              width: Sizes.screenWidth / 2.5,
                              alignment: Alignment.centerLeft,
                              textColor: AppColor.primaryRedColor,
                              fontSize: Sizes.fontSizeOne,
                              fontWeight: FontWeight.w500,
                            ),
                            TextConst(
                              text: contest.totalSpot + ' Spots' ?? "",
                              width: Sizes.screenWidth / 2.5,
                              alignment: Alignment.centerRight,
                              fontSize: Sizes.fontSizeOne,
                              textColor: AppColor.textGreyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: LinearProgressIndicator(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          value: (int.parse(contest.totalSpot.toString()) -
                                  contest.leftSpot) /
                              int.parse(contest.totalSpot.toString()),
                          backgroundColor:
                              Colors.redAccent.shade100.withOpacity(0.3),
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                      Sizes.spaceHeight15,
                      ContainerConst(
                        padding: const EdgeInsets.only(
                            left: 15, top: 8, bottom: 8, right: 15),
                        color:
                            AppColor.scaffoldBackgroundColor.withOpacity(0.6),
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.assetsStraightCoinReward,
                              width: 18,
                            ),
                            TextConst(
                              text:
                                  "${Utils.rupeeSymbol}${contest.firstPrize ?? 0}",
                              fontSize: Sizes.fontSizeOne,
                              textColor: AppColor.blackColor,
                              fontWeight: FontWeight.w500,
                            ),
                            Sizes.spaceWidth10,
                            const Icon(
                              Icons.emoji_events_outlined,
                              size: 15,
                              color: AppColor.textGreyColor,
                            ),
                            TextConst(
                              text: "62%",
                              fontSize: Sizes.fontSizeOne,
                              textColor: AppColor.textGreyColor,
                            ),
                            Sizes.spaceWidth10,
                            ContainerConst(
                              width: 15,
                              height: 15,
                              border: Border.all(
                                  color: AppColor.blackColor.withOpacity(0.7)),
                              borderRadius: BorderRadius.circular(2),
                              child: TextConst(
                                text:
                                    contest.entryLimit == 'Single' ? 'S' : 'M',
                                fontSize: Sizes.fontSizeZero,
                                textColor: AppColor.textGreyColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Sizes.spaceWidth5,
                            TextConst(
                              text: contest.entryLimit ?? "0",
                              fontSize: Sizes.fontSizeOne,
                              textColor: AppColor.textGreyColor,
                            ),
                            const Spacer(),
                            TextConst(
                              text: contest.contestSuccessType ?? "Not avl",
                              width: Sizes.screenWidth / 3,
                              alignment: Alignment.centerRight,
                              fontSize: Sizes.fontSizeOne,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        case ContestDataState.noDataAvl:
          return Utils.noDataAvailableVector();
        case ContestDataState.error:
          return Utils.noDataAvailableVector(
              messageLabel: contestProvider.message);
      }
    });
  }
}
