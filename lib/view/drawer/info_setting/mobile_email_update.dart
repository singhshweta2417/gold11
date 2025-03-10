import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/appbar_const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view_model/profile_view_model.dart';

import '../../../res/color_const.dart';
import '../../const_widget/text_const.dart';
import '../../const_widget/text_field_const.dart';


class ChangeMobileNoOrEmail extends StatelessWidget {
 final Map<String, dynamic> args;
  const ChangeMobileNoOrEmail({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileProvider, child) {
        return Scaffold(
          appBar: AppBarConst(title:args["title"].toUpperCase()),
          body: ContainerConst(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  TextConst(text: "${args["title"]} ${AppLocalizations.of(context)!.youWouldLikeToUse}",fontSize: Sizes.fontSizeOne,alignment: FractionalOffset.centerLeft,),
                  Sizes.spaceHeight15,
                  myInfoTextField(profileProvider.updateContentCon, args["label"]),
                  Sizes.spaceHeight20,
                  ButtonConst(
                    onTap: (){
                      if(profileProvider.updateContentCon.text.isNotEmpty){
                        profileProvider.updateProfileContactDetail(context, {"updateData":profileProvider.updateContentCon.text.trim(), "updateType":args["updateType"]});
                      }else{
                        Utils.showErrorMessage(context, "Please enter ${args["updateType"]} to continue");
                        if (kDebugMode) {
                          print("please enter email to continue");
                        }
                      }
                    },
                    label: AppLocalizations.of(context)!.getOtp.toUpperCase(),color: AppColor.activeButtonGreenColor,textColor: AppColor.whiteColor,)
                ],
              )),
        );
      }
    );
  }

  Widget myInfoTextField(TextEditingController controller, String labelText,
      {Widget? suffix}) {
    return TextFieldConst(
      fillColor: AppColor.scaffoldBackgroundColor,
      filled: true,
      controller: controller,
      fieldRadius: const BorderRadius.only(
          topRight: Radius.circular(5), topLeft: Radius.circular(5)),
      contentPadding:
      const EdgeInsets.only(top: 8, bottom: 3, left: 10, right: 10),
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
