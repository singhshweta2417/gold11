import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gold11/view_model/auth_view_model.dart';
import '../const_widget/button_const.dart';
import '../const_widget/text_field_const.dart';

class InviteCodeBottomSheetScreen extends StatefulWidget {
  const InviteCodeBottomSheetScreen({super.key});

  @override
  State<InviteCodeBottomSheetScreen> createState() =>
      _InviteCodeBottomSheetScreenState();
}

class _InviteCodeBottomSheetScreenState
    extends State<InviteCodeBottomSheetScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, authProvider, child) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: ContainerConst(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(15),
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 15),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.clear,
                          size: 30,
                        )),
                    const Spacer(),
                    TextConst(
                      text: AppLocalizations.of(context)!.enterInviteCode,
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.fontSizeThree,
                      alignment: Alignment.center,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    Sizes.spaceWidth25
                  ],
                ),
                Sizes.spaceHeight10,
                ContainerConst(
                  height: 1.5,
                  width: Sizes.screenWidth / 1,
                  gradient: const LinearGradient(colors: [
                    AppColor.whiteColor,
                    AppColor.textGoldenColor,
                    AppColor.whiteColor
                  ]),
                  color: AppColor.whiteColor,
                ),
                Sizes.spaceHeight20,
                inviteCodeField(),
                Sizes.spaceHeight10,
                TextConst(
                  text: AppLocalizations.of(context)!
                      .notApplicableForNoAlreadyRegistered,
                  fontSize: Sizes.fontSizeOne,
                  alignment: Alignment.centerLeft,
                ),
                Sizes.spaceHeight20,
                ButtonConst(
                  onTap: () {
                    authProvider.checkReferralCoupon(context);
                  },
                  label: AppLocalizations.of(context)!.apply.toUpperCase(),
                  color: authProvider.referralCodeController.text.length >= 4
                      ? AppColor.activeButtonGreenColor
                      : Colors.grey.shade100,
                  textColor: authProvider.referralCodeController.text.isNotEmpty
                      ? AppColor.whiteColor
                      : Colors.grey,
                ),
                Sizes.spaceHeight25
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget inviteCodeField() {
    return Consumer<AuthViewModel>(builder: (context, authProvider, child) {
      return TextFieldConst(
        textCapitalization: TextCapitalization.characters,
        controller: authProvider.referralCodeController,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(0, 2),
              blurRadius: 2,
              spreadRadius: 1)
        ],
        contentPadding:
            const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        borderSide: const BorderSide(),
        borderSideFocus: const BorderSide(),
        label: TextConst(
          text: AppLocalizations.of(context)!.inviteCode,
          alignment: Alignment.centerLeft,
          textColor: AppColor.textGreyColor,
        ),
        maxLength: 10,
        keyboardType: TextInputType.text,
        fontWeight: FontWeight.w500,
        sufix: InkWell(
            onTap: () {
              authProvider.referralCodeController.clear();
            },
            child: const Icon(
              Icons.cancel_outlined,
            )),
      );
    });
  }

}
