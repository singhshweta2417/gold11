import 'package:flutter/material.dart';
import 'package:gold11/model/contest_data_model.dart';
import 'package:gold11/view/contest/joiin_contest_bottom_sheet.dart';
import 'package:gold11/view/widgets/contest_leader_board.dart';
import 'package:provider/provider.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/view/widgets/contest_winners_list.dart';
import 'package:gold11/view_model/contest_view_model.dart';

import '../../generated/assets.dart';
import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../../utils/utils.dart';
import '../../view_model/player_view_model.dart';
import '../../view_model/profile_view_model.dart';
import '../const_widget/container_const.dart';
import '../const_widget/text_const.dart';

class ContestDetailScreen extends StatefulWidget {
  final Map<String, dynamic> args;
  final ContestList? data;
  const ContestDetailScreen({super.key, required this.args,this.data, });

  @override
  State<ContestDetailScreen> createState() => _ContestDetailScreenState();
}

class _ContestDetailScreenState extends State<ContestDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final tabList = [
    const Tab(text: 'Winnings'),
    const Tab(text: 'Leaderboard'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContestViewModel>(
      builder: (context, contestProvider, child) {
        switch (contestProvider.dataState) {
          case ContestDataState.loading:
            return const Scaffold(body: Utils.loadingRed);
          case ContestDataState.success:
            return Scaffold(
              backgroundColor: AppColor.whiteColor,
              appBar: appBarWidget(widget.data),
              body: TabBarView(
                controller: _tabController,
                children: const [
                  ContestWinnersList(),
                  ContestLeaderBoardList()
                ],
              ),
            );
          case ContestDataState.noDataAvl:
            return Utils.noDataAvailableVector();
          case ContestDataState.error:
            return Utils.noDataAvailableVector(
                messageLabel: contestProvider.message);
        }
      },
    );
  }

  PreferredSizeWidget appBarWidget(ContestList? data) {
    return AppBar(
      backgroundColor: AppColor.primaryRedColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight * 5.5),
        child: ContainerConst(
          color: AppColor.primaryRedColor,
          gradient: AppColor.darkRedToBlackGradient,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              contestDetail(data),
              winningLeaderBoardTab()
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarAction() {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notification_add_outlined,
              color: AppColor.whiteColor,
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: ContainerConst(
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
        ),
        Sizes.spaceWidth10,
      ],
    );
  }

  Widget appBarTitle() {
    return Consumer<ContestViewModel>(
        builder: (context, contestProvider, child) {
      return TextConst(
        text: '',
        textColor: AppColor.whiteColor,
        fontSize: Sizes.fontSizeLarge / 1.25,
        alignment: FractionalOffset.centerLeft,
        fontWeight: FontWeight.w600,
      );
    });
  }

  Widget winningLeaderBoardTab() {
    return Container(
      color: AppColor.whiteColor,
      child: TabBar(
        controller: _tabController,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        tabs: tabList,
        labelColor: AppColor.primaryRedColor,
        indicatorColor: Colors.blueAccent,
        indicatorWeight: 2,
      ),
    );
  }

  Widget contestDetail(ContestList? data) {
    return Consumer<ContestViewModel>(
      builder: (context, contestProvider, child) {
        if (contestProvider.contestDetail == null) {
          return Utils.loadingRed;
        }
        final contestData = contestProvider.contestDetail!;

        return ContainerConst(
          height: 204,
          color: AppColor.whiteColor,
          border: Border.all(width: 2, color: AppColor.scaffoldBackgroundColor),
          child: Column(
            children: [
              ListTile(
                title: TextConst(
                  text: "Prize Pool",
                  width: Sizes.screenWidth / 2.5,
                  alignment: Alignment.centerLeft,
                  fontSize: Sizes.fontSizeOne,
                  textColor: AppColor.textGreyColor,
                ),
                subtitle: TextConst(
                  text: "₹${contestData.prizePool ?? 'N/A'}",
                  width: Sizes.screenWidth / 2.5,
                  alignment: Alignment.centerLeft,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LinearProgressIndicator(
                  value: (int.parse(contestData.totalSpot.toString()) -
                          contestData.leftSpot) /
                      int.parse(contestData.totalSpot.toString()),
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextConst(
                      text: contestData.leftSpot == 0
                          ? 'full'
                          : "${contestData.leftSpot.toString()} spots left",
                      width: Sizes.screenWidth / 2.5,
                      alignment: Alignment.centerLeft,
                      textColor: AppColor.primaryRedColor,
                      fontSize: Sizes.fontSizeOne,
                    ),
                    TextConst(
                      text: "${contestData.totalSpot} spots",
                      width: Sizes.screenWidth / 2.5,
                      alignment: Alignment.centerRight,
                      fontSize: Sizes.fontSizeOne,
                      textColor: AppColor.textGreyColor,
                    ),
                  ],
                ),
              ),
              Sizes.spaceHeight5,
              _buildJoinButton(contestData, context, contestProvider,data),
              Sizes.spaceHeight10,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ContainerConst(
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
                            "${Utils.rupeeSymbol} ${contestData.firstPrize ?? 0}",
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
                          text: contestData.entryLimit == 'Single' ? 'S' : 'M',
                          fontSize: Sizes.fontSizeZero,
                          textColor: AppColor.textGreyColor,
                        ),
                      ),
                      Sizes.spaceWidth5,
                      TextConst(
                        text: contestData.entryLimit ?? "0",
                        fontSize: Sizes.fontSizeOne,
                        textColor: AppColor.textGreyColor,
                      ),
                      const Spacer(),
                      TextConst(
                        text:
                            contestData.contestSuccessType ?? "Not available",
                        width: Sizes.screenWidth / 3,
                        alignment: Alignment.centerRight,
                        fontSize: Sizes.fontSizeOne,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildJoinButton(contestData, BuildContext context, ContestViewModel contestProvider, ContestList? data) {
    return
      InkWell(
        onTap: _getJoinButtonAction(contestData, context, contestProvider),
        child: Container(
          width: Sizes.screenWidth / 1.1,
          height:
          Sizes.screenHeight * 0.038,
          decoration: BoxDecoration(
            color: _getButtonColor(contestData),
            borderRadius:
            BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: data!.desprice == "1"
              ? Row(
            mainAxisSize:
            MainAxisSize.min,
            children: [
              const Text(
                "Join ",
                style:
                TextStyle(
                    color: AppColor
                        .whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "₹${data.entryFee.toString()} ",
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
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "₹${data.desprice.toString()}",
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
            "Join ₹${data.entryFee.toString()}",
            style: const TextStyle(
              color:
              AppColor.whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      );
    //   ButtonConst(
    //   onTap: _getJoinButtonAction(contestData, context, contestProvider),
    //   width: Sizes.screenWidth / 1.1,
    //   label: "Join ₹${contestData.entryFee}".toUpperCase(),
    //   color: _getButtonColor(contestData),
    //   textColor: AppColor.whiteColor,
    // );
  }

  VoidCallback _getJoinButtonAction(
      contestData, BuildContext context, ContestViewModel contestProvider) {
    if (contestData.entry_limit == 'Single' &&
        contestData.my_joined_count == 1) {
      return () {};
    } else if (contestData.entry == contestData.my_joined_count) {
      return () {};
    } else if (contestData.left_spot == 0) {
      return () {};
    } else {
      return () async {
        await _joinContestLogic(context, contestData, contestProvider);
      };
    }
  }

  Color _getButtonColor(contestData) {
    if (contestData.entry_limit == 'Single' &&
            contestData.my_joined_count == 1 ||
        contestData.entry == contestData.my_joined_count) {
      return AppColor.textGreyColor;
    } else if (contestData.left_spot == 0) {
      return AppColor.textGreyColor;
    }
    return AppColor.activeButtonGreenColor;
  }

  Future<void> _joinContestLogic(BuildContext context, contestData,
      ContestViewModel contestProvider) async {

    contestProvider.setEnableJoinContestBottomSheet(true);
    await Provider.of<PlayerViewModel>(context, listen: false)
        .getPlayers(context);
    if (Provider.of<PlayerViewModel>(context, listen: false)
        .teamData!
        .data!
        .isEmpty) {
      Navigator.pushNamed(context, AppRoutes.createTeamScreen);
    } else if (Provider.of<PlayerViewModel>(context, listen: false)
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
      Navigator.pushNamed(context, AppRoutes.selectTeamScreen);
    }
  }
}
