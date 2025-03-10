import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold11/new_pages_by_harsh/team_preview.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/player_view_model.dart';
import 'package:gold11/view_model/profile_view_model.dart';

class MyTeamList extends StatefulWidget {
  const MyTeamList({super.key});

  @override
  State<MyTeamList> createState() => _MyTeamListState();
}

class _MyTeamListState extends State<MyTeamList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(builder: (context, pvmCon, child) {
      return pvmCon.teamData!.data!.isEmpty
          ? Column(
              children: [
                Container(
                  height: Sizes.screenHeight * 0.7,
                  width: Sizes.screenWidth,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          Assets.assetsTeampageNodata,
                        ),
                        fit: BoxFit.fill),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "You haven't created a team yet!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.blackColor,
                            fontSize: Sizes.fontSizeThree,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "The first step to winning starts here",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.textGreyColor,
                            fontSize: Sizes.fontSizeOne,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: Sizes.screenHeight * 0.04,
                      ),
                      ButtonConst(
                        onTap: () {
                          Provider.of<PlayerViewModel>(context, listen: false)
                              .clearSelectedPlayerList();
                        //  contestProvider.setEnableJoinContestBottomSheet(false);
                          Navigator.pushNamed(context, AppRoutes.createTeamScreen);
                        },
                        //  label: 'Create a team'.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 14),
                        color: AppColor.activeButtonGreenColor,
                        textColor: AppColor.whiteColor,
                        width: Sizes.screenWidth * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              CupertinoIcons.add_circled,
                              weight: 500,
                              color: AppColor.whiteColor,
                            ),
                            Text(
                              'Create a team'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontSize: Sizes.fontSizeTwo,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: pvmCon.teamData!.data!.length,
              itemBuilder: (_, int i) {
                final teamData = pvmCon.teamData!.data![i];
                return Padding(
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
                                    color: AppColor.blackColor.withOpacity(0.3),
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 3, bottom: 3),
                                    child: Row(
                                      children: [
                                        TextConst(
                                          text:
                                              "${Provider.of<ProfileViewModel>(context).userProfile!.data!.name} ${teamData.teamName}",
                                          textColor: AppColor.whiteColor,
                                          width: 120,
                                        ),
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {
                                              final pvmCon =
                                                  Provider.of<PlayerViewModel>(
                                                      context,
                                                      listen: false);
                                              pvmCon.clearSelectedPlayerList();
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
                                              text: teamData.homeTeamPlayerCount
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
                                              alignment: Alignment.bottomCenter,
                                              child: ContainerConst(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 2),
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
                                                    text:
                                                        teamData.captainName ??
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
                                                            teamData.homeTeamId
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
                                                    color: teamData.playerList!
                                                                .firstWhere((e) =>
                                                                    e.isCaptain ==
                                                                    1)
                                                                .teamId
                                                                .toString() ==
                                                            teamData.homeTeamId
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
                                                  fontSize: Sizes.fontSizeZero,
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
                                              alignment: Alignment.bottomCenter,
                                              child: ContainerConst(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 2),
                                                  height: 20,
                                                  color: teamData.playerList!
                                                              .firstWhere((e) =>
                                                                  e.isCaptain
                                                                      .toString() ==
                                                                  "1")
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
                                                                    e.isCaptain
                                                                        .toString() ==
                                                                    "1")
                                                                .teamId
                                                                .toString() ==
                                                            teamData.homeTeamId
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
                                                    color: teamData.playerList!
                                                                .firstWhere((e) =>
                                                                    e.isViceCaptain
                                                                        .toString() ==
                                                                    "1")
                                                                .teamId
                                                                .toString() ==
                                                            teamData.homeTeamId
                                                        ? Colors.grey
                                                        : AppColor.whiteColor,
                                                    width: 1.5),
                                                shape: BoxShape.circle,
                                                color: teamData.playerList!
                                                            .firstWhere((e) =>
                                                                e.isViceCaptain
                                                                    .toString() ==
                                                                "1")
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
                                                                  e.isViceCaptain
                                                                      .toString() ==
                                                                  "1")
                                                              .teamId
                                                              .toString() ==
                                                          teamData.homeTeamId
                                                      ? AppColor.blackColor
                                                      : AppColor.whiteColor,
                                                  fontSize: Sizes.fontSizeZero,
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
                                          AppColor.blackColor.withOpacity(0.35),
                                          AppColor.blackColor.withOpacity(0.2),
                                          AppColor.blackColor.withOpacity(0.1),
                                          Colors.transparent
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        playerRoleData("WK", teamData.wK ?? ""),
                                        playerRoleData(
                                            "BAT", teamData.bAT ?? ""),
                                        playerRoleData("AR", teamData.aR ?? ""),
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
                    ));
              },
            );
    });
  }
}

Widget playerRoleData(String role, String value) {
  return Row(
    children: [
      TextConst(
        text: role,
        textColor: AppColor.whiteColor.withOpacity(0.6),
      ),
      Sizes.spaceWidth5,
      TextConst(
        text: value,
        textColor: AppColor.whiteColor,
        fontWeight: FontWeight.w600,
      ),
    ],
  );
}
