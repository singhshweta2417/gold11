import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gold11/new_pages_by_harsh/live_match/live_match_view.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view/contest/contest_screen.dart';
import 'package:gold11/view_model/contest_view_model.dart';
import 'package:gold11/view_model/game_view_model.dart';
import 'package:gold11/view_model/player_view_model.dart';
import 'package:provider/provider.dart';

class MyMatchListing extends StatefulWidget {
  final int index;

  const MyMatchListing({super.key,  required  this.index});

  @override
  MyMatchListingState createState() => MyMatchListingState();
}

class MyMatchListingState extends State<MyMatchListing> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String getTimeLeft(
      DateTime startDate,
      BuildContext context,
      ) {

    final now = DateTime.now();
    final difference = startDate.difference(now);
    DateFormat dateFormat = DateFormat("d MMM");
final gameData=Provider.of<GameViewModel>(context, listen: false);
    if (difference.inDays == 0) {
      if (difference.inHours >= 1) {
        int hours = difference.inHours;
        int minutes = difference.inMinutes % 60;
        return '$hours h $minutes m';
      } else if (difference.inMinutes >= 1) {
        int minutes = difference.inMinutes;
        int seconds = difference.inSeconds % 60;
        return '$minutes m $seconds s';
      } else if (difference.inSeconds == 0) {
        gameData.getGameData(context,"1");
        return 'Refreshing...';
      } else {
        return '${difference.inSeconds} s';
      }
    } else if (difference.inDays == 1) {
      return 'Tomorrow';
    } else {
      return dateFormat.format(startDate);
    }
  }

  Future<void> _refreshMatches() async {
    // Provider.of<GameViewModel>(context, listen: false).getGameType(context);
    // Provider.of<PlayerViewModel>(context, listen: false).getPlayerDesignation(context);
    // Provider.of<ContestViewModel>(context, listen: false)
    //     .setEnableJoinContestBottomSheet(false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameViewModel>(builder: (context, gameProvider, child) {
      final matchData = widget.index == 0
          ? gameProvider.gameData.myUpcomingMatch
          : widget.index == 1
          ? gameProvider.gameData.live
          : gameProvider.gameData.complete;

      final isMatchDataEmpty = matchData == null || matchData.isEmpty;
        return RefreshIndicator(
          color: Colors.white,
          backgroundColor: AppColor.primaryRedColor,
          strokeWidth: 4.0,
          onRefresh: _refreshMatches,
          child: isMatchDataEmpty
              ?
          Utils.noDataAvailableVector(messageLabel: "Oops! No Data Found")
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: matchData.length,
                  shrinkWrap: true,
                  itemBuilder: (_, int i) {
                    final match = matchData[i];
                    final date =
                        DateFormat("yyyy-MM-dd HH:mm:ss").parse(match.startDate);

                    final startDate = DateTime.parse(match.startDate!);
                    final timeLeft = getTimeLeft(startDate,context);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Provider.of<GameViewModel>(context, listen: false)
                              .setSelectedMatch(match);
                          if (match.status == 2) {
                            WidgetsBinding.instance.addPostFrameCallback((_) async {
                              Provider.of<PlayerViewModel>(context, listen: false)
                                  .getTeam(context);
                              Provider.of<PlayerViewModel>(context, listen: false)
                                  .getPlayerDesignation(context);
                              Provider.of<ContestViewModel>(context, listen: false)
                                  .setEnableJoinContestBottomSheet(false);
                              await Provider.of<ContestViewModel>(context,
                                      listen: false)
                                  .getContestData(context, match.id.toString());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LiveMatchView(data: match)));
                            });
                          } else if (match.status == 3) {
                            WidgetsBinding.instance.addPostFrameCallback((_) async {
                              Provider.of<PlayerViewModel>(context, listen: false)
                                  .getTeam(context);
                              Provider.of<PlayerViewModel>(context, listen: false)
                                  .getPlayerDesignation(context);
                              Provider.of<ContestViewModel>(context, listen: false)
                                  .setEnableJoinContestBottomSheet(false);
                              await Provider.of<ContestViewModel>(context,
                                      listen: false)
                                  .getContestData(context, match.id.toString());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LiveMatchView(data: match)));
                            });
                          } else {
                            WidgetsBinding.instance.addPostFrameCallback((_) async {
                              Provider.of<PlayerViewModel>(context, listen: false)
                                  .getPlayerDesignation(context);
                              Provider.of<ContestViewModel>(context, listen: false)
                                  .setEnableJoinContestBottomSheet(false);
                              Provider.of<ContestViewModel>(context, listen: false)
                                  .getContestData(context, match.id.toString());
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> ContestScreen(data: match.startDate.toString())));
                             // Navigator.pushNamed(context, AppRoutes.contestScreen, );
                            });
                          }
                        },
                        child: ContainerConst(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColor.scaffoldBackgroundColor, width: 2),
                          child: Column(
                            children: [

                              ContainerConst(
                                color: AppColor.scaffoldBackgroundColor
                                    .withOpacity(0.8),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextConst(
                                        text: match.seriesName ?? "",
                                        fontSize: Sizes.fontSizeZero),
                                    match.status == 3
                                        ? TextConst(
                                            text: DateFormat('d MMM,h:mm a')
                                                .format(date),
                                            fontSize: Sizes.fontSizeZero,
                                          )
                                        : match.status == 1 && match.isLineUp == 1
                                            ? TextConst(
                                                textColor:
                                                    AppColor.activeButtonGreenColor,
                                                text: 'LineUps Out',
                                                fontSize: Sizes.fontSizeZero,
                                              )
                                            : const SizedBox.shrink()
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    // clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        top: 2,
                                        left: -20,
                                        child: ContainerConst(
                                          shape: BoxShape.circle,
                                          width: 55,
                                          height: 55,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                match.homeTeamImage.toString(),
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Positioned(
                                        top: 2,
                                        left: -20,
                                        child: ContainerConst(
                                          width: 55,
                                          height: 55,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Sizes.screenWidth / 3.5,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              child: Row(
                                                children: [
                                                  ContainerConst(
                                                    color: Colors.transparent,
                                                    shape: BoxShape.circle,
                                                    width: 38,
                                                    height: 38,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          match.homeTeamImage
                                                              .toString(),
                                                        ),
                                                        fit: BoxFit.fill),
                                                  ),
                                                  Sizes.spaceWidth5,
                                                  TextConst(
                                                    text:
                                                    match.homeTeamShortName ??
                                                        "",
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Sizes.spaceHeight5,
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: TextConst(
                                                alignment:
                                                FractionalOffset.centerLeft,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                text: match.homeTeamName ?? "",
                                                textColor: AppColor.textGreyColor,
                                                fontSize: Sizes.fontSizeOne,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  match.status == 2
                                      ? ContainerConst(
                                    width: 60,
                                    color: AppColor.primaryRedColor
                                        .withOpacity(0.1),
                                    child: const TextConst(
                                      text: "• Live",
                                      textColor: AppColor.primaryRedColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                      : match.status == 3
                                      ? const TextConst(
                                    text: "Completed",
                                    textColor: AppColor.textGreyColor,
                                  )
                                      : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ContainerConst(
                                        width: Sizes.screenWidth / 4,
                                        color: timeLeft == 'Tomorrow'
                                            ? Colors.transparent
                                            : (timeLeft.contains('h') ||
                                            timeLeft.contains(
                                                'm') ||
                                            timeLeft
                                                .contains('s'))
                                            ? AppColor
                                            .primaryRedColor
                                            .withOpacity(0.1)
                                            : Colors.transparent,
                                        child: TextConst(
                                          text: timeLeft,
                                          textColor: timeLeft ==
                                              'Tomorrow'
                                              ? Colors.black
                                              : (timeLeft.contains(
                                              'h') ||
                                              timeLeft.contains(
                                                  'm') ||
                                              timeLeft.contains(
                                                  's'))
                                              ? AppColor
                                              .primaryRedColor
                                              : Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Sizes.spaceHeight5,
                                      TextConst(
                                        text: DateFormat('h:mm a')
                                            .format(startDate),
                                        fontSize: Sizes.fontSizeOne,
                                        height: 1,
                                      ),
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Positioned(
                                        top: 2,
                                        right: -20,
                                        child: ContainerConst(
                                          shape: BoxShape.circle,
                                          width: 55,
                                          height: 55,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                match.visitorTeamImage.toString(),
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Positioned(
                                        top: 2,
                                        right: -20,
                                        child: ContainerConst(
                                          width: 55,
                                          height: 55,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Sizes.screenWidth / 3.5,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  TextConst(
                                                    text: match
                                                        .visitorTeamShortName ??
                                                        "",
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  Sizes.spaceWidth5,
                                                  ContainerConst(
                                                    shape: BoxShape.circle,
                                                    width: 38,
                                                    height: 38,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          match.visitorTeamImage ??
                                                              "",
                                                        ),
                                                        fit: BoxFit.fill),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Sizes.spaceHeight5,
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: TextConst(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                alignment:
                                                FractionalOffset.centerRight,
                                                text: match.visitorTeamName ?? "",
                                                textColor: AppColor.textGreyColor,
                                                fontSize: Sizes.fontSizeOne,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 1,
                                color: AppColor.scaffoldBackgroundColor,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8)),
                                    gradient: match.status == 3 &&
                                            match.totalWinnings.toString() != '0.00'
                                        ? AppColor.greenWhiteGradient
                                        : null),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (match.status == 2 ||
                                          match.status == 3 ||
                                          match.status == 1)
                                        TextConst(
                                          text:
                                              "${match.totalJoinedTeam} Team • ${match.totalJoinedContest} Contest",
                                          fontSize: Sizes.fontSizeZero,
                                          textColor: AppColor.textGreyColor,
                                        ),
                                      match.status == 3
                                          ? TextConst(
                                              text:
                                                  match.totalWinnings.toString() ==
                                                          '0.00'
                                                      ? ''
                                                      : '₹ ${match.totalWinnings}',
                                              fontSize: Sizes.fontSizeTwo,
                                              fontWeight: FontWeight.bold,
                                              textColor:
                                                  AppColor.activeButtonGreenColor,
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      }
    );
  }
}
