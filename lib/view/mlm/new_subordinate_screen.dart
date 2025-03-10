import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/app_const.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/mlm_view_model.dart';

import '../../res/sizes_const.dart';

class NewSubordinateScreen extends StatefulWidget {
  const NewSubordinateScreen({super.key});

  @override
  State<NewSubordinateScreen> createState() => _NewSubordinateScreenState();
}

class _NewSubordinateScreenState extends State<NewSubordinateScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<MlmViewModel>(context, listen: false)
          .fetchReferralData(
          Provider.of<SharedPrefViewModel>(context,
              listen: false)
              .userToken,
          AppConstants.todayReferralData);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MlmViewModel>(builder: (context, mlmCon, child) {
      if(mlmCon.mlmView== MlmViewState.loading){
        return Utils.loadingRed;
      }
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor:AppColor.whiteColor,
          appBar: AppBar(
            backgroundColor: AppColor.primaryRedColor,
            iconTheme: const IconThemeData(color: AppColor.whiteColor),
            title: TextConst(
              text: "New Subordinate",
              textColor: AppColor.whiteColor,
              fontSize: Sizes.fontSizeLarge / 1.25,
              alignment: FractionalOffset.centerLeft,
              fontWeight: FontWeight.w600,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: ContainerConst(
                color: AppColor.whiteColor,
                child: TabBar(
                  onTap: (tabIndex) {
                    final userToken =
                        Provider.of<SharedPrefViewModel>(context, listen: false)
                            .userToken;
                    if (tabIndex == 0) {
                      mlmCon.fetchReferralData(
                          userToken, AppConstants.todayReferralData);
                    } else if (tabIndex == 1) {
                      mlmCon.fetchReferralData(
                          userToken, AppConstants.yesterdayReferralData);
                    } else if (tabIndex == 2) {
                      mlmCon.fetchReferralData(
                          userToken, AppConstants.thisMonthReferralData);
                    } else {
                      if (kDebugMode) {
                        print("No valid tab");
                      }
                    }
                  },
                  labelColor: AppColor.primaryRedColor,
                  indicatorColor: Colors.blueAccent,
                  indicatorWeight: 2,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(
                      text: "Today",
                    ),
                    Tab(text: "Yesterday"),
                    Tab(text: "This Month"),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              subordinateDataList(),
              subordinateDataList(),
              subordinateDataList(),
            ],
          ),
        ),
      );
    });
  }

  Widget subordinateDataList() {
    return Consumer<MlmViewModel>(builder: (context, mlmCon, child) {
      switch (mlmCon.mlmView){
        case MlmViewState.idle:
          return const Scaffold(body: Utils.loadingRed,);
        case MlmViewState.loading:
          return const Scaffold(body: Utils.loadingRed,);
        case MlmViewState.error:
          return Scaffold(body: Utils.noDataAvailableVector(messageLabel: "Something went wrong, try again later"));
        case MlmViewState.success:
          if (mlmCon.dataLoading) {
            return const Scaffold(body: Utils.loadingRed,);
          }
          else if (mlmCon.myReferralData.data!.isEmpty) {
            return Utils.noDataAvailableVector();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: mlmCon.myReferralData.data!.length,
                      itemBuilder: (_, int i) {
                        return ContainerConst(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          boxShadow: const [BoxShadow(offset: Offset(0, 1), color: Colors.grey, spreadRadius: 2, blurRadius: 2)],
                          color: AppColor.whiteColor,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextConst(
                                    text: "4564***55454",
                                    width: Sizes.screenWidth / 2.5,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  TextConst(
                                    text: "UID: ashutosh1245",
                                    width: Sizes.screenWidth / 2.5,
                                    alignment: Alignment.centerRight,
                                  ),
                                ],
                              ),
                              Sizes.spaceHeight5,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextConst(
                                    text: "Direct Subordinate",
                                    width: Sizes.screenWidth / 2.5,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  TextConst(
                                    text: "08/01/2003 04:30:05",
                                    width: Sizes.screenWidth / 2.5,
                                    alignment: Alignment.centerRight,
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        );
                      }),
                  Sizes.spaceHeight5,
                  const TextConst(
                    text: "No more",
                    textColor: AppColor.blackColor,
                  )
                ],
              ),
            );
          }
      }
    });
  }
}
