import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/game_view_model.dart';
import 'package:gold11/view_model/basic_app_feature_view_model.dart';

import '../../../res/color_const.dart';
import '../../const_widget/appbar_const.dart';

class HowToPlayGameTypeScreen extends StatefulWidget {
  const HowToPlayGameTypeScreen({super.key});

  @override
  State<HowToPlayGameTypeScreen> createState() =>
      _HowToPlayGameTypeScreenState();
}

class _HowToPlayGameTypeScreenState extends State<HowToPlayGameTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameViewModel>(builder: (context, gameViewModel, child) {
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: const AppBarConst(
          title: "How to Play",
          appBarColor: AppColor.blackColor,
        ),
        body: GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          crossAxisCount: Sizes.screenWidth>500?3:2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: List.generate(gameViewModel.gameType.data!.length+1, (i) {
            if (i == 0) {
              return ContainerConst(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.primaryRedColor,
                  border: Border.all(
                      color: AppColor.scaffoldBackgroundColor, width: 1),
                  child: ContainerConst(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, AppRoutes.bottomNavigationScreen);
                      },
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.blackColor.withOpacity(0.3),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(Assets.assetsSplashLogo,width: 50,),
                          TextConst(
                            text: "Home",
                            fontSize: Sizes.fontSizeLarge,
                            textColor: AppColor.whiteColor,
                            fontWeight: FontWeight.bold,
                            alignment: Alignment.centerLeft,
                          ),
                        ],
                      )));
            }
            else{
              final gameData = gameViewModel.gameType.data![i - 1];
              return ContainerConst(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(gameData.bgImages),
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                      color: AppColor.scaffoldBackgroundColor, width: 1),
                  child: ContainerConst(
                      onTap: () {
                        Provider.of<BasicAppFeatureViewModel>(context,
                                listen: false)
                            .fetchHowToPlay(gameData.id.toString())
                            .then((_) {
                          Navigator.pushNamed(
                              context, AppRoutes.howToPlayDataScreen);
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.blackColor.withOpacity(0.3),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            gameData.images,
                          ),
                          Sizes.spaceHeight10,
                          TextConst(
                            text: "${gameData.name}",
                            fontSize: Sizes.fontSizeLarge,
                            textColor: AppColor.whiteColor,
                            fontWeight: FontWeight.bold,
                            alignment: Alignment.centerLeft,
                          ),
                        ],
                      )));
            }
          }),
        ),
      );
    });
  }
}
