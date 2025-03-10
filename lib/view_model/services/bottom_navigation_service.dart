
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/view/bottom_navigation/refer_and_earn/bottom_nav_refer_section.dart';
import 'package:gold11/view_model/game_view_model.dart';

import '../../view/bottom_navigation/home_section/bottom_nav_home_screen.dart';
import '../../view/bottom_navigation/my_match_section/bottom_nav_my_match_screen.dart';
import '../../view/bottom_navigation/rewards_section/bottom_nav_reward_screen.dart';

class BottomNavigationViewModel extends ChangeNotifier{
  final List<Widget> widgetOptions = <Widget>[
    const BottomNavHomeScreen(),
    const BottomNavMyMatchScreen(),
    const BottomNavRewardScreen(),
    const BottomNavReferSection(),
  ];

  int _initBottomNavItemIndex = 0;

  int get initBottomNavItemIndex => _initBottomNavItemIndex;

  updateBottomNavItemIndex(int index,BuildContext context) async {
    _initBottomNavItemIndex = index;
    if(index==1) {
      Provider.of<GameViewModel>(context, listen: false);
    }

    notifyListeners();
  }
}