import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/view_model/auth_view_model.dart';

import '../../generated/assets.dart';
import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../../utils/utils.dart';
import '../const_widget/container_const.dart';
import '../const_widget/text_const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key});

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  @override
  void initState() {
    Provider.of<AuthViewModel>(context, listen: false).otpController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authProvider, child) {
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
                  // borderRadius: BorderRadius.circular(25),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)
                  ),
                  border: const Border(
                      top: BorderSide(width: 2, color: AppColor.primaryRedColor)
                  ),
                  child: Column(
                    children: [
                      otpField(),
                      Sizes.spaceHeight25,
                      authProvider.state==AuthState.loading?
                          Utils.loadingGreen:
                      Sizes.spaceHeight25,
                      noReceivedSendAgain(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget appBarSection(context){
    return Consumer<AuthViewModel>(
        builder: (context, authProvider, child) {
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
                  TextConst(text:AppLocalizations.of(context)!.almostThere, fontSize: Sizes.fontSizeLarge,fontWeight: FontWeight.w800,textColor: AppColor.whiteColor,),
                  TextConst(text:"${AppLocalizations.of(context)!.plsEnterOTP}- ${authProvider.mobileNumberController.text.trim()}", textColor: AppColor.whiteColor,)
                ],
              ),
              IconButton(onPressed: (){},icon: const Icon(Icons.help_outline, color: AppColor.whiteColor,size: 30,),),
            ],
          ),
        );
      }
    );
  }

  Widget otpField(){
    return  Consumer<AuthViewModel>(
      builder: (context, authProvider, child) {
        return ContainerConst(
          width: Sizes.screenWidth/1.2,
          height: 50,
          child: Pinput(
            focusedPinTheme: PinTheme(decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade500), color: Colors.grey.shade100,borderRadius: BorderRadius.circular(7)),constraints: const BoxConstraints(maxWidth: 40, maxHeight: 40), margin: const EdgeInsets.only(left: 10)),
            defaultPinTheme: PinTheme(decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), color: Colors.grey.shade100,borderRadius: BorderRadius.circular(7)),constraints: const BoxConstraints(maxWidth: 40, maxHeight: 40), margin: const EdgeInsets.only(left: 10)),
            autofocus: true,
            controller: authProvider.otpController,
            length: 6,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onChanged: (v) {
              if (v.length == 6) {
                authProvider.verifyOtp(context, Provider.of<SharedPrefViewModel>(context, listen: false).userToken);
              }
            },
          ),
        );
      }
    );
  }

  Widget noReceivedSendAgain(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextConst(text: "${AppLocalizations.of(context)!.dontReceive}? ", textColor: AppColor.textGreyColor,fontSize: Sizes.fontSizeOne,),
        TextConst(text: AppLocalizations.of(context)!.resendOTP, fontWeight: FontWeight.bold,textColor: AppColor.blackColor,fontSize: Sizes.fontSizeOne,),
      ],
    );
  }
}
