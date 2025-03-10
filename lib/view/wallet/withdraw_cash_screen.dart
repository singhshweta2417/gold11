import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/appbar_const.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view/wallet/add_bank_account_screen.dart';
import 'package:gold11/view_model/profile_view_model.dart';
import 'package:gold11/view_model/wallet_view_model.dart';

class WithdrawCashScreen extends StatefulWidget {
  const WithdrawCashScreen({super.key});

  @override
  State<WithdrawCashScreen> createState() => _WithdrawCashScreenState();
}

class _WithdrawCashScreenState extends State<WithdrawCashScreen> {
  @override
  void initState() {
    final walletCon = Provider.of<WalletViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      walletCon
          .gatAccounts(
              context,
              Provider.of<SharedPrefViewModel>(context, listen: false)
                  .userToken)
          .then((_) {
        if (walletCon.bankAccounts.data!.isNotEmpty) {
          walletCon.selectBankAcc(walletCon.bankAccounts.data!.first.id ?? 0);
        } else {
          if (kDebugMode) {
            print("no any accounts are there");
          }
          Future.delayed(const Duration(milliseconds: 500), () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (_) {
                  return const AddBankAccountScreen(
                    message: "Please add bank account to continue withdraw",
                  );
                });
          });
        }
      });
      walletCon.withdrawAmountCon.clear();
      walletCon.resetWithdrawData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletViewModel>(builder: (context, walletCon, child) {
      if (walletCon.walletState == WalletState.loading) {
        return const Scaffold(body: Utils.loadingRed);
      }
      return Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: AppBarConst(
            title: "Withdraw",
            actions: [
              if (walletCon.bankAccounts.data!.isNotEmpty)
                ButtonConst(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (_) {
                          return const AddBankAccountScreen();
                        });
                  },
                  icon: Icons.add,
                  label: "Add Bank",
                  width: Sizes.screenWidth / 3.5,
                  border: Border.all(color: AppColor.scaffoldBackgroundColor),
                  color: AppColor.whiteColor.withOpacity(0.1),
                  textColor: AppColor.whiteColor,
                ),
              Sizes.spaceWidth10
            ],
          ),
          body: Column(
            children: [
              addAmountSection(),
              Sizes.spaceHeight20,
              bankAccountsListing(),
            ],
          ),
          bottomSheet: ContainerConst(
            color: AppColor.whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: walletCon.walletState == WalletState.loading
                ? Utils.loadingGreen
                : Provider.of<ProfileViewModel>(context)
                            .userProfile!
                            .data!
                            .isVerify ==
                        1
                    ? ButtonConst(
                        label:
                            "Please wait your account verification under process",
                      )
                    : Provider.of<ProfileViewModel>(context)
                                .userProfile!
                                .data!
                                .isVerify ==
                            0
                        ? ButtonConst(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.walletVerifyDetailsScreen);
                            },
                            color: AppColor.activeButtonGreenColor,
                            label: "Verify document to withdraw amount",
                            textColor: AppColor.whiteColor,
                          )
                        : walletCon.amountWithdrawStatus == "3"
                            ? ButtonConst(
                                onTap: () {
                                  if (walletCon.bankAccounts.data!.isEmpty ||
                                      walletCon.selectedBankAccId == 0) {
                                    Utils.showErrorMessage(context,
                                        "Please add account to continue");
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (_) {
                                          return const AddBankAccountScreen(
                                            message:
                                                "Please add bank account to continue withdraw",
                                          );
                                        });
                                  } else {
                                    walletCon.withdrawAmount(
                                        context,
                                        Provider.of<SharedPrefViewModel>(
                                                context,
                                                listen: false)
                                            .userToken);
                                  }
                                },
                                label: "withdraw now".toUpperCase(),
                                color: AppColor.activeButtonGreenColor,
                                textColor: AppColor.whiteColor,
                              )
                            : ButtonConst(
                                label: "withdraw now".toUpperCase(),
                                textColor: AppColor.textGreyColor,
                              ),
          ));
    });
  }

  Widget bankAccountsListing() {
    return Consumer<WalletViewModel>(builder: (context, walletCon, child) {
      if (walletCon.walletState == WalletState.loading) {
        return Utils.loadingRed;
      }
      if (walletCon.bankAccounts.data!.isEmpty) {
        return ButtonConst(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (_) {
                  return const AddBankAccountScreen();
                });
          },
          label: "You don't have added bank account, Add Bank",
          border: Border.all(color: AppColor.scaffoldBackgroundColor),
          color: AppColor.primaryRedColor,
          textColor: AppColor.whiteColor,
        );
      }
      return Column(
        children: [
          const TextConst(
            text: "Send winnings to: ",
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 15),
            fontWeight: FontWeight.w600,
          ),
          Sizes.spaceHeight10,
          ListView.builder(
              shrinkWrap: true,
              itemCount: walletCon.bankAccounts.data!.length,
              itemBuilder: (_, int i) {
                final bankData = walletCon.bankAccounts.data![i];
                return ListTile(
                  onTap: () {
                    walletCon.selectBankAcc(bankData.id ?? 0);
                  },
                  leading: ContainerConst(
                    border: Border.all(
                        color: AppColor.scaffoldBackgroundColor, width: 2),
                    borderRadius: BorderRadius.circular(5),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.account_balance_outlined,
                      size: 35,
                    ),
                  ),
                  title: TextConst(
                    text: bankData.bankName ?? "",
                    alignment: Alignment.centerLeft,
                  ),
                  subtitle: TextConst(
                    text: bankData.accountNo ?? "",
                    alignment: Alignment.centerLeft,
                    fontSize: Sizes.fontSizeOne,
                    textColor: AppColor.textGreyColor,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      walletCon.selectBankAcc(bankData.id ?? 0);
                    },
                    icon: bankData.id == walletCon.selectedBankAccId
                        ? const Icon(
                            Icons.check_circle,
                            color: AppColor.activeButtonGreenColor,
                            size: 30,
                          )
                        : const Icon(
                            Icons.circle_outlined,
                            size: 30,
                          ),
                  ),
                );
              })
        ],
      );
    });
  }

  Widget addAmountSection() {
    return Consumer<ProfileViewModel>(
        builder: (context, profileProvider, child) {
      return ContainerConst(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              // const Color(0xffe3f9e7),
              const Color(0xffe3f9e7).withOpacity(0.7),
              const Color(0xffe3f9e7).withOpacity(0.1)
            ]),
        color: AppColor.whiteColor,
        border: Border(
            bottom: BorderSide(
                color: AppColor.activeButtonGreenColor.withOpacity(0.3),
                width: 2)),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: AppColor.scaffoldBackgroundColor,
                  child: const Icon(Icons.emoji_events)),
              title: const TextConst(
                text: "Your Winnings",
                alignment: Alignment.centerLeft,
              ),
              trailing: TextConst(
                text:
                    "${Utils.rupeeSymbol}${profileProvider.userProfile!.data!.winningWallet}",
                width: Sizes.screenWidth / 3,
                alignment: Alignment.centerRight,
              ),
            ),
            amountField(),
            Sizes.spaceHeight5,
            Consumer<WalletViewModel>(builder: (context, walletCon, child) {
              if (walletCon.amountWithdrawStatus == "1") {
                return TextConst(
                  text:
                      "Withdrawal Amount cannot be greater than winning balance",
                  fontSize: Sizes.fontSizeZero,
                  textColor: AppColor.primaryRedColor,
                );
              } else {
                return TextConst(
                  text: "Minimum ${Utils.rupeeSymbol}60",
                  fontSize: Sizes.fontSizeZero,
                  textColor: AppColor.textGreyColor,
                );
              }
            }),
            Sizes.spaceHeight20
          ],
        ),
      );
    });
  }

  Widget amountField() {
    return Consumer<WalletViewModel>(builder: (context, walletCon, child) {
      return IntrinsicWidth(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: TextField(
          keyboardType: TextInputType.number,
          controller: walletCon.withdrawAmountCon,
          onChanged: (v) {
            walletCon.checkEnteredAmountValidation(context, v);
          },
          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
          maxLength: 12,
          decoration: const InputDecoration(
              counterText: "",
              prefixIconConstraints: BoxConstraints(
                maxWidth: 32,
              ),
              border: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.activeButtonGreenColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.activeButtonGreenColor)),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.activeButtonGreenColor)),
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              prefixIcon: Icon(
                Icons.currency_rupee,
                size: 35,
                color: AppColor.blackColor,
              )),
        ),
      ));
    });
  }
}
