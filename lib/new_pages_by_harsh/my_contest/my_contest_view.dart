import 'package:flutter/material.dart';
import 'package:gold11/model/game_data_model.dart';
import 'package:gold11/new_pages_by_harsh/live_match/score_card.dart';
import 'package:gold11/new_pages_by_harsh/live_match/live_status.dart';
import 'package:gold11/new_pages_by_harsh/live_match/live_match_score.dart';
import 'package:gold11/new_pages_by_harsh/model/live_my_constant.dart';
import 'package:gold11/new_pages_by_harsh/my_contest/my_contest_leader_board.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';

import '../../view/widgets/contest_winners_list.dart';

class MyContestView extends StatefulWidget {
  final GameData data;
  final MyLiveContest myContestData;
  const MyContestView(
      {super.key, required this.data, required this.myContestData});

  @override
  State<MyContestView> createState() => _LiveMatchViewState();
}

class _LiveMatchViewState extends State<MyContestView> {
  final List<String> contestList = [
    "Winnings",
    "LeaderBoard",
  //  "Commentary",
    "Scorecard",
    "Stats",
  ];
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: contestList.length,
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.blackColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.whiteColor,
            ),
          ),
          title: TextConst(
            text: "${widget.data.homeTeamShortName} vs ${widget.data.visitorTeamShortName}",
            textColor: AppColor.whiteColor,
            fontSize: Sizes.fontSizeLarge / 1.25,
            alignment: FractionalOffset.centerLeft,
            fontWeight: FontWeight.w600,
          ),
          actions: [appBarAction()],
        ),
        body: Column(
          children: [
            LiveMatchScore(data: widget.data),
            TabBar(
              isScrollable: true,
              labelColor: AppColor.primaryRedColor,
              labelStyle: const TextStyle(
                color: AppColor.whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              indicatorColor: Colors.blueAccent,
              tabAlignment: TabAlignment.start,
              tabs: contestList.map((title) => Tab(text: title)).toList(),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const ContestWinnersList(),
                  MyContestLeaderBoard(
                      data: widget.data,
                      MyLiveContestdata: widget.myContestData),
                  ScorecardPage(data: widget.data,),
                  LiveStats(data: widget.data),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBarAction() {
    return Row(
      children: [
        ContainerConst(
          margin: const EdgeInsets.only(right: 15),
          shape: BoxShape.circle,
          padding: const EdgeInsets.all(5),
          border: Border.all(color: Colors.white, width: 2),
          child: Text(
            "?",
            style: TextStyle(
                fontSize: Sizes.fontSizeOne,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        ContainerConst(
          margin: const EdgeInsets.only(right: 15),
          shape: BoxShape.circle,
          padding: const EdgeInsets.all(5),
          border: Border.all(color: Colors.white, width: 2),
          child: const Text(
            "PTS",
            style: TextStyle(
                fontSize: 7, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
