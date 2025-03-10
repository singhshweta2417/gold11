import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold11/new_pages_by_harsh/team_preview.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view_model/player_view_model.dart';

import '../../generated/assets.dart';
import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../../utils/utils.dart';
import '../const_widget/container_const.dart';
import '../const_widget/text_const.dart';
import '../contest/joiin_contest_bottom_sheet.dart';
import '../widgets/my_team_listing.dart';

class SelectTeamScreen extends StatefulWidget {
  const SelectTeamScreen({super.key});

  @override
  State<SelectTeamScreen> createState() => _SelectTeamScreenState();
}

class _SelectTeamScreenState extends State<SelectTeamScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<PlayerViewModel>(context, listen: false).getTeam(context);
    return Scaffold(
      appBar: appBarWidget(context),
      body: avlTeamList(),
      bottomSheet: joinButton(),
    );
  }

  PreferredSizeWidget appBarWidget(context) {
    return AppBar(
      backgroundColor: AppColor.primaryRedColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight * 2),
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
              Consumer<PlayerViewModel>(builder: (context, pvmCon, _) {
                return ContainerConst(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    height: 46,
                    color: AppColor.whiteColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextConst(
                          text: "You can enter with only 1 team",
                          fontSize: Sizes.fontSizeOne,
                          textColor: AppColor.textGreyColor,
                        ),
                        const Spacer(),
                        const ContainerConst(
                          height: 20,
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        Sizes.spaceWidth25,
                        Row(
                          children: [
                            TextConst(
                              text: "My Team: ",
                              fontSize: Sizes.fontSizeOne,
                            ),
                            TextConst(
                              text: "${pvmCon.teamData!.data!.length}",
                              fontSize: Sizes.fontSizeOne,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarAction() {
    return Row(
      children: [
        ContainerConst(
          onTap: () {
            // Navigator.pushNamed(context, AppRoutes.walletAddCashScreen);
          },
          height: 35,
          padding: const EdgeInsets.all(5),
          color: AppColor.scaffoldBackgroundColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.add_circle,
                color: AppColor.whiteColor,
              ),
              Sizes.spaceWidth5,
              TextConst(
                text: "create team".toUpperCase(),
                textColor: AppColor.whiteColor,
                fontWeight: FontWeight.w600,
              ),
              Sizes.spaceWidth15,
            ],
          ),
        ),
        Sizes.spaceWidth10,
      ],
    );
  }

  Widget appBarTitle() {
    return TextConst(
      text: "Select Team",
      textColor: AppColor.whiteColor,
      fontSize: Sizes.fontSizeLarge / 1.25,
      alignment: FractionalOffset.centerLeft,
      fontWeight: FontWeight.w600,
    );
  }

  int? teamNo = 0;
  Widget avlTeamList() {
    return Consumer<PlayerViewModel>(builder: (context, pvmCon, child) {
      if (pvmCon.teamData!.data!.isEmpty) {
        return Utils.noDataAvailableVector();
      }

      final joinedTeams = pvmCon.teamData!.data!
          .where((team) => team.joinedStatus.toString() == '1')
          .toList();
      final otherTeams = pvmCon.teamData!.data!
          .where((team) => team.joinedStatus.toString() != '1')
          .toList();
      if (joinedTeams.isEmpty) {}

      return ListView(
        shrinkWrap: true,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: otherTeams.length,
            itemBuilder: (_, int i) {
              final teamData = otherTeams[i];

              return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TeamPreview(
                                        data: teamData,
                                      )));
                        },
                        child: ContainerConst(
                          width: Sizes.screenWidth / 1.2,
                          padding: const EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.whiteColor,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black38,
                                offset: Offset(0, 1.5),
                                blurRadius: 3,
                                spreadRadius: 2)
                          ],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ContainerConst(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: AssetImage(Assets.assetsFieldGrass),
                                    fit: BoxFit.cover),
                                child: Column(
                                  children: [
                                    ContainerConst(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color:
                                          AppColor.blackColor.withOpacity(0.3),
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 3, bottom: 3),
                                      child: Row(
                                        children: [
                                          TextConst(
                                            text:
                                                "${Provider.of<ProfileViewModel>(context).userProfile!.data!.userName} ${teamData.teamName}",
                                            textColor: AppColor.whiteColor,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            width: 80,
                                          ),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                final pvmCon = Provider.of<
                                                        PlayerViewModel>(
                                                    context,
                                                    listen: false);
                                                pvmCon
                                                    .clearSelectedPlayerList();
                                                pvmCon.setUpdateTeam(
                                                    true, teamData.id!);
                                                pvmCon.getUpdateTeamData(
                                                    teamData.playerList);
                                                Navigator.pushNamed(context,
                                                    AppRoutes.createTeamScreen,
                                                    arguments: {
                                                      "allowEdit": true
                                                    });
                                              },
                                              icon: const Icon(
                                                Icons.edit_outlined,
                                                color: AppColor.whiteColor,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.swap_vert_circle_outlined,
                                                color: AppColor.whiteColor,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.file_copy_outlined,
                                                color: AppColor.whiteColor,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.share,
                                                color: AppColor.whiteColor,
                                              )),
                                        ],
                                      ),
                                    ),
                                    Sizes.spaceHeight10,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              TextConst(
                                                text: teamData.homeTeamName!
                                                    .toUpperCase(),
                                                textColor: AppColor.whiteColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              TextConst(
                                                text: teamData
                                                    .homeTeamPlayerCount
                                                    .toString(),
                                                textColor: AppColor.whiteColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: Sizes.fontSizeThree,
                                              ),
                                            ],
                                          ),
                                          Sizes.spaceWidth15,
                                          Column(
                                            children: [
                                              TextConst(
                                                text: teamData.visitorTeamName!
                                                    .toUpperCase(),
                                                textColor: AppColor.whiteColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              TextConst(
                                                text: teamData
                                                    .visitorTeamPlayerCount
                                                    .toString(),
                                                textColor: AppColor.whiteColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: Sizes.fontSizeThree,
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              ContainerConst(
                                                height: 80,
                                                width: 70,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        teamData.captainImage ??
                                                            ""),
                                                    fit: BoxFit.fitWidth,
                                                    alignment:
                                                        Alignment.topCenter),
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: ContainerConst(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 2),
                                                    height: 20,
                                                    color: teamData.playerList!
                                                                .firstWhere((e) =>
                                                                    e.isCaptain ==
                                                                    1)
                                                                .teamId
                                                                .toString() ==
                                                            teamData.homeTeamId
                                                        ? AppColor.whiteColor
                                                        : AppColor.blackColor,
                                                    child: TextConst(
                                                      text: teamData
                                                              .captainName ??
                                                          "",
                                                      fontSize:
                                                          Sizes.fontSizeZero /
                                                              1.2,
                                                      textColor: teamData
                                                                  .playerList!
                                                                  .firstWhere((e) =>
                                                                      e.isCaptain ==
                                                                      1)
                                                                  .teamId
                                                                  .toString() ==
                                                              teamData
                                                                  .homeTeamId
                                                          ? AppColor.blackColor
                                                          : AppColor.whiteColor,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                              Positioned(
                                                top: -5,
                                                left: -8,
                                                child: ContainerConst(
                                                  width: Sizes.screenWidth / 15,
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  border: Border.all(
                                                      color: teamData
                                                                  .playerList!
                                                                  .firstWhere((e) =>
                                                                      e.isCaptain ==
                                                                      1)
                                                                  .teamId
                                                                  .toString() ==
                                                              teamData
                                                                  .homeTeamId
                                                          ? Colors.grey
                                                          : AppColor.whiteColor,
                                                      width: 1.5),
                                                  shape: BoxShape.circle,
                                                  color: teamData.playerList!
                                                              .firstWhere((e) =>
                                                                  e.isCaptain ==
                                                                  1)
                                                              .teamId
                                                              .toString() ==
                                                          teamData.homeTeamId
                                                      ? AppColor.whiteColor
                                                      : AppColor.blackColor,
                                                  child: TextConst(
                                                    text: "C",
                                                    textColor: teamData
                                                                .playerList!
                                                                .firstWhere((e) =>
                                                                    e.isCaptain ==
                                                                    1)
                                                                .teamId
                                                                .toString() ==
                                                            teamData.homeTeamId
                                                        ? AppColor.blackColor
                                                        : AppColor.whiteColor,
                                                    fontSize:
                                                        Sizes.fontSizeZero,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Sizes.spaceWidth20,
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              ContainerConst(
                                                height: 80,
                                                width: 70,
                                                image: DecorationImage(
                                                    image: NetworkImage(teamData
                                                            .viceCaptainImage ??
                                                        ""),
                                                    fit: BoxFit.fitWidth),
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: ContainerConst(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 2),
                                                    height: 20,
                                                    color: teamData.playerList!
                                                                .firstWhere((e) =>
                                                                    e.isCaptain ==
                                                                    1)
                                                                .teamId
                                                                .toString() ==
                                                            teamData.homeTeamId
                                                        ? AppColor.whiteColor
                                                        : AppColor.blackColor,
                                                    child: TextConst(
                                                      text: teamData
                                                              .viceCaptainName ??
                                                          "",
                                                      fontSize:
                                                          Sizes.fontSizeZero /
                                                              1.2,
                                                      textColor: teamData
                                                                  .playerList!
                                                                  .firstWhere((e) =>
                                                                      e.isCaptain ==
                                                                      1)
                                                                  .teamId
                                                                  .toString() ==
                                                              teamData
                                                                  .homeTeamId
                                                          ? AppColor.blackColor
                                                          : AppColor.whiteColor,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                              Positioned(
                                                top: -5,
                                                left: -8,
                                                child: ContainerConst(
                                                  width: Sizes.screenWidth / 15,
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  border: Border.all(
                                                      color: teamData
                                                                  .playerList!
                                                                  .firstWhere((e) =>
                                                                      e.isViceCaptain ==
                                                                      1)
                                                                  .teamId
                                                                  .toString() ==
                                                              teamData
                                                                  .homeTeamId
                                                          ? Colors.grey
                                                          : AppColor.whiteColor,
                                                      width: 1.5),
                                                  shape: BoxShape.circle,
                                                  color: teamData.playerList!
                                                              .firstWhere((e) =>
                                                                  e.isViceCaptain ==
                                                                  1)
                                                              .teamId
                                                              .toString() ==
                                                          teamData.homeTeamId
                                                      ? AppColor.whiteColor
                                                      : AppColor.blackColor,
                                                  child: TextConst(
                                                    text: "VC",
                                                    textColor: teamData
                                                                .playerList!
                                                                .firstWhere((e) =>
                                                                    e.isViceCaptain ==
                                                                    1)
                                                                .teamId
                                                                .toString() ==
                                                            teamData.homeTeamId
                                                        ? AppColor.blackColor
                                                        : AppColor.whiteColor,
                                                    fontSize:
                                                        Sizes.fontSizeZero,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    ContainerConst(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      margin: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 10,
                                          top: 5),
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: AppColor.blackColor,
                                      gradient: LinearGradient(
                                          colors: [
                                            AppColor.blackColor
                                                .withOpacity(0.35),
                                            AppColor.blackColor
                                                .withOpacity(0.2),
                                            AppColor.blackColor
                                                .withOpacity(0.1),
                                            Colors.transparent
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          playerRoleData(
                                              "WK", teamData.wK ?? ""),
                                          playerRoleData(
                                              "BAT", teamData.bAT ?? ""),
                                          playerRoleData(
                                              "AR", teamData.aR ?? ""),
                                          playerRoleData(
                                              "BOWL", teamData.bOWL ?? ""),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            pvmCon.setSelectedTeam(teamData);
                            setState(() {
                              teamNo = i;
                            });
                          },
                          icon: pvmCon.selectedTeam != null &&
                                  teamData.id == pvmCon.selectedTeam!.id
                              ? const Icon(
                                  Icons.check_circle,
                                  color: AppColor.activeButtonGreenColor,
                                  size: 25,
                                )
                              : const Icon(
                                  Icons.circle_outlined,
                                  color: AppColor.textGreyColor,
                                  size: 25,
                                ))
                    ],
                  ));
            },
          ),
          joinedTeams.isEmpty
              ? const SizedBox.shrink()
              : const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextConst(
                    text: '  Already Joined',
                    textColor: AppColor.blackColor,
                    fontWeight: FontWeight.w600,
                    alignment: Alignment.centerLeft,
                  ),
                ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: joinedTeams.length,
            itemBuilder: (_, int i) {
              final teamData = joinedTeams[i];
              return Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TeamPreview(
                                        data: teamData,
                                      )));
                        },
                        child: ContainerConst(
                          width: Sizes.screenWidth / 1.2,
                          padding: const EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.whiteColor,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black38,
                                offset: Offset(0, 1.5),
                                blurRadius: 3,
                                spreadRadius: 2)
                          ],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ContainerConst(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: AssetImage(Assets.assetsFieldGrass),
                                    fit: BoxFit.cover),
                                child: Column(
                                  children: [
                                    ContainerConst(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color:
                                          AppColor.blackColor.withOpacity(0.3),
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 3, bottom: 3),
                                      child: Row(
                                        children: [
                                          TextConst(
                                            text:
                                                "${Provider.of<ProfileViewModel>(context).userProfile!.data!.userName} ${teamData.teamName}",
                                            textColor: AppColor.whiteColor,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            width: 80,
                                          ),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                final pvmCon = Provider.of<
                                                        PlayerViewModel>(
                                                    context,
                                                    listen: false);
                                                pvmCon
                                                    .clearSelectedPlayerList();
                                                pvmCon.setUpdateTeam(
                                                    true, teamData.id!);
                                                pvmCon.getUpdateTeamData(
                                                    teamData.playerList);
                                                Navigator.pushNamed(context,
                                                    AppRoutes.createTeamScreen,
                                                    arguments: {
                                                      "allowEdit": true
                                                    });
                                              },
                                              icon: const Icon(
                                                Icons.edit_outlined,
                                                color: AppColor.whiteColor,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.swap_vert_circle_outlined,
                                                color: AppColor.whiteColor,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.file_copy_outlined,
                                                color: AppColor.whiteColor,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.share,
                                                color: AppColor.whiteColor,
                                              )),
                                        ],
                                      ),
                                    ),
                                    Sizes.spaceHeight10,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              TextConst(
                                                text: teamData.homeTeamName!
                                                    .toUpperCase(),
                                                textColor: AppColor.whiteColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              TextConst(
                                                text: teamData
                                                    .homeTeamPlayerCount
                                                    .toString(),
                                                textColor: AppColor.whiteColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: Sizes.fontSizeThree,
                                              ),
                                            ],
                                          ),
                                          Sizes.spaceWidth15,
                                          Column(
                                            children: [
                                              TextConst(
                                                text: teamData.visitorTeamName!
                                                    .toUpperCase(),
                                                textColor: AppColor.whiteColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              TextConst(
                                                text: teamData
                                                    .visitorTeamPlayerCount
                                                    .toString(),
                                                textColor: AppColor.whiteColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: Sizes.fontSizeThree,
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              ContainerConst(
                                                height: 80,
                                                width: 70,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        teamData.captainImage ??
                                                            ""),
                                                    fit: BoxFit.fitWidth,
                                                    alignment:
                                                        Alignment.topCenter),
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: ContainerConst(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 2),
                                                    height: 20,
                                                    color: teamData.playerList!
                                                                .firstWhere((e) =>
                                                                    e.isCaptain ==
                                                                    1)
                                                                .teamId
                                                                .toString() ==
                                                            teamData.homeTeamId
                                                        ? AppColor.whiteColor
                                                        : AppColor.blackColor,
                                                    child: TextConst(
                                                      text: teamData
                                                              .captainName ??
                                                          "",
                                                      fontSize:
                                                          Sizes.fontSizeZero /
                                                              1.2,
                                                      textColor: teamData
                                                                  .playerList!
                                                                  .firstWhere((e) =>
                                                                      e.isCaptain ==
                                                                      1)
                                                                  .teamId
                                                                  .toString() ==
                                                              teamData
                                                                  .homeTeamId
                                                          ? AppColor.blackColor
                                                          : AppColor.whiteColor,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                              Positioned(
                                                top: -5,
                                                left: -8,
                                                child: ContainerConst(
                                                  width: Sizes.screenWidth / 15,
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  border: Border.all(
                                                      color: teamData
                                                                  .playerList!
                                                                  .firstWhere((e) =>
                                                                      e.isCaptain ==
                                                                      1)
                                                                  .teamId
                                                                  .toString() ==
                                                              teamData
                                                                  .homeTeamId
                                                          ? Colors.grey
                                                          : AppColor.whiteColor,
                                                      width: 1.5),
                                                  shape: BoxShape.circle,
                                                  color: teamData.playerList!
                                                              .firstWhere((e) =>
                                                                  e.isCaptain ==
                                                                  1)
                                                              .teamId
                                                              .toString() ==
                                                          teamData.homeTeamId
                                                      ? AppColor.whiteColor
                                                      : AppColor.blackColor,
                                                  child: TextConst(
                                                    text: "C",
                                                    textColor: teamData
                                                                .playerList!
                                                                .firstWhere((e) =>
                                                                    e.isCaptain ==
                                                                    1)
                                                                .teamId
                                                                .toString() ==
                                                            teamData.homeTeamId
                                                        ? AppColor.blackColor
                                                        : AppColor.whiteColor,
                                                    fontSize:
                                                        Sizes.fontSizeZero,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Sizes.spaceWidth20,
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              ContainerConst(
                                                height: 80,
                                                width: 70,
                                                image: DecorationImage(
                                                    image: NetworkImage(teamData
                                                            .viceCaptainImage ??
                                                        ""),
                                                    fit: BoxFit.fitWidth),
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: ContainerConst(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 2),
                                                    height: 20,
                                                    color: teamData.playerList!
                                                                .firstWhere((e) =>
                                                                    e.isCaptain ==
                                                                    1)
                                                                .teamId
                                                                .toString() ==
                                                            teamData.homeTeamId
                                                        ? AppColor.whiteColor
                                                        : AppColor.blackColor,
                                                    child: TextConst(
                                                      text: teamData
                                                              .viceCaptainName ??
                                                          "",
                                                      fontSize:
                                                          Sizes.fontSizeZero /
                                                              1.2,
                                                      textColor: teamData
                                                                  .playerList!
                                                                  .firstWhere((e) =>
                                                                      e.isCaptain ==
                                                                      1)
                                                                  .teamId
                                                                  .toString() ==
                                                              teamData
                                                                  .homeTeamId
                                                          ? AppColor.blackColor
                                                          : AppColor.whiteColor,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                              Positioned(
                                                top: -5,
                                                left: -8,
                                                child: ContainerConst(
                                                  width: Sizes.screenWidth / 15,
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  border: Border.all(
                                                      color: teamData
                                                                  .playerList!
                                                                  .firstWhere((e) =>
                                                                      e.isViceCaptain ==
                                                                      1)
                                                                  .teamId
                                                                  .toString() ==
                                                              teamData
                                                                  .homeTeamId
                                                          ? Colors.grey
                                                          : AppColor.whiteColor,
                                                      width: 1.5),
                                                  shape: BoxShape.circle,
                                                  color: teamData.playerList!
                                                              .firstWhere((e) =>
                                                                  e.isViceCaptain ==
                                                                  1)
                                                              .teamId
                                                              .toString() ==
                                                          teamData.homeTeamId
                                                      ? AppColor.whiteColor
                                                      : AppColor.blackColor,
                                                  child: TextConst(
                                                    text: "VC",
                                                    textColor: teamData
                                                                .playerList!
                                                                .firstWhere((e) =>
                                                                    e.isViceCaptain ==
                                                                    1)
                                                                .teamId
                                                                .toString() ==
                                                            teamData.homeTeamId
                                                        ? AppColor.blackColor
                                                        : AppColor.whiteColor,
                                                    fontSize:
                                                        Sizes.fontSizeZero,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    ContainerConst(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      margin: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 10,
                                          top: 5),
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: AppColor.blackColor,
                                      gradient: LinearGradient(
                                          colors: [
                                            AppColor.blackColor
                                                .withOpacity(0.35),
                                            AppColor.blackColor
                                                .withOpacity(0.2),
                                            AppColor.blackColor
                                                .withOpacity(0.1),
                                            Colors.transparent
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          playerRoleData(
                                              "WK", teamData.wK ?? ""),
                                          playerRoleData(
                                              "BAT", teamData.bAT ?? ""),
                                          playerRoleData(
                                              "AR", teamData.aR ?? ""),
                                          playerRoleData(
                                              "BOWL", teamData.bOWL ?? ""),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Container(
                    width: 30,
                  )
                ],
              );
            },
          ),
          const SizedBox(
            height: 80,
          )
        ],
      );
    });
  }

  Widget joinButton() {
    return Consumer<PlayerViewModel>(builder: (context, pvmCon, _) {
      return ContainerConst(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: AppColor.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextConst(
                  alignment: Alignment.centerLeft,
                  text: "Join with",
                  width: 100,
                  textColor: AppColor.textGreyColor,
                  fontSize: Sizes.fontSizeOne,
                ),
                TextConst(
                  alignment: Alignment.centerLeft,
                  text: "Team ${teamNo! + 1}",
                  width: 120,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ],
            ),
            ButtonConst(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return const JoinContestBottomSheetScreen();
                  },
                );
              },
              label: "join".toUpperCase(),
              width: 100,
              color: AppColor.activeButtonGreenColor,
              textColor: AppColor.whiteColor,
            ),
          ],
        ),
      );
    });
  }
}
