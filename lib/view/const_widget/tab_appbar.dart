

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view/widgets/circular_profile_image_widget.dart';
import 'package:gold11/view_model/profile_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/assets.dart';
import '../../res/app_const.dart';
import '../../utils/route/app_routes.dart';
import '../../view_model/game_view_model.dart';
import '../../view_model/notification_view_model.dart';
import 'container_const.dart';

class TabAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const TabAppBar({
    super.key,
    this.title,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GameViewModel>(builder: (context, gameProvider, child) {
      final gameType = gameProvider.gameType;
      final gameDataAvailable =
          gameType.data != null && gameType.data!.isNotEmpty;

      return AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColor.primaryRedColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: ContainerConst(
            color: AppColor.whiteColor,
            gradient: AppColor.lightToDarkRedGradient,
            child: Column(
              children: [
                ContainerConst(
                  height: kToolbarHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircularProfileImageWidget(
                        onPressed: () => scaffoldKey.currentState?.openDrawer(),
                      ),
                      Sizes.spaceWidth10,
                      title == null ? appLogoWithName() : appBarTitle(),
                      const Spacer(),
                      title == "Winners"
                          ? appBarActionForWinnerScreen()
                          : appBarActionsForHomeScreen(context),
                    ],
                  ),
                ),
                gameDataAvailable
                    ? tabBarDesign(context, gameProvider)
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);

  Widget tabBarDesign(BuildContext context, GameViewModel gameProvider) {
    return DefaultTabController(
      initialIndex: gameProvider.selectedGameTabIndex,
      length: gameProvider.gameType.data!.length,
      child: SizedBox(
        height: kToolbarHeight,
        child: TabBar(
          onTap: (tabIndex) async {
            await gameProvider.getGameData(
                context, gameProvider.gameType.data![tabIndex].id.toString());
            gameProvider.setSelectedGameTabIndex(
                tabIndex, gameProvider.gameType.data![tabIndex].id!);
          },
          tabs: List.generate(
            gameProvider.gameType.data!.length,
            (i) => Tab(
              icon: ImageIcon(
                NetworkImage(gameProvider.gameType.data![i].images),
                size: 22,
              ),
              text: gameProvider.gameType.data![i].name,
            ),
          ),
          labelColor: AppColor.whiteColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 1.5,
          indicatorColor: AppColor.whiteColor,
          unselectedLabelColor:
              AppColor.scaffoldBackgroundColor.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget appBarActionsForHomeScreen(BuildContext context) {
    return Consumer<NotificationViewModel>(
        builder: (context, notificationCon, child) {
      final notificationData = notificationCon.notificationData;
      final notificationCount = int.tryParse(notificationData?.counts?.toString() ?? '0') ?? 0;
      final supportUrl = Provider.of<ProfileViewModel>(context, listen: false).userProfile?.supportUrl;
      return Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.notificationScreen);
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.notificationScreen);
                  },
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    color: AppColor.whiteColor,
                    size: 28,
                  ),
                ),
                notificationCount >0
                    ? ContainerConst(
                        color: AppColor.blackColor,
                        shape: BoxShape.circle,
                        padding: const EdgeInsets.all(3),
                        child: Text(
                          "$notificationCount",
                          style: TextStyle(
                            fontSize: Sizes.fontSizeZero,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(),
                // Consumer<NotificationViewModel>(
                //   builder: (context, notificationCon, child) {
                //     final notificationData = notificationCon.notificationData;
                //
                //
                //     // Safely parse the notification count
                //     final notificationCount = int.tryParse(notificationData!.counts?.toString() ?? '0') ?? 0;
                //
                //   },
                // ),
              ],
            ),
          ),

          supportUrl == null || supportUrl.isEmpty?const SizedBox.shrink():
          IconButton(
            onPressed: ()async {
              _launchURL(supportUrl);

            },
            icon: const Icon(
              Icons.chat_outlined,
              color: AppColor.whiteColor,
              size: 28,
            ),
          ),

          ContainerConst(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.walletAddCashScreen);
            },
            color: AppColor.whiteColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Icon(
              Icons.wallet,
              color: AppColor.whiteColor,
            ),
          ),
          Sizes.spaceWidth10,
        ],
      );
    });
  }

  Widget appBarActionForWinnerScreen() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.share,
        color: AppColor.whiteColor,
      ),
    );
  }

  Widget appLogoWithName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.assetsSplashLogo,
          width: Sizes.screenWidth / 10,
        ),
        Sizes.spaceWidth5,
        TextConst(
          text: AppConstants.appName,
          fontSize: Sizes.fontSizeLarge,
          fontWeight: FontWeight.bold,
          textColor: AppColor.whiteColor,
        ),
        Sizes.spaceWidth20,
      ],
    );
  }

  Widget appBarTitle() {
    return TextConst(
      text: title!,
      textColor: AppColor.whiteColor,
      fontSize: Sizes.fontSizeLarge / 1.25,
      alignment: FractionalOffset.centerLeft,
      fontWeight: FontWeight.w600,
    );
  }
}
_launchURL(String urlget) async {
  var url = urlget;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}