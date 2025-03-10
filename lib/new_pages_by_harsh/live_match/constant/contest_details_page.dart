import 'package:flutter/material.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/model/contest_data_model.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/contest_view_model.dart';
import 'package:gold11/view_model/player_view_model.dart';
import 'package:gold11/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class ContestDetailsPage extends StatefulWidget {
  final MyContest contest;
  final ContestList contestList;
  const ContestDetailsPage({
    super.key,
    required this.contest,
    required this.contestList,
  });

  @override
  State<ContestDetailsPage> createState() => _ContestDetailsPageState();
}

class _ContestDetailsPageState extends State<ContestDetailsPage>
    with SingleTickerProviderStateMixin {
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
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: appBarWidget(),
    );
  }

  PreferredSizeWidget appBarWidget() {
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
              contestDetail(),
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
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notification_add_outlined,
              color: AppColor.whiteColor,
            )),
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
    return Consumer<ContestViewModel>(
        builder: (context, contestProvider, child) {
      return TextConst(
        text: '',
        //   text: contestProvider.contestDetail!.matchName??"",
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

  Widget contestDetail() {
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
              text: "₹${widget.contestList.prizePool}",
              width: Sizes.screenWidth / 2.5,
              alignment: Alignment.centerLeft,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: LinearProgressIndicator(
              value: (int.parse(widget.contestList.totalSpot.toString()) -
                      double.parse(widget.contestList.leftSpot.toString())) /
                  int.parse(widget.contestList.totalSpot.toString()),
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextConst(
                  text: "10 spots left",
                  width: Sizes.screenWidth / 2.5,
                  alignment: Alignment.centerLeft,
                  textColor: AppColor.primaryRedColor,
                  fontSize: Sizes.fontSizeOne,
                ),
                TextConst(
                  text: "${widget.contestList.totalSpot} spots",
                  width: Sizes.screenWidth / 2.5,
                  alignment: Alignment.centerRight,
                  fontSize: Sizes.fontSizeOne,
                  textColor: AppColor.textGreyColor,
                ),
              ],
            ),
          ),
          Sizes.spaceHeight5,
          ButtonConst(
            onTap: () async {
              await Provider.of<PlayerViewModel>(context, listen: false)
                  .getPlayers(context);
              if (Provider.of<PlayerViewModel>(context, listen: false)
                  .teamData!
                  .data!
                  .isEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Provider.of<PlayerViewModel>(context, listen: false)
                      .clearSelectedPlayerList();
                });
                Navigator.pushNamed(context, AppRoutes.createTeamScreen);
              } else if (Provider.of<PlayerViewModel>(context, listen: false)
                      .teamData!
                      .data!
                      .length ==
                  1) {
                // contestProvider.joinContest(context);
              } else {
                // contestProvider.joinContest(context);
              }
            },
            width: Sizes.screenWidth / 1.1,
            label: "Join ₹${widget.contestList.entryFee}".toUpperCase(),
            color: AppColor.activeButtonGreenColor,
            textColor: AppColor.whiteColor,
          ),
          Sizes.spaceHeight10,
          ContainerConst(
            padding:
                const EdgeInsets.only(left: 15, top: 8, bottom: 8, right: 15),
            color: AppColor.scaffoldBackgroundColor.withOpacity(0.6),
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
                  text: "${Utils.rupeeSymbol} ${widget.contestList.firstPrize}",
                  fontSize: Sizes.fontSizeOne,
                  textColor: AppColor.textGreyColor,
                ),
                Sizes.spaceWidth5,
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
