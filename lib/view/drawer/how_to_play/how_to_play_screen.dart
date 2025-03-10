import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/appbar_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/basic_app_feature_view_model.dart';

import '../../const_widget/container_const.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BasicAppFeatureViewModel>(
        builder: (context, howToPlayCon, child) {
      switch (howToPlayCon.viewState) {
        case BasicAppFeatureViewState.idle:
          return const Scaffold(
            backgroundColor: AppColor.whiteColor,
            body: Utils.loadingRed,
          );
        case BasicAppFeatureViewState.loading:
          return const Scaffold(
            backgroundColor: AppColor.whiteColor,
            body: Utils.loadingRed,
          );
        case BasicAppFeatureViewState.error:
          return Scaffold(
            backgroundColor: AppColor.whiteColor,
            body: Utils.noDataAvailableVector(
                messageLabel: "Something went wrong"),
          );
        case BasicAppFeatureViewState.success:
          return Scaffold(
            backgroundColor: AppColor.whiteColor,
            appBar: const AppBarConst(
              title: "How to Play",
              appBarColor: AppColor.blackColor,
            ),
            body: howToPlayCon.howToPlay.data!.isNotEmpty
                ? ContainerConst(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              physics:const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              shrinkWrap: true,
                              itemCount: howToPlayCon.howToPlay.data!.length,
                              itemBuilder: (_, int i){
                                final rules = howToPlayCon.howToPlay.data![i];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: ContainerConst(
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    padding: const EdgeInsets.all(4),
                                    child: ContainerConst(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      gradient: LinearGradient(
                                          begin: Alignment.centerRight,
                                          end: Alignment.centerLeft,
                                          colors: [
                                            const Color(0xffe3f9e7).withOpacity(0.5),
                                            const Color(0xffe3f9e7).withOpacity(0.1),
                                            const Color(0xffe3f9e7).withOpacity(0.1),
                                            const Color(0xffe3f9e7).withOpacity(0.1),
                                          ]),
                                      child: ListTile(
                                        title: TextConst(text: "Rule 0${i+1}: ${rules.title}",alignment: Alignment.centerLeft,textColor: AppColor.textGreyColor,fontWeight: FontWeight.w600,),
                                        subtitle: TextConst(text: rules.description??"",alignment: Alignment.centerLeft,fontSize: Sizes.fontSizeOne,),
                                      ),
                                    ),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  )
                : Center(child: Utils.noDataAvailableVector()),
          );
      }
    });
  }
}
