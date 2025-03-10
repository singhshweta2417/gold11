import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../../utils/route/app_routes.dart';
import '../const_widget/button_const.dart';
import '../const_widget/container_const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../const_widget/text_const.dart';
import '../const_widget/text_field_const.dart';


class OtherLoginScreen extends StatefulWidget {
  const OtherLoginScreen({super.key});

  @override
  State<OtherLoginScreen> createState() => _OtherLoginScreenState();
}

class _OtherLoginScreenState extends State<OtherLoginScreen> {
  final emailCon=TextEditingController();
  bool _isUserAbove18 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ContainerConst(
        height: Sizes.screenHeight,
        width: Sizes.screenWidth,
        color: AppColor.primaryRedColor,
        alignment: Alignment.bottomCenter,
        image: const DecorationImage(
          image: AssetImage(Assets.assetsGradientLineBackground),
          filterQuality: FilterQuality.low,
          fit: BoxFit.fitWidth,
          opacity: 0.7,
          alignment: Alignment.topCenter,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appBarSection(context),
            ContainerConst(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              height: Sizes.screenHeight/1.12,
              width: Sizes.screenHeight,
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(25),
              border: const Border(
                  top: BorderSide(width: 2, color: AppColor.primaryRedColor)
              ),
              child: Column(
                children: [
                  emailFiled(),
                  Sizes.spaceHeight15,
                  above18CheckBox(context),
                  Sizes.spaceHeight25,
                  ButtonConst(label:AppLocalizations.of(context)!.continueText.toUpperCase(),color:_isUserAbove18?AppColor.activeButtonGreenColor:Colors.grey.shade100,textColor:_isUserAbove18?AppColor.whiteColor:Colors.grey,onTap: (){
                    if(_isUserAbove18 && emailCon.text.isNotEmpty){
                      Navigator.pushNamed(context, AppRoutes.verifyOTPScreen);
                    }else{
                      if (kDebugMode) {
                        print("please enter mobile no and check the check box");
                      }
                    }
                  },),
                  Sizes.spaceHeight15,
                  agreeTermAndCondition(context),
                  Sizes.spaceHeight20,
                  orDesign(),
                  Sizes.spaceHeight25,
                  socialLoginOption(),
                  Sizes.spaceHeight25,
                  Sizes.spaceHeight10,
                  inviteCodeAndOtherLoginOption(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBarSection(context){
    return ContainerConst(
      height: Sizes.screenHeight/10,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: (){
            Navigator.of(context).pop();
          },icon: const Icon(Icons.arrow_back, color: AppColor.whiteColor,size:30),),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextConst(text:AppLocalizations.of(context)!.welcomeBack, fontSize: Sizes.fontSizeLarge,fontWeight: FontWeight.w800,textColor: AppColor.whiteColor,),
              TextConst(text:AppLocalizations.of(context)!.readyToPlayAndWin, textColor: AppColor.whiteColor,)
            ],
          ),
          IconButton(onPressed: (){},icon: const Icon(Icons.help_outline, color: AppColor.whiteColor,size: 30,),),
        ],
      ),
    );
  }

  Widget emailFiled(){
    return TextFieldConst(
      boxShadow: [
        BoxShadow(color: Colors.grey.shade500, offset: const Offset(0, 2),blurRadius: 2, spreadRadius: 1)
      ],
      controller: emailCon,
      contentPadding: const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
      borderSide: const BorderSide(),
      borderSideFocus: const BorderSide(),
      label:  Text(AppLocalizations.of(context)!.emailAddress),
      maxLength: 10,
      keyboardType: TextInputType.emailAddress,
      fontWeight: FontWeight.w500,
      sufix: InkWell(
          onTap: (){
            emailCon.clear();
          },
          child: const Icon(Icons.cancel_outlined,)),
    );
  }

  Widget above18CheckBox(context){
    return CheckboxListTile(
      activeColor:AppColor.activeButtonGreenColor,
      contentPadding: const EdgeInsets.all(0),
      title: TextConst(text: AppLocalizations.of(context)!.iAbove18,textColor: AppColor.blackColor,alignment: Alignment.centerLeft,fontSize: Sizes.fontSizeOne,),
      value: _isUserAbove18,
      onChanged: (bool? value) {
        setState(() {
          _isUserAbove18 = value!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget agreeTermAndCondition(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextConst(text: AppLocalizations.of(context)!.agreeTAndC, textColor: AppColor.textGreyColor,fontSize: Sizes.fontSizeOne,),
        TextConst(text: AppLocalizations.of(context)!.tAndC, fontWeight: FontWeight.bold,textColor: AppColor.textGreyColor,fontSize: Sizes.fontSizeOne,),
      ],
    );
  }

  Widget inviteCodeAndOtherLoginOption(){
    return ContainerConst(
      onTap: (){
        Navigator.of(context).pop();
      },
      width: Sizes.screenWidth/3.4,
      child:Column(
        children: [
          TextConst(text: AppLocalizations.of(context)!.useMobileNo,fontSize: Sizes.fontSizeOne,fontWeight: FontWeight.w600,height: 0.5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(30, (i)=>const TextConst(text: ".",height: 0.5,)),)
        ],
      ),
    );
  }

  Widget orDesign(){
    return ContainerConst(
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children:List.generate(10, (i)=>TextConst(text: "-", fontSize: Sizes.fontSizeZero,textColor:Colors.grey.shade300,)),),
          ContainerConst(
            width: 30,height: 30,
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
              child: TextConst(text: "OR",fontSize: Sizes.fontSizeOne,fontWeight: FontWeight.bold,)),
          Row(children:List.generate(10, (i)=>TextConst(text: "-", fontSize: Sizes.fontSizeZero,textColor:Colors.grey.shade300,)),)
        ],
      ),
    );
  }

  Widget socialLoginOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonConst(
          inCol: false,
          icon: Icons.facebook,
          iconColor: Colors.blue,
          iconSize: 30,
          label: AppLocalizations.of(context)!.facebook.toUpperCase(),width: Sizes.screenWidth/2.5,border: Border.all(width: 1, color: Colors.grey.shade300),),
        ButtonConst(
          inCol: false,
          icon: Icons.web_asset_outlined,
          iconColor: Colors.blue,
          iconSize: 30,
          label: AppLocalizations.of(context)!.google.toUpperCase(),width: Sizes.screenWidth/2.5,border: Border.all(width: 1, color: Colors.grey.shade300),),
      ],
    );
  }

}
