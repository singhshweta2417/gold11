import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/contest_view_model.dart';
import 'package:gold11/view_model/profile_view_model.dart';

class JoinContestBottomSheetScreen extends StatelessWidget {
  const JoinContestBottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCon = Provider.of<ProfileViewModel>(context).userProfile;
    final winAndUnutilisedAmount = (double.parse(profileCon!.data!.unUtilisedWallet!) +
        double.parse(profileCon.data!.winningWallet!));
    return Consumer<ContestViewModel>(
      builder: (context, cvmCon, _) {
        return ContainerConst(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context, winAndUnutilisedAmount),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [

                    _buildRow("Entry", "${Utils.rupeeSymbol} ${cvmCon.selectedContestData == null? ""
                            :cvmCon.selectedContestData!.desprice=="1"?
                        "${cvmCon.selectedContestData!.entryFee}-> ₹${cvmCon.selectedContestData!.desprice}":"${cvmCon.selectedContestData!.entryFee}"}",isBold: true),
                    // _buildRow("Entry",
                    //     "${Utils.rupeeSymbol} ${cvmCon.selectedContestData == null?
                    //     "" :"${cvmCon.selectedContestData!.desprice}"}",isBold: true),
                    Sizes.spaceHeight15,
                    _buildRow("Usable Discount Bonus", "-${Utils.rupeeSymbol} 0"),
                    _buildDashedLine(),
                    _buildRow("To Pay", "${Utils.rupeeSymbol} ${cvmCon.selectedContestData == null? "":cvmCon.selectedContestData!.desprice}", isBold: true),
                    Sizes.spaceHeight25,
                    _buildAgreementText(),
                    Sizes.spaceHeight25,
                    _buildJoinButton(context, cvmCon),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, double winAndUnutilisedAmount) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            size: 30,
            color: AppColor.blackColor,
          ),
        ),
        const Spacer(),
        Column(
          children: [
            TextConst(
              text: "Confirmation".toUpperCase(),
              fontSize: Sizes.fontSizeThree,
              fontWeight: FontWeight.w600,
            ),
            TextConst(
              text: "Amount Unutilised + winnings = ${Utils.rupeeSymbol} ${winAndUnutilisedAmount.toStringAsFixed(2)}",
              fontSize: Sizes.fontSizeOne,
              fontWeight: FontWeight.w500,
              textColor: AppColor.textGreyColor,
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextConst(
          text: label,
          fontSize: Sizes.fontSizeTwo,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
        ),
        TextConst(
          text: value,
          fontSize: Sizes.fontSizeTwo,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
        ),
      ],
    );
  }

  Widget _buildDashedLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(int.parse((Sizes.screenWidth*0.1).toStringAsFixed(0)), (i) {
        return const Text(
          "-",
          style: TextStyle(color: Colors.grey),
        );
      }),
    );
  }

  Widget _buildAgreementText() {
    return TextConst(
      text: "I agree with the standard T&Cs",
      fontSize: Sizes.fontSizeZero,
      textColor: AppColor.textGreyColor,
      alignment: AlignmentDirectional.centerStart,
    );
  }

  Widget _buildJoinButton(BuildContext context, ContestViewModel cvmCon) {
    return ButtonConst(
      onTap: () {
        cvmCon.joinContest(context);
      },
      label: "join contest".toUpperCase(),
      color: AppColor.activeButtonGreenColor,
      textColor: AppColor.whiteColor,
      fontWeight: FontWeight.w600,
    );
  }
}