import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gold11/model/game_data_model.dart';
import 'package:gold11/sheemar/home_page_sheemar.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/bottom_navigation/home_section/home_slider_screen.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gold11/view/widgets/upcoming_matches.dart';
import 'package:gold11/view_model/contest_view_model.dart';
import 'package:gold11/view_model/game_view_model.dart';
import 'package:gold11/view_model/player_view_model.dart';
import '../../../generated/assets.dart';
import '../../../new_pages_by_harsh/my_match_complete/complete_match_view.dart';
import '../../../res/color_const.dart';
import '../../../res/sizes_const.dart';
import '../../const_widget/text_const.dart';
import '../../widgets/story_view_widget.dart';

class HomePageTabData extends StatefulWidget {
  const HomePageTabData({
    super.key,
  });

  @override
  State<HomePageTabData> createState() => HomePageTabDataState();
}

final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();

class HomePageTabDataState extends State<HomePageTabData> {
  Future<void> _refreshMatches() async {
    Provider.of<GameViewModel>(context, listen: false).getGameType(context);
  }
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
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      color: Colors.white,
      backgroundColor: AppColor.primaryRedColor,
      strokeWidth: 4.0,
      onRefresh: _refreshMatches,
      child: Consumer<GameViewModel>(builder: (context, gameProvider, child) {
        switch (gameProvider.gameDataState) {
          case GameDataState.loading:
            return const HomePageSheemar();
          case GameDataState.success:
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const StoryListingScreen(),
                  Sizes.spaceHeight10,
                  const HomeSliderScreen(),
                  myMatchSlider(gameProvider),
                  Sizes.spaceHeight10,
                  TextConst(
                    text: AppLocalizations.of(context)!.upcomingMatches,
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.fontSizeThree,
                    alignment: FractionalOffset.centerLeft,
                    padding: const EdgeInsets.only(left: 15),
                  ),
                  const UpcomingMatchListing(),
                ],
              ),
            );
          case GameDataState.noDataAvl:
            return Utils.noDataAvailableVector(
                messageLabel: "Oops! No Data Found",
                image: noDataVectorImage(gameProvider.selectedGameTabIndex));
          case GameDataState.error:
            return Utils.noDataAvailableVector(
                image: noDataVectorImage(gameProvider.selectedGameTabIndex),
                messageLabel: "Oops! Something went wrong");
        }
      }),
    );
  }

  String noDataVectorImage(int selectedTabIndex) {
    switch (selectedTabIndex) {
      case 0:
        return Assets.assetsCricketVector;
      case 1:
        return Assets.assetsFootballvector;
      case 2:
        return Assets.assetsBasketballVector;
      case 3:
        return Assets.assetsBaseBallvector;
      default:
        return Assets.assetsCricketVector;
    }
  }
  int current = 0;
  final CarouselSliderController  _controller = CarouselSliderController ();

  Widget myMatchSlider(GameViewModel gameProvider) {
    List<GameData> myMatchData = [];
    myMatchData.addAll(gameProvider.gameData.live as Iterable<GameData>);
    myMatchData.addAll(gameProvider.gameData.complete as Iterable<GameData>);
    myMatchData
        .addAll(gameProvider.gameData.myUpcomingMatch as Iterable<GameData>);

    if (myMatchData.isEmpty) {
      return const SizedBox.shrink();
    }

    myMatchData.sort((a, b) => a.status!.compareTo(b.status as num));

    final displayedMatches =
        myMatchData.length < 5 ? myMatchData : myMatchData.sublist(0, 5);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextConst(
          text: AppLocalizations.of(context)!.myMatch,
          fontWeight: FontWeight.w600,
          fontSize: Sizes.fontSizeThree,
          alignment: FractionalOffset.centerLeft,
          padding: const EdgeInsets.only(left: 15),
        ),
        Sizes.spaceHeight10,
        CarouselSlider.builder(
          itemCount: displayedMatches.length,
          carouselController: _controller,
          options: CarouselOptions(
            disableCenter: true,
            height: Sizes.screenWidth / 3.3,
            autoPlay: false,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayInterval: const Duration(seconds: 5),
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                current = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final data = displayedMatches[index];
            final completeTime = DateFormat("d MMM, h:mm a").format(DateTime.parse(data.startDate),);
            String formatDateWithTodayTomorrow(String startDate) {
              final dateTime = DateTime.parse(startDate);

              final now = DateTime.now();
              final tomorrow = now.add(const Duration(days: 1));
              if (dateTime.year == now.year &&
                  dateTime.month == now.month &&
                  dateTime.day == now.day) {
                return "Today, ${DateFormat('h:mm a').format(dateTime)}";
              } else if (dateTime.year == tomorrow.year &&
                  dateTime.month == tomorrow.month &&
                  dateTime.day == tomorrow.day) {
                return "Tomorrow, ${DateFormat('h:mm a').format(dateTime)}";
              } else {
                return DateFormat("d MMM, h:mm a").format(dateTime);
              }
            }
            final startDate = DateTime.parse(data.startDate!);
            final timeLeft = getTimeLeft(startDate);
            return InkWell(
              onTap: () {
                Provider.of<GameViewModel>(context, listen: false)
                    .setSelectedMatch(data);
                if (data.status == 2) {
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    Provider.of<PlayerViewModel>(context, listen: false)
                        .getTeam(context);
                    Provider.of<PlayerViewModel>(context, listen: false)
                        .getPlayerDesignation(context);
                    Provider.of<ContestViewModel>(context, listen: false)
                        .setEnableJoinContestBottomSheet(false);
                    await Provider.of<ContestViewModel>(context, listen: false)
                        .getContestData(context, data.id.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LiveMatchView(data: data)));
                  });
                } else if (data.status == 3) {
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    Provider.of<PlayerViewModel>(context, listen: false)
                        .getTeam(context);
                    Provider.of<PlayerViewModel>(context, listen: false)
                        .getPlayerDesignation(context);
                    Provider.of<ContestViewModel>(context, listen: false)
                        .setEnableJoinContestBottomSheet(false);
                    await Provider.of<ContestViewModel>(context, listen: false)
                        .getContestData(context, data.id.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LiveMatchView(data: data)));
                  });
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    Provider.of<PlayerViewModel>(context, listen: false)
                        .getPlayerDesignation(context);
                    Provider.of<ContestViewModel>(context, listen: false)
                        .setEnableJoinContestBottomSheet(false);
                    Provider.of<ContestViewModel>(context, listen: false)
                        .getContestData(context, data.id.toString());
                    Navigator.pushNamed(context, AppRoutes.contestScreen);
                  });
                }
              },
              child: ContainerConst(
                width: Sizes.screenWidth / 1.2,
                margin: const EdgeInsets.only(top: 8, right: 15),
                borderRadius: BorderRadius.circular(10),
                color: AppColor.whiteColor,
                border: Border.all(color: Colors.grey.shade600, width: 0.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(0, 1.5),
                    blurRadius: 3,
                    spreadRadius: 3,
                  ),
                ],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Home Team
                        Stack(
                          // clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: 5,
                              left: -20,
                              child: ContainerConst(
                                shape: BoxShape.circle,
                                width: 52,
                                height: 52,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      data.homeTeamImage.toString(),
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: -20,
                              child: ContainerConst(
                                width: 52,
                                height: 52,
                                color: Colors.white.withOpacity(0.8),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: SizedBox(
                                width: Sizes.screenWidth / 3.8,
                                child: Row(
                                  children: [
                                    ContainerConst(
                                      shape: BoxShape.circle,
                                      width: 38,
                                      height: 38,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            data.homeTeamImage.toString()),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Sizes.spaceWidth5,
                                    TextConst(
                                      text: data.homeTeamShortName.toString(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Match Status
                        data.status == 2
                            ? ContainerConst(
                                width: 60,
                                height: 30,
                                color:
                                    AppColor.primaryRedColor.withOpacity(0.1),
                                child: const TextConst(
                                  text: "• Live",
                                  textColor: AppColor.primaryRedColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : data.status == 3
                                ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 20,),
                                     const TextConst(
                                        text: "Completed",
                                        textColor: AppColor.textGreyColor,
                                       fontWeight: FontWeight.w600,
                                      ),
                                     TextConst(
                                        text: completeTime.toString(),
                                        fontSize: 8,
                                        textColor: AppColor.textGreyColor,
                                      ),
                                  ],
                                )
                                : Column(
                                  children: [
                                    ContainerConst(
                                      width: Sizes.screenWidth / 5,
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
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextConst(
                                      text: formatDateWithTodayTomorrow(data.startDate.toString()),
                                      fontSize: 8,
                                      textColor: AppColor.textGreyColor,
                                    ),
                                  ],
                                ),
                        // Visitor Team
                        Stack(
                          // clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: 5,
                              right: -20,
                              child: ContainerConst(
                                shape: BoxShape.circle,
                                width: 52,
                                height: 52,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      data.visitorTeamImage.toString(),
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: -20,
                              child: ContainerConst(
                                width: 52,
                                height: 52,
                                color: Colors.white.withOpacity(0.8),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: SizedBox(
                                width: Sizes.screenWidth / 3.8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextConst(
                                      text: data.visitorTeamShortName.toString(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Sizes.spaceWidth5,
                                    ContainerConst(
                                      shape: BoxShape.circle,
                                      width: 38,
                                      height: 38,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            data.visitorTeamImage.toString()),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 1,
                      color: AppColor.scaffoldBackgroundColor,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          gradient: data.status == 3 &&
                                  data.totalWinnings.toString() != '0.00'
                              ? AppColor.greenWhiteGradient
                              : null),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              TextConst(
                                text:
                                    "${data.totalJoinedTeam} Team • ${data.totalJoinedContest} Contest",
                                fontSize: Sizes.fontSizeZero,
                                textColor: AppColor.textGreyColor,
                                alignment: Alignment.centerLeft,
                              ),
                            data.status == 3
                                ? TextConst(
                                    text:
                                        data.totalWinnings.toString() == '0.00'
                                            ? ''
                                            : '₹ ${data.totalWinnings}',
                                    fontSize: Sizes.fontSizeTwo,
                                    fontWeight: FontWeight.bold,
                                    textColor: AppColor.activeButtonGreenColor,
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            displayedMatches.length,
            (index) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(current == index ? 0.9 : 0.4),
                  ),
                ),
              );
            },
          ),
        ),
        Sizes.spaceHeight20,
      ],
    );
  }
}
