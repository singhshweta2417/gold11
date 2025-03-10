import 'package:flutter/material.dart';
import 'package:gold11/new_pages_by_harsh/live_match/live_team_preview.dart';
import 'package:gold11/res/dedline_passed_screen.dart';
import 'package:gold11/view/contest/contest_screen.dart';
import 'package:gold11/view_model/player_view_model.dart';
import 'package:provider/provider.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/contest_view_model.dart';

class MyContestList extends StatelessWidget {
  final String? time;
  const MyContestList({
    super.key,
    this.time,
  });
  bool _isTimeValid(String? contestTime) {
    if (contestTime == null || contestTime.isEmpty)
      return false; // Updated null check
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
        final contests = contestProvider.contestData.myContest ?? [];

        if (contests.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Utils.noDataAvailableContest(
                  titleLabel: '',
                  messageLabel:
                      "You haven't joined a contest yet!\n Find a contest to join and start winning",
                  buttonLabel: 'Join a Contest',
                  buttonWidth: Sizes.screenWidth * 0.45,
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContestScreen()));
                  }),
            ],
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          shrinkWrap: true,
          itemCount: contests.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final contest = contests[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ContainerConst(
                onTap: () {
                  if (time == null || _isTimeValid(time)) {
                    contestProvider.getContestDetail(
                        context, contest.contestId?.toString() ?? '');
                    Navigator.pushNamed(
                      context,
                      AppRoutes.contestDetailScreen,
                      arguments: {"contestDetail": contest},
                    );
                  } else {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return const DedlinePassedScreen();
                        });
                  }
                },
                color: AppColor.whiteColor,
                border: Border.all(
                    width: 2, color: AppColor.scaffoldBackgroundColor),
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Sizes.spaceHeight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextConst(
                              padding: EdgeInsets.only(top: 10, left: 15),
                              textAlign: TextAlign.left,
                              text: "Prize Pool",
                              alignment: Alignment.centerLeft,
                            ),
                            TextConst(
                              padding: const EdgeInsets.only(top: 5, left: 15),
                              textAlign: TextAlign.left,
                              text: "₹ ${contest.firstPrize.toString()}",
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              textColor: AppColor.blackColor,
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextConst(
                              padding: EdgeInsets.only(top: 10, right: 15),
                              textAlign: TextAlign.left,
                              text: "Entry",
                              alignment: Alignment.centerLeft,
                            ),
                            TextConst(
                              padding: const EdgeInsets.only(top: 5, right: 15),
                              textAlign: TextAlign.left,
                              text: "₹ ${contest.entryFee.toString()}",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              textColor: AppColor.blackColor,
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Sizes.spaceHeight10,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: LinearProgressIndicator(
                        value: (int.parse(contest.totalSpot.toString()) -
                                double.parse(contest.leftSpots.toString())) /
                            int.parse(contest.totalSpot.toString()),
                        backgroundColor: Colors.grey.shade300,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextConst(
                            text: "${contest.leftSpots ?? "0"} spots left",
                            width: Sizes.screenWidth / 2.5,
                            alignment: Alignment.centerLeft,
                            textColor: AppColor.primaryRedColor,
                            fontSize: Sizes.fontSizeOne,
                          ),
                          TextConst(
                            text: contest.totalSpot ?? "0",
                            width: Sizes.screenWidth / 2.5,
                            alignment: Alignment.centerRight,
                            fontSize: Sizes.fontSizeOne,
                            textColor: AppColor.textGreyColor,
                          ),
                        ],
                      ),
                    ),
                    ContainerConst(
                      padding: const EdgeInsets.only(
                          left: 15, top: 8, bottom: 8, right: 15),
                      color: AppColor.scaffoldBackgroundColor.withOpacity(0.6),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.assetsStraightCoinReward,
                            width: 18,
                          ),
                          TextConst(
                            text:
                                "${Utils.rupeeSymbol} ${contest.firstPrize ?? 0}",
                            fontSize: Sizes.fontSizeOne,
                            textColor: AppColor.textGreyColor,
                          ),
                          Sizes.spaceWidth10,
                          const Icon(
                            Icons.emoji_events_outlined,
                            size: 15,
                            color: AppColor.textGreyColor,
                          ),
                          TextConst(
                            text: "",
                            fontSize: Sizes.fontSizeOne,
                            textColor: AppColor.textGreyColor,
                          ),
                          Sizes.spaceWidth10,
                          ContainerConst(
                            width: 16,
                            height: 16,
                            border: Border.all(
                                color: AppColor.blackColor.withOpacity(0.5)),
                            shape: BoxShape.circle,
                            child: TextConst(
                              text: contest.entryLimit == 'Single' ? 'S' : 'M',
                              fontSize: Sizes.fontSizeZero,
                              textColor: AppColor.textGreyColor,
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
                            text: contest.contestSuccessType ?? "Not available",
                            width: Sizes.screenWidth / 3,
                            alignment: Alignment.centerRight,
                            fontSize: Sizes.fontSizeOne,
                          ),
                        ],
                      ),
                    ),
                    ExpansionTile(
                      title: TextConst(
                        text: "Joined with ${contest.teams?.length ?? 0} Team",
                        alignment: Alignment.centerLeft,
                        textColor: AppColor.textGreyColor,
                      ),
                      subtitle: ContainerConst(
                        child: TextConst(
                          text: contest.teamNames ?? "",
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      children: List.generate(contest.teams?.length ?? 0, (i) {
                        final contestTeamData = contest.teams![i];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LiveTeamPreview(
                                  type: 3,
                                  data: null,
                                  data2: null,
                                  data3: null,
                                  data4: contestTeamData,
                                ),
                              ),
                            );
                          },
                          child: ContainerConst(
                            // color: Colors.yellow.shade200.withOpacity(0.35),
                            margin: const EdgeInsets.only(bottom: 10),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 2,
                                color: AppColor.scaffoldBackgroundColor),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      child: TextConst(
                                        text: contestTeamData.teamName ??
                                            "No name",
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        final pvmCon =
                                            Provider.of<PlayerViewModel>(
                                                context,
                                                listen: false);
                                        // List<TeamPlayerList> data=
                                        // // final data =
                                        // pvmCon.playerData.data!
                                        //     .where((e) => e.teamId.toString() == contestTeamData.id.toString())
                                        //     .toList();
                                        print(
                                            contestTeamData.playerlist!.length);
                                        pvmCon.clearSelectedPlayerList();
                                        pvmCon.setUpdateTeam(
                                            true, contest.id ?? 0);
                                        pvmCon.getUpdateTeamData(
                                            contestTeamData.playerlist);
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.createTeamScreen,
                                          arguments: {"allowEdit": true},
                                        );
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    Sizes.spaceWidth10,
                                    const Icon(Icons.swap_horiz),
                                  ],
                                ),
                                Sizes.spaceHeight10,
                                SizedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColor
                                                  .activeButtonGreenColor,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    contestTeamData
                                                        .captainImage),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextConst(
                                                text: "C",
                                                textColor:
                                                    AppColor.textGreyColor,
                                                fontSize: Sizes.fontSizeTwo,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              TextConst(
                                                text: contestTeamData
                                                        .captainName ??
                                                    "No captain",
                                                alignment: Alignment.centerLeft,
                                                fontSize: Sizes.fontSizeOne,
                                                fontWeight: FontWeight.w700,
                                                textColor: AppColor.blackColor,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                width: 100,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColor
                                                  .activeButtonGreenColor,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    contestTeamData
                                                        .viceCaptainImage),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextConst(
                                                text: "VC",
                                                textColor:
                                                    AppColor.textGreyColor,
                                                fontSize: Sizes.fontSizeTwo,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              TextConst(
                                                text: contestTeamData
                                                        .viceCaptainName ??
                                                    "No captain",
                                                alignment: Alignment.centerLeft,
                                                fontSize: Sizes.fontSizeOne,
                                                fontWeight: FontWeight.w700,
                                                textColor: AppColor.blackColor,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                width: 100,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
