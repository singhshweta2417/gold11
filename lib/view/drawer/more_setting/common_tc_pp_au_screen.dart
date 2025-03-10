import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

import 'package:gold11/view/const_widget/appbar_const.dart';

import '../../../res/color_const.dart';
import '../../../utils/utils.dart';
import '../../../view_model/basic_app_feature_view_model.dart';

class CommonTcPpAuScreen extends StatelessWidget {
  const CommonTcPpAuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BasicAppFeatureViewModel>(
        builder: (context, commonSettingCon, child) {
          switch (commonSettingCon.viewState) {
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
              return  Scaffold(
                  appBar:  AppBarConst(title:commonSettingCon.commonSetting.heading??"",),
                  body:SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: HtmlWidget(commonSettingCon.commonSetting.data!),
                    ),
                  )
              );
          }
        }
    );
  }
}
