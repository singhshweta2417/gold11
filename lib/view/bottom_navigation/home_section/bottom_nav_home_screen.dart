import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/sheemar/home_page_sheemar.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/drawer/drawer_screen.dart';
import 'package:gold11/view_model/game_view_model.dart';
import '../../../res/app_const.dart';
import '../../../res/color_const.dart';
import '../../../view_model/notification_view_model.dart';
import '../../const_widget/tab_appbar.dart';
import 'home_tab_content_screen.dart';

class BottomNavHomeScreen extends StatefulWidget {
  const BottomNavHomeScreen({super.key});

  @override
  State<BottomNavHomeScreen> createState() => _BottomNavHomeScreenState();
}

class _BottomNavHomeScreenState extends State<BottomNavHomeScreen> {
  // Declare scaffoldKey once
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GameViewModel>(context, listen: false).getMatchType(context);
      Provider.of<NotificationViewModel>(context, listen: false)
          .fetchNotification(AppConstants.notificationTypeAll);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameViewModel>(builder: (context, gameProvider, child) {
      switch (gameProvider.gameState) {
        case GameState.loading:
          return const HomePageSheemar();
        case GameState.success:
          return Scaffold(
              key: scaffoldKey, // Use the unique scaffoldKey
              backgroundColor: AppColor.whiteColor,
              drawer: const HomeScreenDrawer(),
              appBar: TabAppBar(scaffoldKey: scaffoldKey), // Pass key to child
              body: const HomePageTabData());
        case GameState.error:
          return Scaffold(
              body: Utils.noDataAvailableVector(
                  messageLabel: "Something went wrong"));
        case GameState.idle:
          return Utils.loadingRed;
      }
    });
  }
}

