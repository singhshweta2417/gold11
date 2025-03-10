import 'package:flutter/material.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';

class DataSuccessUpdatedBottomSheet extends StatelessWidget {
  final Map<String, dynamic> args;
  const DataSuccessUpdatedBottomSheet({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return ContainerConst(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           TextConst(text: "${args["updateType"]} Updated",fontSize: Sizes.fontSizeThree,fontWeight: FontWeight.w600,),
          Sizes.spaceHeight15,
          ContainerConst(shape: BoxShape.circle,border: Border.all(color: AppColor.activeButtonGreenColor),child:Icon(Icons.check, color: AppColor.activeButtonGreenColor,size: Sizes.screenWidth/8,) ,),
          Sizes.spaceHeight15,
           TextConst(text: "Your ${args["updateType"].toLowerCase()} has been successfully updated to",),
           TextConst(text: args["updateData"], fontWeight: FontWeight.w600,),
          Sizes.spaceHeight15,
          ButtonConst(label: "Close".toUpperCase(),color: AppColor.activeButtonGreenColor,textColor: AppColor.whiteColor,fontWeight: FontWeight.w600,onTap: (){
            Navigator.pop(context);
          },),
        ],
      ),
    );
  }
}
