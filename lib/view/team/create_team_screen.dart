import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/team/team_preview_screen.dart';
import 'package:gold11/view/widgets/players_listing.dart';
import 'package:gold11/view_model/contest_view_model.dart';
import 'package:gold11/view_model/game_view_model.dart';
import 'package:gold11/view_model/player_view_model.dart';

import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../const_widget/button_const.dart';
import '../const_widget/container_const.dart';
import '../const_widget/text_const.dart';

class CreateTeamScreen extends StatefulWidget {
  final Map<String, dynamic>? args;
  const CreateTeamScreen({super.key, this.args});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlayerViewModel>(context, listen: false)
          .isDesignationSelected
          .clear();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (int.parse(selectedPlayerCount.toString()) <= 0) {
      return true;
    } else {
      showModalBottomSheet(
        elevation: 5,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            //   side: BorderSide(width: 2, color: AppColor.primaryRedColor),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: context,
        builder: (context) {
          return Container(
            height: Sizes.screenHeight * 0.38,
            width: Sizes.screenWidth,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Column(
              children: [
                SizedBox(height: Sizes.screenHeight * 0.03),
                TextConst(
                  textColor: Colors.black,
                  fontSize: Sizes.screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  text: 'Exit Team Creation?',
                ),
                const Divider(),
                SizedBox(height: Sizes.screenHeight / 30),
                ContainerConst(
                    width: Sizes.screenWidth * 0.80,
                    border:
                        Border.all(width: 0.5, color: AppColor.textGreyColor),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child:  const ListTile(
                      contentPadding: EdgeInsets.all(6),
                      leading: ContainerConst(
                      image: DecorationImage(image:AssetImage(Assets.iconsSecure)),
                        height: 50,
                        width: 50,
                        color: AppColor.textGoldenColor,
                        shape: BoxShape.circle,
                      ),
                      title: TextConst(
                        textColor: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        text: 'Get Help From Gurus',
                      ),
                      subtitle: TextConst(
                        textColor: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        text: 'Helped ${'2 Crore+'} people to win',
                      ),
                      trailing: ContainerConst(
                        height: 40,
                        width: 40,
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 20,
                        ),
                      ),
                    )),
                SizedBox(height: Sizes.screenHeight * 0.02),
                ButtonConst(
                  onTap: () {
                    Navigator.pop(context, false);
                    Navigator.pop(context, false);
                  },
                  width: Sizes.screenWidth * 0.80,
                  textColor: AppColor.whiteColor,
                  color: AppColor.activeButtonGreenColor,
                  label: "Yes, Exit".toUpperCase(),
                  fontWeight: FontWeight.w700,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColor.textGreyColor,
                      offset: Offset(0, 2),
                      blurRadius: 2,
                    )
                  ],
                ),
                SizedBox(height: Sizes.screenHeight * 0.02),
                ButtonConst(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  width: Sizes.screenWidth * 0.80,
                  textColor: AppColor.blackColor,
                  color: AppColor.whiteColor,
                  border: Border.all(color: AppColor.textGreyColor),
                  label: "Continue Editing".toUpperCase(),
                  fontWeight: FontWeight.w900,
                ),
              ],
            ),
          );
        },
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(builder: (context, playerProvider, child) {
      return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            appBar: appBarWidget(),
            backgroundColor: AppColor.whiteColor,
            body: playerProvider.playerData.data!.isEmpty
                ? Utils.noDataAvailableVector()
                : TabBarView(
                    controller: _tabController,
                    children: List.generate(
                        playerProvider.playerDesignation.data!.length, (i) {
                      return PlayersListingUI(
                        isPlayerType: playerProvider.playerDesignation.data![i],
                      );
                    })),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: floatingActionContent(),
          ));
    });
  }

 int? selectedPlayerCount;
  Widget floatingActionContent() {
    return Consumer2<PlayerViewModel, GameViewModel>(
      builder: (context, playerProvider, gameProvider, child) {
        selectedPlayerCount = playerProvider.selectedPlayers.length;
        final teamIds = jsonDecode(gameProvider.selectedMatch.teamId ?? "[]");

        final team1PlayerCount = playerProvider.selectedPlayers
            .where(
                (e) => e.teamId == teamIds[1]).length;
        final team2PlayerCount = playerProvider.selectedPlayers
            .where(
                (e) => e.teamId == teamIds[0]).length;

        final allDesignationsSelected =
            playerProvider.playerDesignation.data!.every((designation) {
          return playerProvider.selectedPlayers.any((e) =>
              e.designationId == designation.id ||
              e.designationName.toString().toLowerCase() ==
                  designation.shortTerm.toString().toLowerCase());
        });

        final isElevenPlayersSelected = selectedPlayerCount == 11;
        final isMinOnePlayerEachTeam =
            team1PlayerCount > 0 && team2PlayerCount > 0;
        return ContainerConst(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ContainerConst(
                height: 40,
                borderRadius: BorderRadius.circular(25),
                width: Sizes.screenWidth / 1.8,
                color: AppColor.blackColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtonConst(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (_) {
                            return const TeamPreviewScreen();
                          },
                        );
                      },
                      label: "preview".toUpperCase(),
                      width: Sizes.screenWidth / 4,
                      icon: Icons.remove_red_eye,
                      iconColor: AppColor.whiteColor,
                      color: Colors.transparent,
                      textColor: AppColor.whiteColor,
                    ),
                    TextConst(
                      text: "/",
                      fontSize: Sizes.fontSizeThree,
                      textColor: AppColor.whiteColor,
                    ),
                    ButtonConst(
                      onTap: () {
                        playerProvider.playerData.lineUp.toString()=='1'?
                        Navigator.pushNamed(
                            context, AppRoutes.pastLineUpScreen):Utils.showMessage(context, 'Check the lineup here after they are announced');
                      },
                      label: "lineup".toUpperCase(),
                      width: Sizes.screenWidth / 4,
                      icon: Icons.theater_comedy_outlined,
                      iconColor: AppColor.whiteColor,
                      color: Colors.transparent,
                      textColor: AppColor.whiteColor,
                    ),
                  ],
                ),
              ),
              ButtonConst(
                onTap: () {
                  if (isElevenPlayersSelected &&
                      allDesignationsSelected &&
                      isMinOnePlayerEachTeam) {
                    Navigator.pushNamed(context, AppRoutes.chooseTeamCAndVC);
                  } else {
                    if (kDebugMode) {
                      print(
                          "Please select exactly 11 players, with at least one player from each team, to proceed");
                    }
                  }
                },
                label: "next".toUpperCase(),
                height: 40,
                borderRadius: BorderRadius.circular(25),
                width: 90,
                color: (isElevenPlayersSelected &&
                        allDesignationsSelected &&
                        isMinOnePlayerEachTeam)
                    ? AppColor.activeButtonGreenColor
                    : Colors.grey.shade500,
                textColor: AppColor.whiteColor,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      backgroundColor: AppColor.primaryRedColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 0,
      bottom: PreferredSize(
        preferredSize:
            const Size.fromHeight(kToolbarHeight + 60 + (kToolbarHeight * 1.8)),
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
              teamSelectionDetail(),
              Consumer<PlayerViewModel>(
                  builder: (context, playerProvider, child) {
                return ContainerConst(
                  height: 50,
                  color: AppColor.whiteColor,
                  child: TabBar(
                    padding: const EdgeInsets.all(0),
                    controller: _tabController,
                    tabs: List.generate(
                        playerProvider.playerDesignation.data!.length, (i) {
                      return Tab(
                          text:
                              '${playerProvider.playerDesignation.data![i].shortTerm}(${playerProvider.selectedPlayers.where((e) => e.designationId == playerProvider.playerDesignation.data![i].id || e.designationName!.toLowerCase() == playerProvider.playerDesignation.data![i].shortTerm!.toLowerCase()).length})');
                    }),
                    labelColor: AppColor.primaryRedColor,
                    indicatorColor: Colors.blueAccent,
                    indicatorWeight: 2,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarAction() {
    return ContainerConst(
      margin: const EdgeInsets.only(right: 15),
      // width: ,
      shape: BoxShape.circle,
      padding: const EdgeInsets.all(5),
      border: Border.all(color: Colors.white, width: 1),
      child: Text(
        "PTS",
        style: TextStyle(fontSize: Sizes.fontSizeOne, color: Colors.white),
      ),
    );
  }

  Widget appBarTitle() {
    return Consumer<ContestViewModel>(builder: (context, cvmCon, _) {
      return TextConst(
        text: cvmCon.contestData.matchName ?? "",
        textColor: AppColor.whiteColor,
        fontSize: Sizes.fontSizeLarge / 1.25,
        alignment: FractionalOffset.centerLeft,
        fontWeight: FontWeight.w600,
      );
    });
  }

  Widget teamSelectionDetail() {
    return Consumer<PlayerViewModel>(builder: (context, provider, child) {
      final playerCount = provider.selectedPlayersCount;
      return ContainerConst(
          height: kToolbarHeight * 1.8,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          color: AppColor.blackColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                      ),
                      TextConst(
                        text: "$playerCount/11",
                        textColor: AppColor.scaffoldBackgroundColor,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextConst(
                        text: "Maximum of 10 players form one team",
                        fontSize: Sizes.fontSizeZero,
                        textColor: AppColor.scaffoldBackgroundColor,
                      ),
                      Sizes.spaceHeight5,
                      Consumer<GameViewModel>(builder: (context, gvmCon, _) {
                        final teamIds =
                            jsonDecode(gvmCon.selectedMatch.teamId ?? "");
                        final selectedPlayersList =
                            Provider.of<PlayerViewModel>(context, listen: false)
                                .selectedPlayers;
                        return SizedBox(
                          width: Sizes.screenWidth / 2.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ContainerConst(
                                    height: 40,
                                    width: 40,
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                    image: DecorationImage(
                                        image: NetworkImage(gvmCon
                                                .selectedMatch.homeTeamImage ??
                                            ""),
                                        fit: BoxFit.cover),
                                  ),
                                  Sizes.spaceWidth5,
                                  Column(
                                    children: [
                                      TextConst(
                                        text: gvmCon.selectedMatch
                                                .homeTeamShortName ??
                                            "",
                                        fontSize: Sizes.fontSizeOne,
                                        textColor: AppColor
                                            .scaffoldBackgroundColor
                                            .withOpacity(0.7),
                                      ),
                                      TextConst(
                                        text: selectedPlayersList
                                            .where(
                                                (e) => e.teamId == teamIds[0])
                                            .length
                                            .toString(),
                                        textColor: AppColor.whiteColor,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      TextConst(
                                        text: gvmCon.selectedMatch
                                                .visitorTeamShortName ??
                                            "",
                                        fontSize: Sizes.fontSizeOne,
                                        textColor: AppColor
                                            .scaffoldBackgroundColor
                                            .withOpacity(0.7),
                                      ),
                                      TextConst(
                                        text: selectedPlayersList
                                            .where(
                                                (e) => e.teamId == teamIds[1])
                                            .length
                                            .toString(),
                                        textColor: AppColor.whiteColor,
                                      ),
                                    ],
                                  ),
                                  Sizes.spaceWidth5,
                                  ContainerConst(
                                    height: 40,
                                    width: 40,
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                    image: DecorationImage(
                                        image: NetworkImage(gvmCon.selectedMatch
                                                .visitorTeamImage ??
                                            ""),
                                        fit: BoxFit.cover),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextConst(
                        text: "Credit Left",
                        textColor:
                            AppColor.scaffoldBackgroundColor.withOpacity(0.7),
                        fontSize: Sizes.fontSizeOne,
                      ),
                      TextConst(
                        text: provider.totalSelectedPlayersPrice
                            .toStringAsFixed(0),
                        textColor: AppColor.scaffoldBackgroundColor,
                      ),
                    ],
                  ),
                ],
              ),
              Sizes.spaceHeight10,
              teamCountIndicator(playerCount),
            ],
          ));
    });
  }

  Widget teamCountIndicator(int playerCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(11, (i) {
        Color color = i < playerCount
            ? AppColor.activeButtonGreenColor
            : AppColor.whiteColor;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Transform(
            transform: Matrix4.skewX(-0.5),
            child: ContainerConst(
              height: Sizes.screenWidth / 30,
              width: Sizes.screenWidth / 13,
              color: color,
            ),
          ),
        );
      }),
    );
  }
}
