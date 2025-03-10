import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view_model/notification_view_model.dart';

import '../../res/shared_preferences_util.dart';
import '../../res/app_const.dart';
import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../../utils/utils.dart';
import '../const_widget/text_const.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationViewModel>(
        builder: (context, notificationCon, child) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notificationCon.viewNewNotifications(
            Provider.of<SharedPrefViewModel>(context, listen: false).userToken,
            AppConstants.notificationTypeAll);
      });
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColor.scaffoldBackgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColor.primaryRedColor,
            iconTheme: const IconThemeData(color: Colors.white),
            title: TextConst(
              text: "Notifications",
              textColor: AppColor.whiteColor,
              fontSize: Sizes.fontSizeLarge / 1.25,
              alignment: FractionalOffset.centerLeft,
              fontWeight: FontWeight.w600,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: ColoredBox(
                color: Colors.white,
                child: TabBar(
                  onTap: (tabIndex) {
                    if (tabIndex == 1) {
                      Provider.of<NotificationViewModel>(context, listen: false)
                          .fetchNotification(AppConstants.notificationTypeAll)
                          .then((v) {
                        notificationCon.viewNewNotifications(
                            Provider.of<SharedPrefViewModel>(context,
                                    listen: false)
                                .userToken,
                            AppConstants.notificationTypeAll);
                      });
                    } else if (tabIndex == 2) {
                      Provider.of<NotificationViewModel>(context, listen: false)
                          .fetchNotification(AppConstants.notificationTypeOffer)
                          .then((v) {
                        notificationCon.viewNewNotifications(
                            Provider.of<SharedPrefViewModel>(context,
                                    listen: false)
                                .userToken,
                            AppConstants.notificationTypeOffer);
                      });
                    } else {
                      if (kDebugMode) {
                        print("invalid tab index");
                      }
                    }
                  },
                  tabs: [
                    Tab(text: 'All'.toUpperCase()),
                    Tab(text: 'Offers'.toUpperCase()),
                  ],
                  labelColor: AppColor.primaryRedColor,
                  indicatorColor: Colors.blueAccent,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              notificationListing(),
              notificationListing(),
            ],
          ),
        ),
      );
    });
  }

  Widget notificationListing() {
    return Consumer<NotificationViewModel>(
      builder: (context, notificationCon, child) {
        switch (notificationCon.viewState) {
          case NotificationViewState.idle:
            return const Scaffold(
              backgroundColor: AppColor.whiteColor,
              body: Utils.loadingRed,
            );
          case NotificationViewState.loading:
            return const Scaffold(
              backgroundColor: AppColor.whiteColor,
              body: Utils.loadingRed,
            );
          case NotificationViewState.error:
            return Scaffold(
              backgroundColor: AppColor.whiteColor,
              body: Utils.noDataAvailableVector(
                  messageLabel: "Something went wrong"),
            );
          case NotificationViewState.success:
            return notificationCon.notificationData!.data!.isEmpty
                ? Utils.noDataAvailableVector()
                : ListView.builder(
                    itemCount: notificationCon.notificationData!.data!.length,
                    itemBuilder: (_, int i) {
                      final data = notificationCon.notificationData!.data![i];
                      return ContainerConst(
                        color: AppColor.whiteColor,
                        border: const Border(
                            bottom: BorderSide(
                                color: AppColor.textGreyColor, width: 1)),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ExpansionTile(
                          leading: Image.asset(Assets.assetsStraightCoinReward),
                          title: TextConst(
                            text: data.title ?? "",
                            alignment: Alignment.centerLeft,
                            width: Sizes.screenWidth / 2,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          subtitle: TextConst(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            text: data.description ?? "",
                            alignment: Alignment.centerLeft,
                            fontSize: Sizes.fontSizeOne,
                            textColor: AppColor.textGreyColor,
                            maxLines: 2,
                          ),
                          children: [
                            const Divider(),
                            TextConst(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              text: data.description ?? "",
                              alignment: Alignment.centerLeft,
                              fontSize: Sizes.fontSizeOne,
                              textColor: AppColor.textGreyColor,
                            ),
                          ],
                        ),
                      );
                    },
                  );
        }
      },
    );
  }
}
