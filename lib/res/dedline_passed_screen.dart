
import 'package:flutter/material.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';

class DedlinePassedScreen extends StatefulWidget {
  const DedlinePassedScreen({super.key});

  @override
  State<DedlinePassedScreen> createState() => _DedlinePassedScreenState();
}

class _DedlinePassedScreenState extends State<DedlinePassedScreen> {
  @override
  Widget build(BuildContext context) {
    return  ContainerConst(
      width: Sizes.screenWidth,
      padding:  const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextConst(
            text: 'Deadline Passed!',
            alignment: Alignment.center,
            textColor: AppColor.blackColor,
            fontSize: Sizes.fontSizeThree,
            fontWeight: FontWeight.w800,
          ),
          Sizes.spaceHeight20,
          ContainerConst(height: 120,
            width: 120,
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
            child: Center(
              child: ContainerConst(
                height: 100,
                width: 100,
                shape: BoxShape.circle,
                color: AppColor.whiteColor,
                child: Center(child: Image.asset(Assets.assetsWarning,fit: BoxFit.cover,)),

              ),
            ),
          ),
          Sizes.spaceHeight20,
          TextConst(
            text:"You can't join contests for this match anymore.",
            alignment: Alignment.center,
            textColor: AppColor.blackColor,
            fontSize: Sizes.fontSizeTwo,
            fontWeight: FontWeight.w500,
          ),
          TextConst(
            text:"Select another match to play.",
            alignment: Alignment.center,
            textColor: AppColor.blackColor,
            fontSize: Sizes.fontSizeTwo,
            fontWeight: FontWeight.w500,
          ),
          Sizes.spaceHeight20,
          ButtonConst(
            onTap: (){},
            label: 'view upcoming matches'.toUpperCase(),
            color: AppColor.activeButtonGreenColor,
            textColor: AppColor.whiteColor,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          )
        ],
      ),
    );
  }
}
