import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/appbar_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_field_const.dart';
import 'package:gold11/view_model/mlm_view_model.dart';

import '../../utils/utils.dart';
import '../const_widget/text_const.dart';

class SubOrdinateScreen extends StatefulWidget {
  const SubOrdinateScreen({super.key});

  @override
  State<SubOrdinateScreen> createState() => _SubOrdinateScreenState();
}

class _SubOrdinateScreenState extends State<SubOrdinateScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: const AppBarConst(
        title: "Subordinate Data",
        appBarColor: AppColor.primaryRedColor,
      ),
      body: Consumer<MlmViewModel>(builder: (context, mlmCon, child) {
        return mlmCon.dataLoading
            ? Utils.loadingRed
            : SingleChildScrollView(
                child: ContainerConst(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    children: [
                      TextFieldConst(
                        controller: searchController,
                        filled: true,
                        fillColor: AppColor.whiteColor,
                        label: const Text("Search subordinate UID or ID"),
                        outLineBorderEnabled: true,
                        borderSide:
                            const BorderSide(color: AppColor.textGreyColor),
                        sufixIcon:  IconButton(onPressed: (){
                          mlmCon.fetchReferralSubOrdinateDataOnFilter(Provider.of<SharedPrefViewModel>(context, listen: false).userToken,searchController.text.trim());
                        },icon: const Icon(Icons.search),),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      Sizes.spaceHeight15,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [tierSelection(), dateSelection()],
                      ),
                      Sizes.spaceHeight20,
                      promotionDataUi(),
                      Sizes.spaceHeight20,
                      subordinateListing()
                    ],
                  ),
                ),
              );
      }),
    );
  }

  Widget tierSelection() {
    return Consumer<MlmViewModel>(builder: (context, mlmCon, child) {
      return ContainerConst(
        height: 60,
        width: Sizes.screenWidth / 2.2,
        color: AppColor.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          showSubordinateFilterBottomSheet(context);
        },
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextConst(
              text: "Tier: ${mlmCon.selectedTierIndex}",
              fontWeight: FontWeight.w600,
              fontSize: Sizes.fontSizeThree,
            ),
            const Icon(Icons.expand_more)
          ],
        ),
      );
    });
  }

  Widget dateSelection() {
    return Consumer<MlmViewModel>(builder: (context, mlmCon, child) {
      return ContainerConst(
        height: 60,
        width: Sizes.screenWidth / 2.2,
        color: AppColor.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          mlmCon.pickDate(context);
        },
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextConst(
              text: mlmCon.selectedDate != null
                  ? "${mlmCon.selectedDate!.day}/${mlmCon.selectedDate!.month}/${mlmCon.selectedDate!.year}"
                  : "Select Date",
              fontWeight: FontWeight.w600,
              fontSize: Sizes.fontSizeThree,
            ),
            const Icon(Icons.expand_more)
          ],
        ),
      );
    });
  }

  Widget promotionDataUi() {
    return Consumer<MlmViewModel>(builder: (context, mlmCon, child) {
      return ContainerConst(
        color: AppColor.whiteColor,
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xffe3f9e7).withOpacity(0.5),
              const Color(0xffe3f9e7).withOpacity(0.1),
              const Color(0xffe3f9e7).withOpacity(0.1),
            ]),
        border: Border.all(color: AppColor.textGreyColor),
        borderRadius: BorderRadius.circular(15),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            promotionContentTile(
                "Deposit Number",
                mlmCon.teamWiseFilterData.details!.totalDepositAmount??""
                    .toString()),
            promotionContentTile(
                "Number of better",
                mlmCon.teamWiseFilterData.details!.numberOfBetter
                    .toString()),
            promotionContentTile(
                "Total bet",
                mlmCon.teamWiseFilterData.details!.totalBet
                    .toString()),
            promotionContentTile(
                "First deposit amount",
                mlmCon.teamWiseFilterData.details!.firstDepositAmount
                    .toString()),
            promotionContentTile(
                "Number of people making first deposit",
                mlmCon.teamWiseFilterData.details!.firstDepositCount
                    .toString()),
            Sizes.spaceHeight5
          ],
        ),
      );
    });
  }

  Widget promotionContentTile(String title, String count) {
    return ContainerConst(
      margin: const EdgeInsets.only(bottom: 0.5),
      border: Border(
          bottom:
              BorderSide(color: AppColor.scaffoldBackgroundColor, width: 1)),
      child: ListTile(
        title: TextConst(
          text: title,
          alignment: Alignment.centerLeft,
        ),
        trailing: TextConst(
          text: count,
          width: 70,
          alignment: Alignment.centerRight,
        ),
      ),
    );
  }

  Widget subordinateListing() {
    return Consumer<MlmViewModel>(builder: (context, twsCon, child) {
      return twsCon.teamWiseFilterData.data!.isEmpty
          ? Utils.noDataAvailableVector()
          : ContainerConst(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: twsCon.teamWiseFilterData.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (_, int i) {
                    final subordinate = twsCon.teamWiseFilterData.data![i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: ContainerConst(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            color: AppColor.textGreyColor.withOpacity(0.2),
                            blurRadius: 2,
                            spreadRadius: 1,
                          )
                        ],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                await Clipboard.setData(
                                    ClipboardData(text: "${subordinate.id}"));
                              },
                              child: Row(
                                children: [
                                  TextConst(
                                    text: "UID: ${subordinate.id}",
                                    alignment: Alignment.centerLeft,
                                    textColor: AppColor.textGreyColor,
                                    fontSize: Sizes.fontSizeThree,
                                  ),
                                  Sizes.spaceWidth15,
                                  const Icon(Icons.copy, size: 18),
                                ],
                              ),
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextConst(
                                  text: "Level ",
                                  width: Sizes.screenWidth / 2.5,
                                  alignment: Alignment.centerLeft,
                                  textColor: AppColor.textGreyColor,
                                ),
                                TextConst(
                                  text: subordinate.level.toString(),
                                  width: Sizes.screenWidth / 2.5,
                                  alignment: Alignment.centerRight,
                                  textColor: AppColor.textGreyColor,
                                ),
                              ],
                            ),
                            Sizes.spaceHeight5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextConst(
                                  text: "Deposit amount",
                                  width: Sizes.screenWidth / 2,
                                  alignment: Alignment.centerLeft,
                                ),
                                TextConst(
                                  text:
                                      "${Utils.rupeeSymbol} ${subordinate.depositAmount ?? ""}",
                                  width: 100,
                                  alignment: Alignment.centerRight,
                                ),
                              ],
                            ),
                            Sizes.spaceHeight5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextConst(
                                  text: "Bet amount",
                                  width: Sizes.screenWidth / 2,
                                  alignment: Alignment.centerLeft,
                                ),
                                TextConst(
                                  text:
                                      "${Utils.rupeeSymbol} ${subordinate.betAmount ?? ""}",
                                  width: 100,
                                  alignment: Alignment.centerRight,
                                ),
                              ],
                            ),
                            Sizes.spaceHeight5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextConst(
                                  text: "Commission",
                                  width: Sizes.screenWidth / 2,
                                  alignment: Alignment.centerLeft,
                                ),
                                TextConst(
                                  text: subordinate.commissionAmount ?? "",
                                  width: 100,
                                  alignment: Alignment.centerRight,
                                ),
                              ],
                            ),
                            Sizes.spaceHeight5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextConst(
                                  text: "Date",
                                  width: Sizes.screenWidth / 2,
                                  alignment: Alignment.centerLeft,
                                ),
                                TextConst(
                                  text:
                                      subordinate.createdAt!.substring(0, 10),
                                  width: 100,
                                  alignment: Alignment.centerRight,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
    });
  }

  void showSubordinateFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Consumer<MlmViewModel>(builder: (context, mlmCon, child) {
          return ContainerConst(
            height: Sizes.screenHeight / 2.5,
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(20),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: TextConst(
                    text: "Tier $index",
                    alignment: Alignment.center,
                    textColor: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                  onTap: () {
                    mlmCon.setTearIndex(context, index);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          );
        });
      },
    );
  }
}

class Subordinate {
  final String id;
  final String uid;
  final String level;
  final String tier;
  final double depositAmount;
  final double betAmount;
  final double commission;
  final String date;

  Subordinate({
    required this.id,
    required this.uid,
    required this.level,
    required this.tier,
    required this.depositAmount,
    required this.betAmount,
    required this.commission,
    required this.date,
  });
}
