import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/app_url_const.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/mlm_view_model.dart';

import '../../generated/assets.dart';
import '../../model/user_promotion_data_model.dart';
import '../../res/app_const.dart';
import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../const_widget/container_const.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MlmViewModel>(context, listen: false).getUserPromotionData(
          Provider.of<SharedPrefViewModel>(context, listen: false).userToken);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MlmViewModel>(builder: (context, mlmCon, child) {
      switch (mlmCon.mlmView){
        case MlmViewState.idle:
          return const Scaffold(body: Utils.loadingRed,);
        case MlmViewState.loading:
          return const Scaffold(body: Utils.loadingRed,);
        case MlmViewState.error:
          return Scaffold(body: Utils.noDataAvailableVector(messageLabel: "Something went wrong, try again later"));
        case MlmViewState.success:
        final promotionData = mlmCon.userPromotionData;
        return Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: appBarDesign(),
          body: SingleChildScrollView(
            child:  ContainerConst(
              child: Stack(
                children: [
                  Column(
                    children: [
                      ContainerConst(
                          height: Sizes.screenHeight / 2.8,
                          color: AppColor.blackColor,
                          gradient: AppColor.lightToDarkRedGradient,
                          width: Sizes.screenWidth),
                    ],
                  ),
                  ContainerConst(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        TextConst(
                          text: "Promotion",
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.fontSizeThree,
                          textColor: AppColor.whiteColor,
                        ),
                        Sizes.spaceHeight5,
                        TextConst(
                          text:
                          "${promotionData.yesterdayTotalCommission ?? ""}",
                          textColor: AppColor.whiteColor,
                          fontSize: Sizes.fontSizeHeading,
                        ),
                        Sizes.spaceHeight5,
                        const TextConst(
                          text: "Yesterday's total commission",
                          textColor: AppColor.whiteColor,
                        ),
                        Sizes.spaceHeight15,
                        const TextConst(
                          text: "Upgrade the level to increase level income",
                          textColor: AppColor.whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                        Sizes.spaceHeight25,
                        ordinateDataUi(promotionData),
                        Sizes.spaceHeight25,
                        inviteButton(promotionData),
                        Sizes.spaceHeight25,
                        actionButtons(Icons.keyboard, "Copy Invitation Code",
                            "${promotionData.invitationCode}", onTap: () async {
                              await Clipboard.setData(ClipboardData(text: "${promotionData.invitationCode}"));
                            }),
                        Sizes.spaceHeight15,
                        actionButtons(Icons.supervised_user_circle,
                            "Subordinate data", "", onTap: () async {
                         await mlmCon.fetchReferralSubOrdinateDataOnFilter(Provider.of<SharedPrefViewModel>(context,
                              listen: false)
                              .userToken,"");
                              Navigator.pushNamed(
                                  context, AppRoutes.mlmSubordinateScreen);
                            }),
                        Sizes.spaceHeight15,
                        actionButtons(Icons.list_alt, "Referral list", "",
                            onTap: () {
                              Provider.of<MlmViewModel>(context, listen: false)
                                  .fetchReferralData(
                                  Provider.of<SharedPrefViewModel>(context,
                                      listen: false)
                                      .userToken,
                                  AppConstants.allReferralData)
                                  .then((v) {
                                Navigator.pushNamed(
                                    context, AppRoutes.mlmReferralListScreen);
                              });
                            }),
                        Sizes.spaceHeight15,
                        actionButtons(Icons.share, "Invitation rules", "",
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.mlmInvitationRuleScreen);
                            }),
                        Sizes.spaceHeight15,
                        actionButtons(Icons.support_agent,
                            "Agent line customer service", "", onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.mlmCustomerServiceScreen);
                            }),
                        Sizes.spaceHeight20,
                        promotionDataUi(),
                        Sizes.spaceHeight10,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }


    });
  }

  PreferredSizeWidget appBarDesign() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 0,
      backgroundColor: AppColor.primaryRedColor,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: ContainerConst(
            color: AppColor.whiteColor,
            gradient: AppColor.lightToDarkRedGradient,
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                const Spacer(),
                appLogoWithName(),
                const Spacer(),
                ContainerConst(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: BoxShape.circle,
                    color: AppColor.blackColor.withOpacity(0.2),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.mlmNewSubordinateScreen);
                        },
                        icon: const Icon(
                          Icons.filter_alt_outlined,
                          color: AppColor.whiteColor,
                        )))
              ],
            ),
          )),
    );
  }

  Widget appLogoWithName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.assetsSplashLogo,
          width: Sizes.screenWidth / 12,
        ),
        Sizes.spaceWidth5,
        TextConst(
          text: AppConstants.appName,
          fontSize: Sizes.fontSizeThree,
          fontWeight: FontWeight.bold,
          textColor: AppColor.whiteColor,
        ),
        Sizes.spaceWidth20
      ],
    );
  }

  Widget ordinateDataUi(UserPromotionModel promotionData) {
    return ContainerConst(
      boxShadow: [
        BoxShadow(
            offset: const Offset(0, 2),
            color: AppColor.textGreyColor.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 1)
      ],
      padding: const EdgeInsets.only(top: 3, bottom: 10),
      borderRadius: BorderRadius.circular(15),
      color: AppColor.whiteColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonConst(
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(15)),
                label: "Direct Subordinate",
                icon: Icons.person,
                iconColor: AppColor.primaryRedColor,
                color: AppColor.scaffoldBackgroundColor,
                width: Sizes.screenWidth / 2.2,
                fontWeight: FontWeight.w600,
                height: 60,
              ),
              ButtonConst(
                borderRadius:
                    const BorderRadius.only(topRight: Radius.circular(15)),
                label: "Team Subordinate",
                icon: Icons.person,
                iconColor: AppColor.primaryRedColor,
                color: AppColor.scaffoldBackgroundColor,
                width: Sizes.screenWidth / 2.2,
                fontWeight: FontWeight.w600,
                height: 60,
              ),
            ],
          ),
          Sizes.spaceHeight5,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ordinateDataContent(
                  "${promotionData.directSubordinate!.noOfRegister ?? 0}",
                  "${promotionData.directSubordinate!.depositeNumber ?? 0}",
                  "${promotionData.directSubordinate!.depositeAmount ?? 0}",
                  "${promotionData.directSubordinate!.firstDepositeCount ?? 0}"),
              ordinateDataContent(
                  "${promotionData.teamSubordinate!.noOfRegister ?? 0}",
                  "${promotionData.teamSubordinate!.depositeNumber ?? 0}",
                  "${promotionData.directSubordinate!.depositeAmount ?? 0}",
                  "${promotionData.teamSubordinate!.firstDepositeCount ?? 0}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget ordinateDataContent(String noReg, String noDeposit, String depAmount,
      String noPeoMakeFirDep) {
    return ContainerConst(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: Sizes.screenWidth / 2.2,
      child: Column(
        children: [
          TextConst(
            text: noReg,
            fontWeight: FontWeight.w600,
            textColor: AppColor.blackColor,
          ),
          TextConst(
            text: "No of Register",
            fontWeight: FontWeight.w600,
            textColor: AppColor.textGreyColor,
            fontSize: Sizes.fontSizeOne,
          ),
          Sizes.spaceHeight10,
          TextConst(
            text: noDeposit,
            fontWeight: FontWeight.w600,
            textColor: AppColor.primaryRedColor,
          ),
          TextConst(
            text: "Deposit Number",
            fontWeight: FontWeight.w600,
            textColor: AppColor.textGreyColor,
            fontSize: Sizes.fontSizeOne,
          ),
          Sizes.spaceHeight10,
          TextConst(
            text: depAmount,
            fontWeight: FontWeight.w600,
            textColor: AppColor.activeButtonGreenColor,
          ),
          TextConst(
            text: "Deposit amount",
            fontWeight: FontWeight.w600,
            textColor: AppColor.textGreyColor,
            fontSize: Sizes.fontSizeOne,
          ),
          Sizes.spaceHeight10,
          TextConst(
            text: noPeoMakeFirDep,
            fontWeight: FontWeight.w600,
            textColor: AppColor.textGreyColor,
          ),
          TextConst(
            text: "Number of People making first deposit",
            fontWeight: FontWeight.w600,
            textColor: AppColor.textGreyColor,
            fontSize: Sizes.fontSizeOne,
            textAlign: TextAlign.center,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  Widget inviteButton(UserPromotionModel promotionData) {
    return ButtonConst(
      onTap: ()async{

          await FlutterShare.share(
              title: 'Referral Code :${promotionData.invitationCode}',
              text:"Join our gaming platform to win exciting prizes. Here is my Referral Code : *${promotionData.invitationCode}*",
              linkUrl: AppApiUrls.domainUrl,
              chooserTitle: 'Referral Code : ${promotionData.invitationCode}');
        //Share.share("${promotionData.invitationCode}", subject: "${AppApiUrls.baseUrl}   \njoin and win");
      },
      label: "invitation link".toUpperCase(),
      color: AppColor.activeButtonGreenColor,
      textColor: AppColor.whiteColor,
      fontWeight: FontWeight.w600,
    );
  }

  Widget actionButtons(IconData icon, String title, String trail,
      {void Function()? onTap}) {
    return ContainerConst(
      onTap: onTap,
      boxShadow: [
        BoxShadow(
            offset: const Offset(0, 2),
            color: AppColor.textGreyColor.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 1)
      ],
      gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            AppColor.scaffoldBackgroundColor,
            Colors.white,
            AppColor.scaffoldBackgroundColor,
          ]),
      padding: const EdgeInsets.only(top: 3, bottom: 10),
      borderRadius: BorderRadius.circular(15),
      color: AppColor.whiteColor,
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColor.textGreyColor,
        ),
        title: TextConst(
          text: title,
          alignment: Alignment.centerLeft,
          fontWeight: FontWeight.w600,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextConst(
              text: trail,
              width: 100,
              alignment: Alignment.centerRight,
            ),
            const Icon(
              Icons.navigate_next,
              color: AppColor.blackColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget promotionDataUi() {
    return Consumer<MlmViewModel>(
      builder: (context, mlmCon, child) {
        final promotionData = mlmCon.userPromotionData.promotionData;
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
              ListTile(
                leading: const Icon(Icons.content_paste),
                title: TextConst(
                  text: "Promotion Data",
                  alignment: Alignment.centerLeft,
                  fontSize: Sizes.fontSizeThree,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextConst(
                text: "${promotionData!.totalCommission??""}",
                fontWeight: FontWeight.w600,
                fontSize: Sizes.fontSizeThree,
              ),
              TextConst(
                text: "Total Commission",
                fontWeight: FontWeight.w600,
                fontSize: Sizes.fontSizeThree,
                textColor: AppColor.textGreyColor,
              ),
              Sizes.spaceHeight10,
              promotionContentTile("Direct Subordinate", "${promotionData.directSubordinate??0}"),
              promotionContentTile("Direct Total Salary", "${promotionData.directTotalSalary??0}"),
              promotionContentTile("Today Salary", "${promotionData.todaySalary??0}"),
              promotionContentTile("Total No of Subordinated in the team", "${promotionData.teamSubordinateCount??0}"),
              promotionContentTile("Total Salary", "${promotionData.teamTotalSalary??0}"),
              Sizes.spaceHeight5
            ],
          ),
        );
      }
    );
  }

  Widget promotionContentTile(String title, String count) {
    return ContainerConst(
      // color: AppColor.whiteColor,
      margin: const EdgeInsets.only(bottom: 0.5),
      border: Border(
          bottom:
              BorderSide(color: AppColor.scaffoldBackgroundColor, width: 1)),
      // boxShadow: [
      //   BoxShadow(
      //       offset: const Offset(0, 2),
      //       color: AppColor.textGreyColor.withOpacity(0.2),
      //       blurRadius: 2,
      //       spreadRadius: 1)
      // ],
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
}
