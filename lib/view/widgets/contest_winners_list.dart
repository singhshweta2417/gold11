import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/contest_view_model.dart';

class ContestWinnersList extends StatelessWidget {
  const ContestWinnersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContestViewModel>(
      builder: (context, contextProvider, child) {
        if (contextProvider.contestDetail == null) {
          return Utils.loadingRed;
        }
        final contestDetail = contextProvider.contestDetail;
        final winningList = contestDetail!.winning;
        return Center(
          child: ContainerConst(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: TextConst(
                    width: Sizes.screenWidth / 3,
                    text: "rank".toUpperCase(),
                    alignment: Alignment.centerLeft,
                    textColor: AppColor.textGreyColor,
                  ),
                  trailing: TextConst(
                    width: Sizes.screenWidth / 3,
                    text: "prize".toUpperCase(),
                    alignment: Alignment.centerRight,
                    fontWeight: FontWeight.w600,
                    textColor: AppColor.textGreyColor,
                  ),
                ),
                winningList == null || winningList.isEmpty
                    ? Utils.noDataAvailableVector()
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          itemCount: winningList.length,
                          itemBuilder: (_, int i) {
                            final winner = winningList[i];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              leading: winner.rank.toString() == '1' ||
                                      winner.rank.toString() == '2' ||
                                      winner.rank.toString() == '3'
                                  ? ContainerConst(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: 50,
                                      height: 50,
                                      color: AppColor.whiteColor,
                                      image: const DecorationImage(
                                          image:
                                              AssetImage(Assets.assetsCrownLeave),
                                          fit: BoxFit.cover),
                                      child: TextConst(
                                        text: winner.rank ?? "",
                                        textColor: AppColor.blackColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : TextConst(
                                      width: 50,
                                      text: "#${winner.rank}",
                                      textColor: AppColor.blackColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                              title: TextConst(
                                text: "${Utils.rupeeSymbol}${winner.prize}",
                                alignment: Alignment.centerRight,
                                fontWeight: FontWeight.w600,
                              ),
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
