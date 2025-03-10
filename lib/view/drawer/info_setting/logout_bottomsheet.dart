import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';

import '../../../view_model/auth_view_model.dart';

class LogoutBottomSheet extends StatelessWidget {
const LogoutBottomSheet ({super.key});
  @override
  Widget build(BuildContext context) {
    return ContainerConst(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      color: Colors.white,
    borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
    child:Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextConst(text: "Are you sure?", fontSize: Sizes.fontSizeThree,fontWeight: FontWeight.w600,),
        Sizes.spaceHeight15,
        const TextConst(text: "You'll be logged out of all devices and won't receive any match or contest-related updates.",alignment: Alignment.center,textAlign: TextAlign.center,textColor: AppColor.textGreyColor,),
        Sizes.spaceHeight15,
        ButtonConst(
          onTap: (){
            Provider.of<AuthViewModel>(context, listen: false).logout(context);
          },
          label: "Logout".toUpperCase(),textColor: AppColor.whiteColor,fontWeight: FontWeight.w600,color: AppColor.activeButtonGreenColor,),
        Sizes.spaceHeight15,
        ButtonConst(
          onTap: (){
            Navigator.pop(context);
          },
          label: "Cancel".toUpperCase(),fontWeight: FontWeight.w600,border: Border.all(color: AppColor.textGreyColor),),
      ],
    ),
    );
  }
}
