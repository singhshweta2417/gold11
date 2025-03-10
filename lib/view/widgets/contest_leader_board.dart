import 'package:flutter/material.dart';
import 'package:gold11/new_pages_by_harsh/live_match/live_team_preview.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/contest_view_model.dart';

class ContestLeaderBoardList extends StatelessWidget {
  const ContestLeaderBoardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContestViewModel>(
      builder: (context, contextProvider, child) {
        final userToken = Provider.of<SharedPrefViewModel>(context, listen: false).userToken;
        var leaderboard = contextProvider.contestDetail!.leaderboard ?? [];

        // Move the user's team to the top of the list if it exists
        leaderboard = [
          ...leaderboard.where((winner) => winner.userid.toString() == userToken.toString()),
          ...leaderboard.where((winner) => winner.userid.toString() != userToken.toString())
        ];

        return ContainerConst(
          width: Sizes.screenWidth,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TextConst(
                  text: "    Be the first in your network to join the contest",
                  alignment: Alignment.centerLeft,
                  textColor: AppColor.textGreyColor,
                ),
                const Divider(),
                TextConst(
                  text: "    All Teams (${leaderboard.length})",
                  alignment: Alignment.centerLeft,
                  textColor: AppColor.textGreyColor,
                ),
                const Divider(),
                contextProvider.contestDetail!.winning!.isEmpty
                    ? Utils.noDataAvailableVector()
                    : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: leaderboard.length,
                    itemBuilder: (_, int i) {
                      final winner = leaderboard[i];

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              winner.userid.toString() == userToken.toString()
                                  ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LiveTeamPreview(
                                    data: winner,
                                    type: 0,
                                    data2: null,
                                    data3: null,
                                    data4: null,
                                  ),
                                ),
                              )
                                  : Utils.showErrorMessage(
                                context,
                                'Please wait till the match starts to view other teams',
                              );
                            },
                            child: Row(
                              children: [
                                ContainerConst(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  width: 50,
                                  height: 50,
                                  color: AppColor.whiteColor,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      winner.userimage.toString(),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Sizes.spaceWidth10,
                                TextConst(
                                  text: winner.username.toString(),
                                  alignment: Alignment.centerRight,
                                  fontWeight: FontWeight.w600,
                                ),
                                Sizes.spaceWidth10,
                                ContainerConst(
                                  width: 22,
                                  height: 16,
                                  borderRadius: BorderRadius.circular(2),
                                  shape: BoxShape.rectangle,
                                  color: AppColor.scaffoldBackgroundColor,
                                  child: TextConst(
                                    text: winner.teamName.toString(),
                                    fontSize: Sizes.fontSizeOne,
                                    textColor: AppColor.blackColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
