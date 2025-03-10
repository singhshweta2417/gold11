import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view_model/profile_view_model.dart';
import 'package:gold11/view_model/wallet_view_model.dart';

import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../const_widget/container_const.dart';
import '../const_widget/text_const.dart';
import '../const_widget/text_field_const.dart';

class AddCashScreen extends StatelessWidget {
  const AddCashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
        builder: (context, profileProvider, child) {
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: appBarDesign(context),
        body: Column(
          children: [
            currentBalanceTile(profileProvider),
            textFieldWithAmountOptionTile(),
          ],
        ),
        bottomSheet: bottomSheetContent(profileProvider),
      );
    });
  }

  PreferredSizeWidget appBarDesign(context) {
    return AppBar(
      elevation: 0,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: ContainerConst(
            color: AppColor.whiteColor,
            gradient: AppColor.darkRedToBlackGradientTwo,
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColor.whiteColor,
                  ),
                ),
                Sizes.spaceWidth20,
                TextConst(
                  text: "Add Cash",
                  textColor: AppColor.whiteColor,
                  fontSize: Sizes.fontSizeLarge / 1.25,
                  alignment: FractionalOffset.centerLeft,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          )),
    );
  }

  Widget currentBalanceTile(ProfileViewModel profileProvider) {
    final userData = profileProvider.userProfile?.data;
    return Consumer<WalletViewModel>(builder: (context, walletProvider, child) {
      return ContainerConst(
        color: AppColor.whiteColor,
        child: ExpansionTile(
          onExpansionChanged: (v) {
            walletProvider.isCurrentTileChangeNotify(v);
          },
          leading: const Icon(
            Icons.wallet,
            color: Colors.deepOrangeAccent,
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextConst(
                text: "Current Balance",
              ),
              Sizes.spaceWidth15,
              walletProvider.isCurrentTileExpanded
                  ? const Icon(Icons.expand_less_rounded)
                  : const Icon(Icons.expand_more)
            ],
          ),
          trailing: TextConst(
            text: "${Utils.rupeeSymbol}${userData!.wallet}",
            fontWeight: FontWeight.bold,
            width: 150,
            alignment: Alignment.centerRight,
          ),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            currentBalanceChildTile("Amount Added (un utilised)", "Amount",
                "${userData.unUtilisedWallet}"),
            Sizes.spaceHeight10,
            currentBalanceChildTile(
                "Winnings", "Amount", "${userData.winningWallet}"),
            Sizes.spaceHeight10,
            currentBalanceChildTile(
                "Cash Bonus", "Amount", "${userData.bonusWallet}"),
            Sizes.spaceHeight15,
          ],
        ),
      );
    });
  }

  Widget currentBalanceChildTile(String title, String infoText, String amount) {
    return Row(
      children: [
        TextConst(
          text: title,
          fontSize: Sizes.fontSizeOne,
          textColor: AppColor.textGreyColor,
        ),
        Sizes.spaceWidth5,
        const Icon(
          CupertinoIcons.info,
          size: 17,
        ),
        const Spacer(),
        TextConst(
          text: "${Utils.rupeeSymbol}$amount",
          width: 100,
          alignment: Alignment.centerRight,
          fontSize: Sizes.fontSizeOne,
          textColor: AppColor.textGreyColor,
          fontWeight: FontWeight.w600,
          padding: const EdgeInsets.only(right: 5),
        ),
      ],
    );
  }

  Widget textFieldWithAmountOptionTile() {
    return Consumer<WalletViewModel>(builder: (context, walletProvider, child) {
      return ContainerConst(
          alignment: Alignment.center,
          color: AppColor.whiteColor,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xffe3f9e7).withOpacity(0.2),
                Colors.cyan.shade50.withOpacity(0.05),
              ]),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  amountField(),
                  const Spacer(),
                  Row(
                    children: List.generate(
                        walletProvider.amountSelectionOptions.length, (i) {
                      final amount = walletProvider.amountSelectionOptions[i];
                      return ContainerConst(
                        margin: const EdgeInsets.only(right: 10),
                        onTap: () {
                          walletProvider.selectAmountFromOptions(
                              double.parse(amount.toString()));
                        },
                        width: Sizes.screenWidth / 6,
                        color: AppColor.whiteColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        border: Border.all(
                            color: walletProvider.amount == amount
                                ? AppColor.textGreyColor
                                : AppColor.scaffoldBackgroundColor),
                        borderRadius: BorderRadius.circular(25),
                        child: TextConst(
                          text:
                              "${Utils.rupeeSymbol}${amount.toStringAsFixed(0)}",
                          textColor: AppColor.textGreyColor,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              Sizes.spaceHeight20,
              addAmountValueInfoAndChargeTile()
            ],
          ));
    });
  }

  Widget addAmountValueInfoAndChargeTile() {
    return Consumer<WalletViewModel>(builder: (context, walletProvider, child) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          ContainerConst(
            color: AppColor.whiteColor,
            border: Border.all(color: Colors.blueAccent.shade100, width: 1),
            borderRadius: BorderRadius.circular(10),
            child: ExpansionTile(
              onExpansionChanged: (v) {
                walletProvider.isInfoTileChangeNotify(v);
              },
              title: const TextConst(
                text: "Add to Current Balance",
                alignment: Alignment.centerLeft,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextConst(
                    text: "${Utils.rupeeSymbol}${walletProvider.amount}",
                    width: 100,
                    alignment: Alignment.centerRight,
                  ),
                  walletProvider.isInfoTileExpanded
                      ? const Icon(
                          Icons.arrow_drop_up,
                          size: 30,
                        )
                      : const Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                        ),
                ],
              ),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                const Divider(),
                Row(
                  children: [
                    TextConst(
                      text: "Deposit Amount (excl. Govt. Tax)",
                      fontSize: Sizes.fontSizeOne,
                      textColor: AppColor.blackColor,
                    ),
                    const Spacer(),
                    TextConst(
                      text: "${Utils.rupeeSymbol}${walletProvider.amount}",
                      width: 100,
                      alignment: Alignment.centerRight,
                      textColor: AppColor.activeButtonGreenColor,
                      padding: const EdgeInsets.only(right: 15),
                    ),
                  ],
                ),
                Sizes.spaceHeight10,
                Row(
                  children: [
                    TextConst(
                      text: "Govt. Tax (28% GST)",
                      fontSize: Sizes.fontSizeOne,
                      textColor: AppColor.blackColor,
                    ),
                    const Spacer(),
                    TextConst(
                      text:
                          "${Utils.rupeeSymbol}${walletProvider.deductionAmount}",
                      width: 100,
                      alignment: Alignment.centerRight,
                      textColor: AppColor.activeButtonGreenColor,
                      padding: const EdgeInsets.only(right: 15),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    TextConst(
                      text: "Total",
                      fontSize: Sizes.fontSizeOne,
                      textColor: AppColor.blackColor,
                    ),
                    const Spacer(),
                    TextConst(
                      text: "${Utils.rupeeSymbol}${walletProvider.amount}",
                      width: 100,
                      alignment: Alignment.centerRight,
                      textColor: AppColor.activeButtonGreenColor,
                      padding: const EdgeInsets.only(right: 15),
                    ),
                  ],
                ),
                Sizes.spaceHeight10,
                Row(
                  children: [
                    TextConst(
                      text: "Discount Point Worth",
                      fontSize: Sizes.fontSizeOne,
                      textColor: AppColor.blackColor,
                    ),
                    const Spacer(),
                    TextConst(
                      text:
                          "${Utils.rupeeSymbol}${walletProvider.deductionAmount}",
                      width: 100,
                      alignment: Alignment.centerRight,
                      textColor: AppColor.activeButtonGreenColor,
                      padding: const EdgeInsets.only(right: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: -10,
            left: 25,
            child: ContainerConst(
              color: Colors.white,
              border:
                  const Border(bottom: BorderSide(color: AppColor.whiteColor)),
              child: CustomPaint(
                size: const Size(20, 10),
                painter: ConePainter(),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget amountField() {
    return Consumer<WalletViewModel>(builder: (context, walletProvider, child) {
      return TextFieldConst(
        onChanged: (v) {
          walletProvider.selectAmountFromTextField();
        },
        width: Sizes.screenWidth / 2,
        controller: walletProvider.amountCon,
        filled: true,
        fillColor: AppColor.whiteColor,
        outLineBorderEnabled: true,
        contentPadding:
            const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
        borderSide:
            BorderSide(color: AppColor.activeButtonGreenColor.withOpacity(0.5)),
        borderSideFocus: const BorderSide(),
        prefix: const Text(
          "${Utils.rupeeSymbol}  ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        label: Text(
          "Amount to add",
          style: TextStyle(
              color: AppColor.textGreyColor, fontSize: Sizes.fontSizeThree),
        ),
        maxLength: 10,
        keyboardType: TextInputType.number,
        fontWeight: FontWeight.w500,
        sufix: InkWell(
            onTap: () {
              walletProvider.amountCon.text = "0";
              walletProvider.selectAmountFromTextField();
            },
            child: const Icon(
              Icons.cancel_outlined,
            )),
      );
    });
  }

  Widget bottomSheetContent(ProfileViewModel profileProvider) {
    return Consumer<WalletViewModel>(builder: (context, walletProvider, child) {
      return ContainerConst(
        color: CupertinoColors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -2))
        ],
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -40,
              child: ContainerConst(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, -2))
                ],
                color: AppColor.whiteColor,
                padding: const EdgeInsets.all(5),
                child: ContainerConst(
                  shape: BoxShape.circle,
                  padding: const EdgeInsets.all(6),
                  color: AppColor.scaffoldBackgroundColor,
                  child: const Icon(
                    Icons.privacy_tip_outlined,
                    color: AppColor.blackColor,
                    size: 30,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Sizes.spaceHeight20,
                const TextConst(
                  text: "Proceed to verify your details and join the contest",
                  alignment: Alignment.centerLeft,
                ),
                Sizes.spaceHeight15,
                walletProvider.walletState == WalletState.loading
                    ? Utils.loadingGreen
                    : profileProvider.userProfile!.data!.isVerify == 1
                        ? ButtonConst(
                            label:
                                "Please wait your account verification under process",
                          )
                        : ButtonConst(
                            onTap: () {
                              if (profileProvider.userProfile!.data!.isVerify ==
                                  2) {
                                walletProvider
                                    .addAmount(
                                        context,
                                        Provider.of<SharedPrefViewModel>(
                                                context,
                                                listen: false)
                                            .userToken)
                                    .then((v) {
                                  profileProvider.fetchUserProfile();
                                });
                              } else {
                                Navigator.pushNamed(context,
                                    AppRoutes.walletVerifyDetailsScreen);
                              }
                            },
                            label: profileProvider
                                        .userProfile!.data!.isVerify ==
                                    2
                                ? "add ${Utils.rupeeSymbol}${walletProvider.amount}"
                                    .toUpperCase()
                                : "verify to add ${Utils.rupeeSymbol}${walletProvider.amount}"
                                    .toUpperCase(),
                            color: AppColor.activeButtonGreenColor,
                            textColor: AppColor.whiteColor,
                          )
              ],
            ),
          ],
        ),
      );
    });
  }
}

class ConePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = Colors.blueAccent.shade100
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height);

    final bottomPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(bottomPath, whitePaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
