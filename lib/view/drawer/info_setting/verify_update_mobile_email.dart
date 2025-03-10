import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/view/const_widget/appbar_const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/profile_view_model.dart';
import 'package:gold11/view_model/services/resend_otp_timer.dart';

import '../../../res/sizes_const.dart';



class VerifyOtpForUpdateMobileOrEmail extends StatefulWidget {
  final Map<String, dynamic> args;
  const VerifyOtpForUpdateMobileOrEmail({super.key, required this.args});

  @override
  State<VerifyOtpForUpdateMobileOrEmail> createState() => _VerifyOtpForUpdateMobileOrEmailState();
}

class _VerifyOtpForUpdateMobileOrEmailState extends State<VerifyOtpForUpdateMobileOrEmail> {

  @override
  void initState() {
    super.initState();
    Provider.of<ResendOtpTimerCountdownController>(context, listen: false).startTimer();
  }

  @override
  void dispose() {
    Provider.of<ResendOtpTimerCountdownController>(context, listen: false).disposeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      appBar: AppBarConst(title: AppLocalizations.of(context)!.enterOtp,),
      body: ContainerConst(
        height: Sizes.screenHeight/3.5,
        color: AppColor.whiteColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextConst(text: "${AppLocalizations.of(context)!.enterOtpSent} ${widget.args["updateData"]}", alignment: FractionalOffset.centerLeft,),
            Sizes.spaceHeight15,
            otpField(),
            Sizes.spaceHeight20,
            noReceivedSendAgain(context),
            Sizes.spaceHeight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextConst(text: "${AppLocalizations.of(context)!.facingIssue} ", textColor: AppColor.textGreyColor),
                TextConst(text: AppLocalizations.of(context)!.contactUs,textColor: AppColor.blackColor,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget noReceivedSendAgain(context){
    final timerController = Provider.of<ResendOtpTimerCountdownController>(context);
    if(timerController.remainingTime==0) {
      return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         TextConst(text: "${AppLocalizations.of(context)!.dontReceive}? ", textColor: AppColor.textGreyColor),
        TextConst(text: AppLocalizations.of(context)!.resendOTP,textColor: AppColor.blackColor, onTap: () {
          timerController.resetTimer();
        },),
      ],
    );
    } else {
      return RichText(
        text: TextSpan(
          text: "${AppLocalizations.of(context)!.dontReceive}? ",
          style: GoogleFonts.poppins(color: AppColor.textGreyColor, fontSize: Sizes.fontSizeTwo), // Default text color
          children: [
            TextSpan(
              text: "${AppLocalizations.of(context)!.reqForANewOne} ",
              style: GoogleFonts.poppins(color: AppColor.textGreyColor, fontSize: Sizes.fontSizeTwo),
            ),
            TextSpan(
              text: "${timerController.remainingTime} ",
              style: GoogleFonts.poppins(color: AppColor.primaryRedColor, fontSize: Sizes.fontSizeTwo),
            ),
            TextSpan(
              text: "Seconds",
              style: GoogleFonts.poppins(color: AppColor.primaryRedColor,fontSize: Sizes.fontSizeTwo),
            ),
          ],
        ),
      );
    }
  }

  Widget otpField(){
    return  Consumer<ProfileViewModel>(
      builder: (context, profileProvider, child) {
        return ContainerConst(
          height: 50,
          width: Sizes.screenWidth,
          child: Pinput(
            focusedPinTheme: PinTheme(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade500, width: 1.5)), color: AppColor.scaffoldBackgroundColor,borderRadius: BorderRadius.circular(0)),constraints: const BoxConstraints(maxWidth: 50, maxHeight: 50), margin: const EdgeInsets.only(left: 10),),
            defaultPinTheme: PinTheme(decoration: BoxDecoration(border:Border(bottom: BorderSide(color: Colors.grey.shade500, width: 1.5)), color:  AppColor.scaffoldBackgroundColor,borderRadius: BorderRadius.circular(0)),constraints: const BoxConstraints(maxWidth: 50, maxHeight: 50), margin: const EdgeInsets.only(left: 10)),
            autofocus: true,
            controller: profileProvider.updateDataOtpCon,
            length: 6,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onChanged: (v) {
              if (v.length == 6) {
                profileProvider.verifyOtp(context, {"navigateForm": "profileUpdate", "updateType":widget.args["updateType"], "updateData":widget.args["updateData"]});
                // Navigator.pushReplacementNamed(context, AppRoutes.myProfileInfo,arguments: {"navigateForm": "profileUpdate", "updateType":widget.args["updateType"], "updateData":widget.args["updateData"]});
              }
            },
          ),
        );
      }
    );
  }
}
