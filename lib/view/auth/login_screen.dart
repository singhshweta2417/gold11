import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/auth/invite_code_bottom_sheet.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gold11/view/const_widget/text_field_const.dart';
import 'package:gold11/view_model/auth_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              fit: BoxFit.fitWidth,
              opacity: 0.7,
              alignment: Alignment.topCenter,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appBarSection(context),
                ContainerConst(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  height: Sizes.screenHeight / 1.12,
                  width: Sizes.screenHeight,
                  color: AppColor.whiteColor,
                  borderRadius:const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  border: const Border(
                      top: BorderSide(width: 2, color: AppColor.primaryRedColor)),
                  child: Column(
                    children: [
                      appliedCouponWidget(),
                      Sizes.spaceHeight20,
                      mobileNoFiled(context, authProvider),
                      Sizes.spaceHeight15,
                      above18CheckBox(context, authProvider),
                      Sizes.spaceHeight25,
                      authProvider.state== AuthState.loading?
                          Utils.loadingGreen:
                      ButtonConst(
                        label: AppLocalizations.of(context)!
                            .continueText
                            .toUpperCase(),
                        color:authProvider.isAbove18 && authProvider.mobileNumberController.text.length==10 ? AppColor.activeButtonGreenColor
                            : Colors.grey.shade100,
                        textColor:
                            authProvider.isAbove18 && authProvider.mobileNumberController.text.length==10 ? AppColor.whiteColor : Colors.grey,
                        onTap: (){
                          if(authProvider.isAbove18 && authProvider.mobileNumberController.text.isNotEmpty && authProvider.mobileNumberController.text.length==10){
                            authProvider.login().then((onValue){
                              authProvider.sendOtp(context).then((onValue){
                                // Utils.showSuccessMessage(context, authProvider.message);
                              });
                            });
                          }else{
                            Utils.showErrorMessage(context, "Please Enter Mobile Number and clarify terms.");
                          }
                        },
                      ),
                      Sizes.spaceHeight15,
                      agreeTermAndCondition(context),
                      Sizes.spaceHeight15,
                      inviteCodeAndOtherLoginOption(context)
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


  Widget appBarSection(context) {
    return ContainerConst(
      height: Sizes.screenHeight / 10,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back,
                color: AppColor.whiteColor, size: 30),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextConst(
                text:
                    "${AppLocalizations.of(context)!.login}/${AppLocalizations.of(context)!.register}",
                fontSize: Sizes.fontSizeLarge,
                fontWeight: FontWeight.w800,
                textColor: AppColor.whiteColor,
              ),
              TextConst(
                text: AppLocalizations.of(context)!.letsGetYouStart,
                textColor: AppColor.whiteColor,
              )
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.help_outline,
              color: AppColor.whiteColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget mobileNoFiled(context,AuthViewModel authProvider) {
    return TextFieldConst(
      onChanged: (value){

      },
      boxShadow: [
        BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 1)
      ],
      controller: authProvider.mobileNumberController,
      contentPadding:
          const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
      borderSide: const BorderSide(),
      borderSideFocus: const BorderSide(),
      prefix: const Text(
        "+91   ",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      label:  Text(
       AppLocalizations.of(context)!.mobileNumber,
      ),
      maxLength: 10,
      keyboardType: TextInputType.number,
      fontWeight: FontWeight.w500,
      sufix: InkWell(
          onTap: () {
            authProvider.mobileNumberController.clear();
          },
          child: const Icon(
            Icons.cancel_outlined,
          )),
    );
  }

  Widget appliedCouponWidget(){
    return Consumer<AuthViewModel>(
      builder: (context, authProvider, child) {
        if(authProvider.couponApplied){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: AppColor.activeButtonGreenColor,size: 18,),
               Sizes.spaceWidth5,
                TextConst(
                    text: "Coupon applied successfully, "
                        "${authProvider.referralCodeController.text}",
                fontSize: Sizes.fontSizeTwo,
                ),
              ],
            ),
          );
        }else{
         return const SizedBox.shrink();
        }
      }
    );
  }

  Widget above18CheckBox(context,AuthViewModel authProvider) {
    return CheckboxListTile(
      activeColor: AppColor.activeButtonGreenColor,
      contentPadding: const EdgeInsets.all(0),
      title: TextConst(
        text: AppLocalizations.of(context)!.iAbove18,
        textColor: AppColor.blackColor,
        alignment: Alignment.centerLeft,
        fontSize: Sizes.fontSizeOne,
      ),
      value: authProvider.isAbove18,
      onChanged: (bool? value) {
        authProvider.setIsAbove18(value!);
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget agreeTermAndCondition(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextConst(
          text: AppLocalizations.of(context)!.agreeTAndC,
          textColor: AppColor.textGreyColor,
          fontSize: Sizes.fontSizeOne,
        ),
        TextConst(
          text: AppLocalizations.of(context)!.tAndC,
          fontWeight: FontWeight.bold,
          textColor: AppColor.textGreyColor,
          fontSize: Sizes.fontSizeOne,
        ),
      ],
    );
  }

  Widget inviteCodeAndOtherLoginOption(context) {
    return ContainerConst(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ContainerConst(
            width: Sizes.screenWidth/3,
            alignment: Alignment.center,
            height: 40,
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                  context: context,
                  builder: (_) {
                    return const InviteCodeBottomSheetScreen();
                  });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextConst(
                  text: AppLocalizations.of(context)!.haveInviteCode,
                  fontSize: Sizes.fontSizeOne,
                  textColor: AppColor.textGoldenColor,
                  fontWeight: FontWeight.w600,
                  height: 0.5,
                ),
                // Row(
                //   children: List.generate(
                //       40,
                //       (i) => const TextConst(
                //             text: ".",
                //             height: 0.5,
                //             textColor: AppColor.textGoldenColor,
                //           )),
                // )
              ],
            ),
          ),
          // const ContainerConst(
          //   margin: EdgeInsets.symmetric(horizontal: 10),
          //   height: 25,
          //   width: 1,
          //   color: AppColor.textGreyColor,
          // ),
          // ContainerConst(
          //   width: Sizes.screenWidth/3.3,
          //   alignment: Alignment.center,
          //   height: 40,
          //   onTap: () {
          //     Navigator.pushNamed(context, AppRoutes.otherLoginOptionScreen);
          //   },
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       TextConst(
          //         text: AppLocalizations.of(context)!.otherLoginOption,
          //         fontSize: Sizes.fontSizeOne,
          //         fontWeight: FontWeight.w600,
          //         height: 0.5,
          //       ),
          //       // Row(
          //       //   children: List.generate(
          //       //       35,
          //       //       (i) => const TextConst(
          //       //             text: ".",
          //       //             height: 0.5,
          //       //           )),
          //       // )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}


