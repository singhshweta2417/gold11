import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/profile_view_model.dart';
import 'package:gold11/view_model/wallet_view_model.dart';

import '../const_widget/appbar_const.dart';
import '../const_widget/container_const.dart';

class MyBalanceScreen extends StatefulWidget {
  const MyBalanceScreen({super.key});

  @override
  State<MyBalanceScreen> createState() => _MyBalanceScreenState();
}

class _MyBalanceScreenState extends State<MyBalanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: const AppBarConst(
        title: "My Balance",
        appBarColor: AppColor.primaryRedColor,
      ),
      body: ContainerConst(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        color: AppColor.whiteColor,
        child: ListView(
          children: [
            currentBalanceTile(),
            Sizes.spaceHeight15,
            myTransTile(),
            Sizes.spaceHeight15,
            managePayment(),
            Sizes.spaceHeight15,
            inviteAndCollect()
          ],
        ),
      ),
    );
  }

  Widget currentBalanceTile() {
    return Consumer<ProfileViewModel>(
      builder: (context, profileProvider, child) {
        final userData = profileProvider.userProfile!.data!;
        return ContainerConst(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          border: Border.all(width: 0.5, color: AppColor.textGreyColor),
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              TextConst(
                text: "Current Balance",
                textColor: AppColor.textGreyColor,
                fontSize: Sizes.fontSizeOne,
              ),
              Sizes.spaceHeight10,
              TextConst(
                text: "${Utils.rupeeSymbol}${profileProvider.userProfile!.data!.wallet}",
                fontSize: Sizes.fontSizeLarge,
                fontWeight: FontWeight.w600,
              ),
              Sizes.spaceHeight15,
              ButtonConst(
                onTap: (){
                  Navigator.pushNamed(context, AppRoutes.walletAddCashScreen);
                },
                label: "add cash".toUpperCase(),
                width: Sizes.screenWidth / 4,
                height: 45,
                color: AppColor.activeButtonGreenColor,
                textColor: AppColor.whiteColor,
                fontWeight: FontWeight.w600,
              ),
              Sizes.spaceHeight10,
              Divider(
                color: AppColor.scaffoldBackgroundColor,
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Row(
                  children: [
                    TextConst(
                      text: "Amount Un utilised",
                      alignment: Alignment.centerLeft,
                      textColor: AppColor.textGreyColor,
                      fontSize: Sizes.fontSizeOne,
                    ),
                    Sizes.spaceWidth10,
                    const Icon(
                      CupertinoIcons.info,
                      color: AppColor.textGreyColor,
                      size: 18,
                    )
                  ],
                ),
                subtitle:  TextConst(
                  text: "${Utils.rupeeSymbol}${userData.unUtilisedWallet}",
                  alignment: Alignment.centerLeft,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Divider(
                color: AppColor.scaffoldBackgroundColor,
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Row(
                  children: [
                    TextConst(
                      text: "Winnings",
                      alignment: Alignment.centerLeft,
                      textColor: AppColor.textGreyColor,
                      fontSize: Sizes.fontSizeOne,
                    ),
                    Sizes.spaceWidth10,
                    const Icon(
                      CupertinoIcons.info,
                      color: AppColor.textGreyColor,
                      size: 18,
                    ),
                  ],
                ),
                subtitle:  TextConst(
                  text: "${Utils.rupeeSymbol}${userData.winningWallet}",
                  alignment: Alignment.centerLeft,
                  fontWeight: FontWeight.w600,
                ),
                trailing: ButtonConst(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoutes.walletWithdrawAmount);
                  },
                  label: "Verify to withdraw".toUpperCase(),
                  width: Sizes.screenWidth / 2.6,
                  height: Sizes.screenHeight / 28,
                  borderRadius: BorderRadius.circular(5),
                  fontWeight: FontWeight.w600,
                  border: Border.all(color: AppColor.textGreyColor),
                  color: AppColor.whiteColor,
                  fontSize: Sizes.fontSizeOne,
                ),
              ),
              Divider(
                color: AppColor.scaffoldBackgroundColor,
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Row(
                  children: [
                    TextConst(
                      text: "Discount Bonus",
                      alignment: Alignment.centerLeft,
                      textColor: AppColor.textGreyColor,
                      fontSize: Sizes.fontSizeOne,
                    ),
                    Sizes.spaceWidth10,
                    const Icon(
                      CupertinoIcons.info,
                      color: AppColor.textGreyColor,
                      size: 18,
                    )
                  ],
                ),
                subtitle:  TextConst(
                  text: "${Utils.rupeeSymbol}${userData.bonusWallet}",
                  alignment: Alignment.centerLeft,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Sizes.spaceHeight20,
              ContainerConst(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    width: 0.5,
                    color: AppColor.activeButtonGreenColor.withOpacity(0.5)),
                child: Row(
                  children: [
                    const Icon(
                      Icons.money,
                      color: AppColor.activeButtonGreenColor,
                      size: 35,
                    ),
                    Sizes.spaceWidth5,
                    TextConst(
                      text:
                          "Maximum usable discount bonus per month = 10% of entry",
                      fontSize: Sizes.fontSizeZero,
                      textColor: AppColor.textGreyColor,
                      width: Sizes.screenWidth / 1.6,
                      alignment: Alignment.centerLeft,
                      textAlign: TextAlign.left,
                    ),
                    const Spacer(),
                    const Icon(Icons.clear)
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget myTransTile(){
    return Consumer<WalletViewModel>(
      builder: (context, walletProvider, child) {
        return ContainerConst(
          onTap: (){
            walletProvider.getTransactionType(context).then((v){
              walletProvider.getUserTransactions(context, Provider.of<SharedPrefViewModel>(context, listen: false).userToken).then((v){
                Navigator.pushNamed(context, AppRoutes.walletMyTransactionScreen);
              });
            });
          },
          border: Border.all(width: 0.5, color: AppColor.textGreyColor),
          borderRadius: BorderRadius.circular(10),
          child: const ListTile(
            title: TextConst(text: "My Transactions",alignment: Alignment.centerLeft,),
            trailing: Icon(Icons.navigate_next_outlined),
          ),
        );
      }
    );
  }

  Widget managePayment(){
    return ContainerConst(
      border: Border.all(width: 0.5, color: AppColor.textGreyColor),
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        title: const TextConst(text: "Manage Payments",alignment: Alignment.centerLeft,),
        subtitle: TextConst(text: "Add/Remove cards, wallets, etc",alignment: Alignment.centerLeft,fontSize: Sizes.fontSizeOne,textColor: AppColor.textGreyColor,),
        trailing: const Icon(Icons.navigate_next_outlined),
      ),
    );
  }

  Widget inviteAndCollect(){
    return ContainerConst(
      onTap: (){
        Navigator.pushNamed(context, AppRoutes.mlmHomeScreen);
      },
      border: Border.all(width: 0.5, color: AppColor.textGreyColor),
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        title: const TextConst(text: "Invite & Collect",alignment: Alignment.centerLeft,),
        subtitle: TextConst(text: "Bring your friends on Dream 11 and earn rewards",alignment: Alignment.centerLeft,fontSize: Sizes.fontSizeOne,textColor: AppColor.textGreyColor,),
        trailing: const Icon(Icons.navigate_next_outlined),
      ),
    );
  }
}
