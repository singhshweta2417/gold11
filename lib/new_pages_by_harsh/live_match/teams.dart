import 'package:flutter/material.dart';
import 'package:gold11/new_pages_by_harsh/team_preview.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view/widgets/my_team_listing.dart';
import 'package:gold11/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:gold11/view_model/player_view_model.dart';

import '../../generated/assets.dart';
import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../../utils/utils.dart';

class Teams extends StatefulWidget {
  const Teams({super.key});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlayerViewModel>(context, listen: false).getTeam(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return avlTeamList();
  }

  Widget avlTeamList() {
    return Consumer<PlayerViewModel>(builder: (context, pvmCon, child) {
      if (pvmCon.teamData == null ||
          pvmCon.teamData!.data == null ||
          pvmCon.teamData!.data!.isEmpty) {
        return Utils.noDataAvailableVector();
      } else {
        return ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: pvmCon.teamData!.data!.length,
          itemBuilder: (_, int i) {
            final teamData = pvmCon.teamData!.data![i];
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                        context: context,
                        builder: (_) {
                          return  TeamPreview(data: teamData,);});
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
                                          "${Provider.of<ProfileViewModel>(context).userProfile!.data!.userName.toString()} ${teamData.teamName}",
                                      textColor: AppColor.whiteColor,
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
                                              arguments: {"allowEdit": true});
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
                                    teamData.matchStatus.toString()=='1'?
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
                                    ):
                                    Column(
                                      children: [
                                        const TextConst(
                                          text: 'Points',
                                          textColor: AppColor.whiteColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        TextConst(
                                          text: teamData.allPoint.toString(),
                                          textColor: AppColor.whiteColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: Sizes.fontSizeHeading,
                                        ),
                                      ],
                                    ),
                                    Sizes.spaceWidth15,
                                    teamData.matchStatus.toString()=='1'?
                                    Column(
                                      children: [
                                        TextConst(
                                          text: teamData.visitorTeamName!
                                              .toUpperCase(),
                                          textColor: AppColor.whiteColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        TextConst(
                                          text: teamData.visitorTeamPlayerCount
                                              .toString(),
                                          textColor: AppColor.whiteColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: Sizes.fontSizeThree,
                                        ),
                                      ],
                                    ):const SizedBox.shrink(),
                                    const Spacer(),
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        ContainerConst(
                                          height: 80,
                                          width: 70,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  teamData.captainImage ?? ""),
                                              fit: BoxFit.fitWidth,
                                              alignment: Alignment.topCenter),
                                          alignment: Alignment.bottomCenter,
                                          child: ContainerConst(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              height: 20,
                                              color: teamData.playerList!
                                                          .firstWhere((e) =>
                                                              e.isCaptain == 1)
                                                          .teamId
                                                          .toString() ==
                                                      teamData.homeTeamId
                                                  ? AppColor.whiteColor
                                                  : AppColor.blackColor,
                                              child: TextConst(
                                                text:
                                                    teamData.captainName ?? "",
                                                fontSize:
                                                    Sizes.fontSizeZero / 1.2,
                                                textColor: teamData.playerList!
                                                            .firstWhere((e) =>
                                                                e.isCaptain ==
                                                                1)
                                                            .teamId
                                                            .toString() ==
                                                        teamData.homeTeamId
                                                    ? AppColor.blackColor
                                                    : AppColor.whiteColor,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        ),
                                        Positioned(
                                          top: -5,
                                          left: -8,
                                          child: ContainerConst(
                                            width: Sizes.screenWidth / 15,
                                            padding: const EdgeInsets.all(2),
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
                                                            e.isCaptain == 1)
                                                        .teamId
                                                        .toString() ==
                                                    teamData.homeTeamId
                                                ? AppColor.whiteColor
                                                : AppColor.blackColor,
                                            child: TextConst(
                                              text: "C",
                                              textColor: teamData.playerList!
                                                          .firstWhere((e) =>
                                                              e.isCaptain == 1)
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
                                              image: NetworkImage(
                                                  teamData.viceCaptainImage ??
                                                      ""),
                                              fit: BoxFit.fitWidth),
                                          alignment: Alignment.bottomCenter,
                                          child: ContainerConst(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              height: 20,
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
                                                text:
                                                    teamData.viceCaptainName ??
                                                        "",
                                                fontSize:
                                                    Sizes.fontSizeZero / 1.2,
                                                textColor: teamData.playerList!
                                                    .firstWhere((e) =>
                                                e.isViceCaptain ==
                                                    1)
                                                    .teamId
                                                    .toString() ==
                                                    teamData.homeTeamId
                                                    ? AppColor.blackColor
                                                    : AppColor.whiteColor,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        ),
                                        Positioned(
                                          top: -5,
                                          left: -8,
                                          child: ContainerConst(
                                            width: Sizes.screenWidth / 15,
                                            padding: const EdgeInsets.all(2),
                                            border: Border.all(
                                                color: teamData.playerList!
                                                            .firstWhere((e) =>
                                                                e.isViceCaptain ==
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
                                                            e.isViceCaptain ==
                                                            1)
                                                        .teamId
                                                        .toString() ==
                                                    teamData.homeTeamId
                                                ? AppColor.whiteColor
                                                : AppColor.blackColor,
                                            child: TextConst(
                                              text: "VC",
                                              textColor: teamData.playerList!
                                                          .firstWhere((e) =>
                                                              e.isViceCaptain ==
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
                                  ],
                                ),
                              ),


                              ContainerConst(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10, top: 5),
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
                                    playerRoleData("BAT", teamData.bAT ?? ""),
                                    playerRoleData("AR", teamData.aR ?? ""),
                                    playerRoleData("BOWL", teamData.bOWL ?? ""),
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
      }
    });
  }
}
