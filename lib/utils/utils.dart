import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/view/const_widget/container_const.dart';

import '../res/color_const.dart';
import '../res/sizes_const.dart';
import '../view/const_widget/text_const.dart';

class Utils {
  static const String rupeeSymbol = "₹";
  static Widget walletInfoNote() {
    return TextConst(
      text:
          "Note: Any details, once submitted, can't be unlinked and used on any other account",
      textColor: AppColor.blackColor,
      fontSize: Sizes.fontSizeOne,
    );
  }

  static void showSuccessMessage(BuildContext context, String message) {
    _showFlushBar(context, message, Colors.green, Icons.check_circle);
  }

  static void showErrorMessage(BuildContext context, String message) {
    _showFlushBar(context, message, Colors.orange, Icons.error);
  }

  static void showMessage(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.blue,
    IconData icon = Icons.info,
  }) {
    _showFlushBar(context, message, backgroundColor, icon);
  }

  static void _showFlushBar(
    BuildContext context,
    String message,
    Color backgroundColor,
    IconData icon,
  ) {
    Flushbar(
      message: message,
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      mainButton: IconButton(
        icon: const Icon(
          Icons.close,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  static const loadingGreen = Center(
      child: CircularProgressIndicator(
    color: AppColor.activeButtonGreenColor,
  ));
  static const loadingWhite = Center(
      child: CircularProgressIndicator(
    color: AppColor.whiteColor,
  ));
  static const loadingRed = Center(
      child: CircularProgressIndicator(
    color: AppColor.primaryRedColor,
  ));

  static const noDataAvailableText =
      Center(child: TextConst(text: "No Data available"));

  static Widget noDataAvailableVector(
      {String messageLabel = "Oops! No Data Available", String? image}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ContainerConst(
            width: Sizes.screenWidth / 2.2,
            height: Sizes.screenWidth / 2.5,
            alignment: Alignment.bottomCenter,
            // shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage(image ?? Assets.assetsCricketVector),
                fit: BoxFit.fill,
                filterQuality: FilterQuality.low,
                opacity: 0.6),
          ),
          Text(
            messageLabel,
            style: TextStyle(
                color: AppColor.textGreyColor,
                fontSize: Sizes.fontSizeTwo,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  static Widget noDataAvailableContest({
    String messageLabel = "Join Contests for any of the upcoming matches ",
    String? image,
    String titleLabel = "You haven't join any contests for this match",
    String buttonLabel = "view upcoming matches",
    VoidCallback? onTap,
    double? buttonWidth,

  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            titleLabel,
            style: TextStyle(
                color: AppColor.textGreyColor,
                fontSize: Sizes.fontSizeTwo,
                fontWeight: FontWeight.w600),
          ),
          ContainerConst(
            // width: Sizes.screenWidth/0.1,
            height: Sizes.screenWidth / 1.4,
            alignment: Alignment.bottomCenter,
            image: DecorationImage(
                image: AssetImage(image ?? Assets.assetsNoContesttojoin),
                fit: BoxFit.fill,
                filterQuality: FilterQuality.low,
                opacity: 0.6),
          ),
          Text(
            messageLabel,
            textAlign: TextAlign.center,
            style: TextStyle(

                color: AppColor.textGreyColor,
                fontSize: Sizes.fontSizeTwo,

                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: Sizes.screenHeight * 0.04,
          ),
          ButtonConst(
            onTap: onTap,
            label: buttonLabel.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
            color: AppColor.activeButtonGreenColor,
            textColor: AppColor.whiteColor,
            width: buttonWidth?? Sizes.screenWidth * 0.8,
          )
        ],
      ),
    );
  }

  static Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static showExitConfirmation(BuildContext context) async {
    return await showModalBottomSheet(
          elevation: 5,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              //   side: BorderSide(width: 2, color: AppColor.primaryRedColor),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          context: context,
          builder: (context) {
            return Container(
              height: Sizes.screenHeight * 0.4,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Column(
                children: [
                  SizedBox(height: Sizes.screenHeight / 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: Sizes.screenWidth * 0.09),
                        child: Container(
                          height: Sizes.screenHeight * 0.06,
                          width: Sizes.screenWidth * 0.08,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Assets.assetsAppLogo))),
                        ),
                      ),
                      TextConst(
                        textColor: Colors.black,
                        fontSize: Sizes.screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        text: 'EXIT APP',
                      ),
                      Container(
                        width: Sizes.screenWidth * 0.09,
                      ),
                    ],
                  ),
                  SizedBox(height: Sizes.screenHeight / 30),
                  TextConst(
                    textColor: Colors.black,
                    fontSize: Sizes.screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    text: 'Are you sure want to exit?',
                  ),
                  SizedBox(height: Sizes.screenHeight * 0.04),
                  SizedBox(
                    width: Sizes.screenWidth * 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonConst(
                          onTap: () {
                            SystemNavigator.pop();
                          },
                          width: Sizes.screenWidth * 0.80,
                          textColor: Colors.black,
                          color: AppColor.scaffoldBackgroundColor,
                          label: "Yes",
                          boxShadow: const [
                            BoxShadow(
                              color: AppColor.textGreyColor,
                              offset: Offset(2, 2),
                              blurRadius: 2,
                            )
                          ],
                        ),
                        SizedBox(height: Sizes.screenHeight * 0.03),
                        ButtonConst(
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                          width: Sizes.screenWidth * 0.80,
                          textColor: AppColor.whiteColor,
                          color: AppColor.activeButtonGreenColor,
                          label: "No",
                          boxShadow: const [
                            BoxShadow(
                              color: AppColor.textGreyColor,
                              offset: Offset(0, 2),
                              blurRadius: 2,
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ) ??
        false;
  }
}
