import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view/contest/contest_screen.dart';
import 'package:gold11/view_model/contest_view_model.dart';
import 'package:gold11/view_model/game_view_model.dart';
import '../../view_model/player_view_model.dart';

class UpcomingMatchListing extends StatefulWidget {
  const UpcomingMatchListing({super.key});

  @override
  _UpcomingMatchListingState createState() => _UpcomingMatchListingState();
}

class _UpcomingMatchListingState extends State<UpcomingMatchListing> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
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
  ) {
    final now = DateTime.now();
    final difference = startDate.difference(now);
    DateFormat dateFormat = DateFormat("d MMM");
    if (difference.inDays == 0) {
      if (difference.inHours >= 1) {
        int hours = difference.inHours;
        int minutes = difference.inMinutes % 60;
        return '$hours h $minutes m';
      } else if (difference.inMinutes >= 1) {
        int minutes = difference.inMinutes;
        int seconds = difference.inSeconds % 60;
        return '$minutes m $seconds s';
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
    Provider.of<GameViewModel>(context, listen: false).gameData.upcoming;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      color: Colors.white,
      backgroundColor: Colors.blue,
      strokeWidth: 4.0,
      onRefresh: _refreshMatches,
      child: Consumer<GameViewModel>(
        builder: (context, gameProvider, child) {
          final upcomingMatches = gameProvider.gameData.upcoming!
              .where((match) =>
                  DateTime.parse(match.startDate!).isAfter(DateTime.now()))
              .toList();
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: upcomingMatches.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (_, int i) {
              final match = upcomingMatches[i];
              final startDate = DateTime.parse(match.startDate!);
              final timeLeft = getTimeLeft(startDate);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ContainerConst(
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      Provider.of<PlayerViewModel>(context, listen: false)
                          .getPlayerDesignation(context);
                      gameProvider.setSelectedMatch(match);
                      Provider.of<ContestViewModel>(context, listen: false)
                          .setEnableJoinContestBottomSheet(false);
                      await Provider.of<ContestViewModel>(context,
                              listen: false)
                          .getContestData(context, match.id.toString());
                     // Navigator.pushNamed(context, AppRoutes.contestScreen);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ContestScreen(data: match.startDate.toString())));

                    });
                  },
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppColor.scaffoldBackgroundColor, width: 2),
                  child: Column(
                    children: [
                      match.isLineUp == 0
                          ? ContainerConst(
                              color: AppColor.whiteColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              gradient: LinearGradient(
                                transform: const GradientRotation(0.35),
                                colors: [
                                  AppColor.scaffoldBackgroundColor
                                      .withOpacity(0.6),
                                  AppColor.whiteColor,
                                ],
                                stops: const [0.75, 0.2],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextConst(
                                      text: match.seriesName.toString(),
                                      fontSize: Sizes.fontSizeZero),
                                  TextConst(
                                    text: "",
                                    fontSize: Sizes.fontSizeZero,
                                    textColor: AppColor.activeButtonGreenColor,
                                  ),
                                ],
                              ),
                            )
                          : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ContainerConst(
                                  width: Sizes.screenWidth*0.65,
                                  color: AppColor.whiteColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                  ),
                                  gradient: LinearGradient(
                                    transform: const GradientRotation(0.35),
                                    colors: [
                                      AppColor.scaffoldBackgroundColor
                                          .withOpacity(0.6),
                                      AppColor.whiteColor,
                                    ],
                                    stops: const [0.9, 0.1],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  child: TextConst(
                                      alignment: Alignment.bottomLeft,
                                      text: match.seriesName.toString(),
                                      fontSize: Sizes.fontSizeZero),
                                ),
                                 ContainerConst(
                                  width: Sizes.screenWidth*0.25,
                                  color: AppColor.whiteColor,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                  ),
                                  gradient: AppColor.greenWhiteGradient2,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  child: const Row(
                                    children: [
                                      TextConst(
                                        text: "Lineups Out",
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        textColor:
                                            AppColor.activeButtonGreenColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  match.homeTeamImage.toString(),
                                                ),
                                                fit: BoxFit.fill
                                            ),
                                          ),

                                          Sizes.spaceWidth5,
                                          TextConst(
                                            text: match.homeTeamShortName ?? "",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Sizes.spaceHeight5,
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: TextConst(
                                        alignment: FractionalOffset.centerLeft,
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
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ContainerConst(
                                width: Sizes.screenWidth / 4,
                                color: timeLeft == 'Tomorrow'
                                    ? Colors.transparent
                                    : (timeLeft.contains('h') ||
                                            timeLeft.contains('m') ||
                                            timeLeft.contains('s'))
                                        ? AppColor.primaryRedColor
                                            .withOpacity(0.1)
                                        : Colors.transparent,
                                child: TextConst(
                                  text: timeLeft,
                                  textColor: timeLeft == 'Tomorrow'
                                      ? Colors.black
                                      : (timeLeft.contains('h') ||
                                              timeLeft.contains('m') ||
                                              timeLeft.contains('s'))
                                          ? AppColor.primaryRedColor
                                          : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Sizes.spaceHeight5,
                              TextConst(
                                text: DateFormat('h:mm a').format(startDate),
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          TextConst(
                                            text: match.visitorTeamShortName ?? "",
                                            fontWeight: FontWeight.bold,
                                          ),
                                          Sizes.spaceWidth5,
                                          ContainerConst(
                                            shape: BoxShape.circle,
                                            width: 38,
                                            height: 38,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  match.visitorTeamImage ?? "",
                                                ),
                                                fit: BoxFit.fill),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Sizes.spaceHeight5,
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: TextConst(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        alignment: FractionalOffset.centerRight,
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
                      Divider(
                          color: AppColor.scaffoldBackgroundColor,
                          thickness: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ContainerConst(
                              width: Sizes.screenWidth / 3.5,
                              borderRadius: BorderRadius.circular(10),
                              color: CupertinoColors.systemYellow
                                  .withOpacity(0.15),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              child: TextConst(
                                text: match.megaContest == null
                                    ? ''
                                    : match.megaContest.toString(),
                                fontSize: Sizes.fontSizeOne,
                              ),
                            ),
                            ContainerConst(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColor.scaffoldBackgroundColor,
                                  width: 1.5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              child:
                                  const Icon(Icons.notification_add_outlined),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

}
