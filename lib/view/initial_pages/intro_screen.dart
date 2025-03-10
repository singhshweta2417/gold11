import 'package:flutter/material.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/app_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';

import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../../utils/route/app_routes.dart';
import '../const_widget/button_const.dart';
import '../const_widget/text_const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerConst(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        height: Sizes.screenHeight,
        width: Sizes.screenWidth,
        color: AppColor.blackColor,
        gradient: RadialGradient(
          colors: [
            AppColor.primaryRedColor.withOpacity(0.8),
            AppColor.blackColor,
          ],
          radius: 0.7,
          focalRadius: 0.1,
          focal: Alignment.center,
        ),
        image: const DecorationImage(
            image: AssetImage(Assets.assetsIntroScreenPlayer),
            ),
        alignment: Alignment.center,
        child: Column(
          children: [
            appLogoWithName(),
            const Spacer(),
            ButtonConst(
              borderRadius: BorderRadius.circular(10),
                label: AppLocalizations.of(context)!.getStarted.toUpperCase(),
                onTap: () {
                  Navigator.pushNamed(
                      context, AppRoutes.loginScreen);
                }),
            Sizes.spaceHeight25
          ],
        ),
      ),
    );
  }

  Widget appLogoWithName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.assetsSplashLogo,
          width: Sizes.screenWidth / 8,
        ),
        Sizes.spaceWidth5,
        TextConst(
          text: AppConstants.appName,
          fontSize: Sizes.fontSizeHeading,
          fontWeight: FontWeight.bold,
          textColor: AppColor.whiteColor,
        )
      ],
    );
  }
}
