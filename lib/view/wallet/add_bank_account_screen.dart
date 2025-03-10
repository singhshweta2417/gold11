import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/wallet_view_model.dart';

import '../const_widget/text_field_const.dart';

class AddBankAccountScreen extends StatefulWidget {
  final  String? message;
  const AddBankAccountScreen({super.key,  this.message});

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  final bankNameCon = TextEditingController();

  final accNoCon = TextEditingController();

  final ifscCon = TextEditingController();

  final accHolderNameCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletViewModel>(builder: (context, walletCon, child) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: ContainerConst(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(20),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.account_balance_outlined),
                  contentPadding: const EdgeInsets.all(0),
                  title: TextConst(
                    text: "Add Bank Account",
                    fontSize: Sizes.fontSizeThree,
                    alignment: Alignment.centerLeft,
                  ),
                  trailing: InkWell(
                      onTap: () {
                          Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.clear_sharp,
                        size: 30,
                      )),
                ),
                Divider(
                  color: AppColor.scaffoldBackgroundColor,
                ),
                 ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: const Icon(CupertinoIcons.info),
                  title: TextConst(
                    text:widget.message??"Please enter your correct bank details.",
                    alignment: Alignment.centerLeft,
                  ),
                ),
                textField(bankNameCon, "Bank Name"),
                Sizes.spaceHeight15,
                textField(accNoCon, "Account Number"),
                Sizes.spaceHeight15,
                textField(ifscCon, "IFSC Code"),
                Sizes.spaceHeight15,
                textField(accHolderNameCon, "Account Holder Name"),
                Sizes.spaceHeight25,
                ButtonConst(
                  onTap: () {
                    if (bankNameCon.text.isNotEmpty &&
                        accNoCon.text.isNotEmpty &&
                        ifscCon.text.isNotEmpty &&
                        accHolderNameCon.text.isNotEmpty) {
                      walletCon.addAccount(
                          context,
                          Provider.of<SharedPrefViewModel>(context, listen: false).userToken,
                          bankNameCon.text,
                          accNoCon.text,
                          ifscCon.text,
                          accHolderNameCon.text);
                    }
                  },
                  label: "Save",
                  color: bankNameCon.text.isNotEmpty &&
                          accNoCon.text.isNotEmpty &&
                          ifscCon.text.isNotEmpty &&
                          accHolderNameCon.text.isNotEmpty
                      ? AppColor.activeButtonGreenColor
                      : Colors.grey.shade100,
                  textColor: bankNameCon.text.isNotEmpty &&
                          accNoCon.text.isNotEmpty &&
                          ifscCon.text.isNotEmpty &&
                          accHolderNameCon.text.isNotEmpty
                      ? AppColor.whiteColor
                      : AppColor.textGreyColor,
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget textField(TextEditingController controller, String labelText,
      {Widget? suffix, bool isEnabled = true}) {
    return TextFieldConst(
      enabled: isEnabled,
      fillColor: AppColor.scaffoldBackgroundColor,
      filled: true,
      controller: controller,
      fieldRadius: const BorderRadius.only(
          topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      contentPadding:
          const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
      borderSide: const BorderSide(),
      borderSideFocus: const BorderSide(),
      label: TextConst(
        text: labelText,
        alignment: Alignment.centerLeft,
        textColor: AppColor.textGreyColor,
      ),
      fontWeight: FontWeight.w500,
      sufixIcon: suffix,
    );
  }
}
