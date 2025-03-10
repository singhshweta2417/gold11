import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/view/const_widget/appbar_const.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../view_model/language_view_model.dart';
import '../../const_widget/container_const.dart';


class AppLanguageSelectionScreen extends StatelessWidget {
  const AppLanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarConst(title: "App Language",),
      body: ContainerConst(
        height: Sizes.screenHeight,
        width: Sizes.screenWidth,
        color: AppColor.whiteColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: [
            const TextConst(text: "Select Language", alignment: Alignment.centerLeft,),
            Sizes.spaceHeight15,
            languageListWithChangeOption(context),
            const Spacer(),
            ButtonConst(
                color: AppColor.activeButtonGreenColor,
                textColor: AppColor.whiteColor,
                fontWeight: FontWeight.w600,
                label: AppLocalizations.of(context)!.continueText.toUpperCase(),onTap:(){
              Navigator.pushReplacementNamed(context, AppRoutes.introScreen);
            }),
            Sizes.spaceHeight25
          ],
        ),
      ),
    );
  }
  Widget appLogo(){
    return Image.asset(Assets.assetsSplashLogo, width: Sizes.screenWidth/3,);
  }

  Widget textContent(context){
    return ContainerConst(
      child: Column(
        children: [
          TextConst(text:AppLocalizations.of(context)!.selectAppLanguage ,textColor: Colors.white,fontSize: Sizes.fontSizeLarge,fontWeight: FontWeight.w600,),
          Sizes.spaceHeight20,
          TextConst(text: AppLocalizations.of(context)!.changeLangInfo, textAlign: TextAlign.center,textColor: AppColor.whiteColor,)
        ],
      ),
    );
  }

  Widget languageListWithChangeOption(BuildContext context) {
    return Consumer<LanguageViewModel>(
      builder: (context, languageViewModel, child) {
        return ListView.builder(
          shrinkWrap: true,
          // itemCount: LanguageViewModel.supportedLanguages.length,
          itemCount: 1,
          itemBuilder: (context, index) {
            final language = LanguageViewModel.supportedLanguages[index];
            final languageCode = language['code']!;
            final languageName = language['name']!;
            bool isSelected = languageViewModel.appLocal?.languageCode == languageCode;
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ContainerConst(
                border:isSelected?Border.all(color: AppColor.activeButtonGreenColor.withOpacity(0.6), width: 2) :Border.all(color: AppColor.primaryRedColor.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10),
                padding: const EdgeInsets.symmetric(vertical: 5),
                color:isSelected?AppColor.activeButtonGreenColor.withOpacity(0.08):AppColor.whiteColor,
                child: ListTile(
                  trailing: Radio<String>(
                    activeColor:AppColor.activeButtonGreenColor,
                    value: languageCode,
                    groupValue: languageViewModel.appLocal?.languageCode,
                    onChanged: (String? value) {
                      if (value != null) {
                        languageViewModel.changeLanguage(Locale(value));
                      }
                    },
                  ),
                  title: TextConst(text: languageName,alignment: FractionalOffset.centerLeft,fontWeight: FontWeight.w600,fontSize: Sizes.fontSizeTwo,textColor:AppColor.blackColor,),
                  onTap: () {
                    languageViewModel.changeLanguage(Locale(languageCode));
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

