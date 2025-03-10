import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/appbar_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/mlm_view_model.dart';

class ReferralListScreen extends StatefulWidget {
  const ReferralListScreen({super.key});

  @override
  State<ReferralListScreen> createState() => _ReferralListScreenState();
}

class _ReferralListScreenState extends State<ReferralListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      appBar: const AppBarConst(
        title: "Referral List",
        appBarColor: AppColor.primaryRedColor,
      ),
      body: Stack(
        children: [
          ContainerConst(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Image.asset(Assets.assetsReferimg, width: Sizes.screenWidth/2,),
                TextConst(
                  text: 'Earn Money By Refer',
                  textColor: AppColor.whiteColor,
                  fontSize: Sizes.fontSizeLarge,
                  fontWeight: FontWeight.w600,
                ),
                Sizes.spaceHeight10,
                const TextConst(
                  text: "Introducing the KHILADI 11 Referral Program!",
                  textColor: AppColor.whiteColor,
                ),
                Sizes.spaceHeight10,
                TextConst(
                    textColor: AppColor.whiteColor,
                    textAlign: TextAlign.center,
                    fontSize: Sizes.fontSizeOne,
                    text:
                        """It's an exciting way for you to earn rewards by inviting your friends to join our community. Simply share your unique referral code with your friends through social media, email, or text. When they sign up using your code and complete their first game play, both you and your friends receive amazing rewards. Your friends get reward as a sign-up bonus, and you earn rewards for each successful referral.""")
              ],
            ),
          ),
          ContainerConst(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ContainerConst(
                    height: Sizes.screenHeight / 2.3,
                  ),
                  ContainerConst(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    minHeight: Sizes.screenHeight/1.8,
                    color: AppColor.whiteColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Column(
                      children: [
                        ContainerConst(
                          height: 5,width: 50,
                          color: AppColor.scaffoldBackgroundColor,
                        ),
                        Sizes.spaceHeight15,
                        TextConst(text: "Referral List", fontSize: Sizes.fontSizeThree,fontWeight: FontWeight.w600,),
                        const Divider(),
                        Consumer<MlmViewModel>(
                          builder: (context, mlmCon, child) {
                            if(mlmCon.myReferralData.data!.isEmpty){
                              return Utils.noDataAvailableText;
                            }
                           else{
                              return ListView.builder(
                                  itemCount: mlmCon.myReferralData.data!.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (_, int i){
                                    final data = mlmCon.myReferralData.data![i];
                                    final date = DateTime.parse(data.createdAt.toString());
                                    final referralData = DateFormat('dd/MM/yyyy').format(date);
                                    return Padding(
                                      padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                      child: ContainerConst(
                                        border: Border.all(
                                          color: Colors.grey.shade400,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        padding: const EdgeInsets.all(4),
                                        child: ContainerConst(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white,
                                          border: Border.all(width: 0.4, color: AppColor.scaffoldBackgroundColor),
                                          gradient: LinearGradient(
                                              begin: Alignment.centerRight,
                                              end: Alignment.centerLeft,
                                              colors: [
                                                const Color(0xffe3f9e7).withOpacity(0.7),
                                                const Color(0xffe3f9e7).withOpacity(0.1),
                                                const Color(0xffe3f9e7).withOpacity(0.1),
                                                const Color(0xffe3f9e7).withOpacity(0.1),
                                              ]),
                                          child: ListTile(
                                            leading: CircleAvatar(
                                                backgroundColor: AppColor.scaffoldBackgroundColor,
                                                child: const Icon(Icons.person)),
                                            title:  TextConst(text: "UID: ${data.id}",alignment: Alignment.centerLeft,fontSize: Sizes.fontSizeOne,),
                                            subtitle:  TextConst(text:data.name??"",alignment: Alignment.centerLeft,fontWeight: FontWeight.w600,),
                                            trailing:  TextConst(text: referralData,width: 100,alignment: Alignment.centerRight,),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
