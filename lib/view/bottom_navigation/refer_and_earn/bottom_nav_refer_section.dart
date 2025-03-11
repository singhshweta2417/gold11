import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gold11/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/app_const.dart';
import 'package:gold11/res/app_url_const.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/utils/url_launcher.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view_model/mlm_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomNavReferSection extends StatefulWidget {
  const BottomNavReferSection({super.key});

  @override
  State<BottomNavReferSection> createState() => _BottomNavReferSectionState();
}

class _BottomNavReferSectionState extends State<BottomNavReferSection> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileViewModel>(context, listen: false);
          // .getUserPromotionData(
          // Provider.of<SharedPrefViewModel>(context, listen: false).userToken);

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProfileViewModel>(builder: (context, profileProvider, child) {
            final promotionData = profileProvider.userProfile?.data?.InvitationCode;
            print(promotionData);
            print('promotionDataf[h;g[j;[f;k=g[uk;');

        return ContainerConst(
         color: AppColor.whiteColor,
         child: Column(
           children: [
             ContainerConst(
               color: AppColor.primaryRedColor,
               height: Sizes.screenHeight * 0.5,
               image: const DecorationImage(
                   image: AssetImage(Assets.assetsReferbg),
                   fit: BoxFit.cover),
               child: Column(
                 children: [
                   SizedBox(
                     height: Sizes.screenHeight * 0.05,
                   ),
                   Align(
                     alignment: Alignment.topRight,
                     child: Padding(
                       padding:  const EdgeInsets.only(right: 18),
                       child: ContainerConst(
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
                         },
                         height: Sizes.screenHeight * 0.03,
                         width: Sizes.screenWidth * 0.08,
                         //   color: AppColor.activeButtonGreenColor,
                       ),
                     ),
                   ),
                   SizedBox(
                     height: Sizes.screenHeight * 0.02,
                   ),
                   // TextConst(
                   //   text: 'Refer & Earn',
                   //   textColor: AppColor.whiteColor,
                   //   fontSize: Sizes.fontSizeLarge,
                   //   fontWeight: FontWeight.w600,
                   // ),
                   SizedBox(
                     height: Sizes.screenHeight * 0.255,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       ContainerConst(
                         onTap: () {
                           UrlHelper.launchReferralCode(
                               invitationCode:
                               promotionData.invitationCode.toString(),
                               domainUrl: AppApiUrls.domainUrl);
                         },
                         height: Sizes.screenHeight * 0.05,
                         width: Sizes.screenWidth * 0.66,
                         // color: AppColor.activeButtonGreenColor,
                       ),
                       SizedBox(
                         width: Sizes.screenWidth * 0.02,
                       ),
                       ContainerConst(
                         onTap: () async {
                           print(promotionData);
                           await FlutterShare.share(
                               title:
                               'Referral Code :${promotionData??""}',
                               text:
                               "Join our gaming platform to win exciting prizes. Here is my Referral Code : *${promotionData??""}*",
                               linkUrl: AppApiUrls.domainUrl,
                               chooserTitle:
                               'Referral Code : ${promotionData??""}');
                         },
                         height: Sizes.screenHeight * 0.05,
                         width: Sizes.screenWidth * 0.12,
                         //color: AppColor.activeButtonGreenColor,
                       ),
                     ],
                   )
                 ],
               ),
             ),
             ContainerConst(
               height: Sizes.screenHeight * 0.26,
               width: Sizes.screenWidth * 0.9,
               image: const DecorationImage(
                   image: AssetImage(Assets.assetsReferlogo),
                   fit: BoxFit.fill),
             )
           ],
         ),
       );
        //
        // switch (mlmCon.mlmView) {
        //   case MlmViewState.idle:
        //     return const Scaffold(
        //       body: Utils.loadingRed,
        //     );
        //   case MlmViewState.loading:
        //     return const Scaffold(
        //       body: Utils.loadingRed,
        //     );
        //   case MlmViewState.error:
        //     return Scaffold(
        //         body: Utils.noDataAvailableVector(
        //             messageLabel: "Something went wrong, try again later"));
        //   case MlmViewState.success:
        //     final promotionData = mlmCon.userPromotionData;
        //     return ContainerConst(
        //       color: AppColor.whiteColor,
        //       child: Column(
        //         children: [
        //           ContainerConst(
        //             color: AppColor.primaryRedColor,
        //             height: Sizes.screenHeight * 0.5,
        //             image: const DecorationImage(
        //                 image: AssetImage(Assets.assetsReferbg),
        //                 fit: BoxFit.cover),
        //             child: Column(
        //               children: [
        //                 SizedBox(
        //                   height: Sizes.screenHeight * 0.05,
        //                 ),
        //                 Align(
        //                   alignment: Alignment.topRight,
        //                   child: Padding(
        //                     padding:  const EdgeInsets.only(right: 18),
        //                     child: ContainerConst(
        //                       onTap: () {
        //                         Provider.of<MlmViewModel>(context, listen: false)
        //                             .fetchReferralData(
        //                             Provider.of<SharedPrefViewModel>(context,
        //                                 listen: false)
        //                                 .userToken,
        //                             AppConstants.allReferralData)
        //                             .then((v) {
        //                           Navigator.pushNamed(
        //                               context, AppRoutes.mlmReferralListScreen);
        //                         });
        //                       },
        //                       height: Sizes.screenHeight * 0.03,
        //                       width: Sizes.screenWidth * 0.08,
        //                    //   color: AppColor.activeButtonGreenColor,
        //                     ),
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: Sizes.screenHeight * 0.02,
        //                 ),
        //                 // TextConst(
        //                 //   text: 'Refer & Earn',
        //                 //   textColor: AppColor.whiteColor,
        //                 //   fontSize: Sizes.fontSizeLarge,
        //                 //   fontWeight: FontWeight.w600,
        //                 // ),
        //                 SizedBox(
        //                   height: Sizes.screenHeight * 0.255,
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     ContainerConst(
        //                       onTap: () {
        //                         UrlHelper.launchReferralCode(
        //                             invitationCode:
        //                                 promotionData.invitationCode.toString(),
        //                             domainUrl: AppApiUrls.domainUrl);
        //                       },
        //                       height: Sizes.screenHeight * 0.05,
        //                       width: Sizes.screenWidth * 0.66,
        //                      // color: AppColor.activeButtonGreenColor,
        //                     ),
        //                     SizedBox(
        //                       width: Sizes.screenWidth * 0.02,
        //                     ),
        //                     ContainerConst(
        //                       onTap: () async {
        //                         await FlutterShare.share(
        //                             title:
        //                                 'Referral Code :${promotionData.invitationCode}',
        //                             text:
        //                                 "Join our gaming platform to win exciting prizes. Here is my Referral Code : *${promotionData.invitationCode}*",
        //                             linkUrl: AppApiUrls.domainUrl,
        //                             chooserTitle:
        //                                 'Referral Code : ${promotionData.invitationCode}');
        //                       },
        //                       height: Sizes.screenHeight * 0.05,
        //                       width: Sizes.screenWidth * 0.12,
        //                       //color: AppColor.activeButtonGreenColor,
        //                     ),
        //                   ],
        //                 )
        //               ],
        //             ),
        //           ),
        //           ContainerConst(
        //             height: Sizes.screenHeight * 0.26,
        //             width: Sizes.screenWidth * 0.9,
        //             image: const DecorationImage(
        //                 image: AssetImage(Assets.assetsReferlogo),
        //                 fit: BoxFit.fill),
        //           )
        //         ],
        //       ),
        //     );
        // }
      }),
    );
  }

}
