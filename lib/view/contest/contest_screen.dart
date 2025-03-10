import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/dedline_passed_screen.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/contest/joiin_contest_bottom_sheet.dart';
import 'package:gold11/view/widgets/contests_list.dart';
import 'package:gold11/view/widgets/my_contest_list.dart';
import 'package:gold11/view/widgets/my_team_listing.dart';
import 'package:gold11/view_model/contest_view_model.dart';
import 'package:gold11/view_model/game_view_model.dart';
import 'package:gold11/view_model/player_view_model.dart';
import 'package:gold11/view_model/profile_view_model.dart';

import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../../utils/route/app_routes.dart';
import '../const_widget/container_const.dart';
import '../const_widget/text_const.dart';
import '../widgets/contest_filter_bottom_sheet.dart';

class ContestScreen extends StatefulWidget {
  final Map<String, dynamic>? args;
  final String? data;
  const ContestScreen({
    super.key,
    this.args,
     this.data,
  });

  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // Declare it with late, but initialize it in initState.

  final quickFilterList = ["entry", "spots", "prize pool", "winners"];

  @override
  void initState() {
    super.initState();

    final contestProvider = Provider.of<ContestViewModel>(context, listen: false);
    _tabController = TabController(length: 4, vsync: this);
    contestProvider.getContestFilterType();
    Provider.of<PlayerViewModel>(context, listen: false).getPlayers(context);
    Provider.of<PlayerViewModel>(context, listen: false).getTeam(context);
    contestProvider.setTabController(_tabController);
    if (contestProvider.enableJoinContestBottomSheet) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
            context: context,
            builder: (_) {
              return const JoinContestBottomSheetScreen();
            });
      });
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    timer.cancel();
    super.dispose();
  }


  late Timer timer;




  String getTimeLeft(
      DateTime startDate,
      BuildContext context,
      ) {
    final now = DateTime.now();
    final difference = startDate.difference(now);
    DateFormat dateFormat = DateFormat("d MMM");
    final gameData = Provider.of<GameViewModel>(context, listen: false);

    if (difference.isNegative) {
      return 'Time\'s up';
    }

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
        gameData.getGameData(context, "1");
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
  bool _isTimeValid(String? contestTime) {
    if (contestTime == null || contestTime.isEmpty) return false; // Updated null check
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

    return DefaultTabController(
      initialIndex: Provider.of<ContestViewModel>(context, listen: false).contestTabIndex,
      length: 4,
      child: Consumer<ContestViewModel>(
        builder: (context, contestProvider, child) {
          switch (contestProvider.dataState) {
            case ContestDataState.loading:
              return const Scaffold(body: Utils.loadingRed);
            case ContestDataState.success:
              return Scaffold(
                backgroundColor: AppColor.whiteColor,
                appBar: appBarWidget(),
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      controller: contestProvider.scrollController,
                      child:  ContestsList(time:widget.data),
                    ),
                    SingleChildScrollView(
                      controller: contestProvider.scrollController,
                      child:  MyContestList(time:widget.data),
                    ),
                    SingleChildScrollView(
                      controller: contestProvider.scrollController,
                      child: const MyTeamList(),
                    ),
                    Utils.noDataAvailableVector(),
                  ],
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                floatingActionButton: ValueListenableBuilder<bool>(
                  valueListenable: contestProvider.isFabVisible,
                  builder: (context, isVisible, child) {
                    return AnimatedOpacity(
                      opacity: isVisible ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: isVisible
                          ? ContainerConst(
                        onTap: () {
                          contestProvider.setContestScreenTabIndex(0);
                        },
                        height: 40,
                        borderRadius: BorderRadius.circular(20),
                        width: Sizes.screenWidth / 1.45,
                        color: AppColor.blackColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ButtonConst(
                              label: "contests".toUpperCase(),
                              width: Sizes.screenWidth / 3.2,
                              icon: Icons.emoji_events_outlined,
                              iconColor: AppColor.whiteColor,
                              iconSize: 20,
                              color: Colors.transparent,
                              textColor: AppColor.whiteColor,
                              fontSize: Sizes.fontSizeOne,
                            ),
                            TextConst(
                              text: "/",
                              fontSize: Sizes.fontSizeThree,
                              textColor: AppColor.whiteColor,
                            ),
                            ButtonConst(
                              onTap: () {
                                if(widget.data == null ||_isTimeValid(widget.data))  {

                                  Provider.of<PlayerViewModel>(context, listen: false)
                                      .clearSelectedPlayerList();
                                  contestProvider.setEnableJoinContestBottomSheet(false);
                                  Navigator.pushNamed(context, AppRoutes.createTeamScreen);
                                }else{
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (_) {
                                        return  const DedlinePassedScreen();
                                      }
                                  );
                                }
                              },
                              label: "create team".toUpperCase(),
                              width: Sizes.screenWidth / 3,
                              icon: Icons.add_circle_outline,
                              iconColor: AppColor.whiteColor,
                              iconSize: 20,
                              color: Colors.transparent,
                              textColor: AppColor.whiteColor,
                              fontSize: Sizes.fontSizeOne,
                            ),
                          ],
                        ),
                      )
                          : const SizedBox.shrink(),
                    );
                  },
                ),

              );
            case ContestDataState.noDataAvl:
              return Scaffold(body: Utils.noDataAvailableVector());
            case ContestDataState.error:
              return Scaffold(
                body: Utils.noDataAvailableVector(
                  messageLabel: "Something went wrong ${contestProvider.message}",
                ),
              );
          }
        },
      ),
    );
  }
///
  PreferredSizeWidget appBarWidget() {
    return AppBar(
      backgroundColor: AppColor.primaryRedColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(_tabController.index >= 1
            ? (kToolbarHeight + 60)
            : (kToolbarHeight + 50 + 50)),
        child: ContainerConst(
          color: AppColor.whiteColor,
          gradient: AppColor.darkRedToBlackGradient,
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
                  ],
                ),
              ),
              Sizes.spaceHeight10,
              Consumer<PlayerViewModel>(
                builder: (context, pvmCon, child) {
                  return ContainerConst(
                    height: 50,
                    color: AppColor.whiteColor,
                    child: TabBar(
                      onTap: (v) {},
                      padding: const EdgeInsets.all(0),
                      controller: _tabController,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      tabs: [
                        const Tab(text: 'Contests'),
                        Tab(
                            text: 'My Contests (${Provider.of<ContestViewModel>(context, listen: false).contestData.myContest!.length})'),
                        Tab(
                            text: 'Team (${pvmCon.teamData != null ? pvmCon.teamData!.data!.length : 0})'),
                        const Tab(text: 'Guru & Stats'),
                      ],
                      labelColor: AppColor.primaryRedColor,
                      indicatorColor: Colors.blueAccent,
                      indicatorWeight: 2,
                    ),
                  );
                },
              ),
              _tabController.index >= 1
                  ? const SizedBox.shrink()
                  : ContainerConst(
                color: AppColor.whiteColor,
                height: 40,
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                  children: [
                    TextConst(
                      text: "Sort By: ",
                      textColor: AppColor.textGreyColor,
                      fontSize: Sizes.fontSizeOne,
                    ),
                    Row(
                      children: List.generate(
                        quickFilterList.length,
                            (i) {
                          return TextConst(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            text: quickFilterList[i].toUpperCase(),
                            textColor: AppColor.textGreyColor,
                            fontSize: Sizes.fontSizeOne,
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return const ContestFilterBottomSheet();
                            },
                          );
                        },
                        icon: const Icon(Icons.filter_alt_outlined))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarAction() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notification_add_outlined,
            color: AppColor.whiteColor,
          ),
        ),
        ContainerConst(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.walletAddCashScreen);
          },
          height: 35,
          padding: const EdgeInsets.all(5),
          color: AppColor.scaffoldBackgroundColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.wallet,
                color: AppColor.whiteColor,
              ),
              Sizes.spaceWidth5,
              TextConst(
                text:
                "${Utils.rupeeSymbol} ${Provider.of<ProfileViewModel>(context).userProfile!.data!.wallet ?? 0}",
                textColor: AppColor.whiteColor,
                fontWeight: FontWeight.w600,
              ),
              Sizes.spaceWidth5,
              const Icon(
                Icons.add_circle,
                color: AppColor.activeButtonGreenColor,
              ),
            ],
          ),
        ),
        Sizes.spaceWidth10
      ],
    );
  }

  Widget appBarTitle() {
    DateTime? startDate;
    String timeLeft = "N/A";

    if (widget.data != null && widget.data is String) {
      try {
        final date = DateFormat("yyyy-MM-dd HH:mm:ss").parse(widget.data!);
        startDate = DateTime.parse(date.toString());
        timeLeft = getTimeLeft(startDate, context);
      } catch (e) {
        debugPrint("Error parsing date: $e");
        timeLeft = "Invalid Date";
      }
    } else {
      timeLeft = "Date Unavailable";
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextConst(
          text: Provider.of<ContestViewModel>(context).contestData.matchName ??
              "Not Available",
          textColor: AppColor.whiteColor,
          fontSize: Sizes.fontSizeLarge / 1.25,
          alignment: FractionalOffset.centerLeft,
          fontWeight: FontWeight.w600,
        ),
        TextConst(
          text: timeLeft,
          textColor: AppColor.whiteColor,
          fontSize: 12,
          alignment: FractionalOffset.centerLeft,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

