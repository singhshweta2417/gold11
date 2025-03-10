// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gold11/res/color_const.dart';
// import 'package:gold11/view/drawer/drawer_screen.dart';
// import 'package:gold11/view/widgets/my_matches.dart';
// import 'package:gold11/view/const_widget/tab_appbar.dart';
// import 'package:gold11/view_model/game_view_model.dart';
//
// class BottomNavMyMatchScreen extends StatefulWidget {
//   const BottomNavMyMatchScreen({super.key});
//
//   @override
//   State<BottomNavMyMatchScreen> createState() => _BottomNavMyMatchScreenState();
// }
//
//
// class _BottomNavMyMatchScreenState extends State<BottomNavMyMatchScreen>
//     with SingleTickerProviderStateMixin {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   late TabController _tabController;
//
//   final gamesList = [
//     const Tab(icon: Icon(Icons.sports_cricket), text: 'Cricket'),
//     const Tab(icon: Icon(Icons.sports_soccer), text: 'Football'),
//     const Tab(icon: Icon(Icons.sports_basketball), text: 'Basketball'),
//     const Tab(icon: Icon(Icons.sports_baseball), text: 'Baseball'),
//   ];
//
//   final subTabList = [
//     const Tab(text: 'Upcoming'),
//     const Tab(text: 'Live'),
//     const Tab(text: 'Completed'),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<GameViewModel>(builder: (context, gameProvider, child) {
//       return Scaffold(
//         key: scaffoldKey,
//         drawer: const HomeScreenDrawer(),
//         appBar: TabAppBar(
//           title: "My Matches",
//           scaffoldKey: scaffoldKey,
//         ),
//         body: Container(
//           color: AppColor.whiteColor,
//           child: TabBarView(
//             controller: _tabController,
//             children: gameProvider.gameType.data!.map((tab) {
//               return DefaultTabController(
//                 length: gameProvider.matchType.data!.length,
//                 child: Column(
//                   children: [
//                     TabBar(
//                       tabAlignment: TabAlignment.start,
//                       isScrollable: true,
//                       tabs: gameProvider.matchType.data!.map((e) {
//                         return Tab(
//                           text: e.name,
//                         );
//                       }).toList(),
//                       labelColor: AppColor.primaryRedColor,
//                       indicatorColor: AppColor.primaryRedColor,
//                       indicatorWeight: 2,
//                     ),
//                     Expanded(
//                       child: TabBarView(children: [
//                         MyMatchListing(
//                           matchData: gameProvider.gameData.myUpcomingMatch!,
//                         ),
//                         MyMatchListing(
//                           matchData: gameProvider.gameData.live!,
//                         ),
//                         MyMatchListing(
//                           matchData: gameProvider.gameData.complete!,
//                         ),
//                       ]),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       );
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/view/drawer/drawer_screen.dart';
import 'package:gold11/view/widgets/my_matches.dart';
import 'package:gold11/view/const_widget/tab_appbar.dart';
import 'package:gold11/view_model/game_view_model.dart';

class BottomNavMyMatchScreen extends StatefulWidget {
  const BottomNavMyMatchScreen({super.key});

  @override
  State<BottomNavMyMatchScreen> createState() => _BottomNavMyMatchScreenState();
}

class _BottomNavMyMatchScreenState extends State<BottomNavMyMatchScreen>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gameProvider = Provider.of<GameViewModel>(context, listen: false);
      int defaultIndex = 0;
      if (gameProvider.gameData.myUpcomingMatch!.isEmpty &&
          gameProvider.gameData.live!.isNotEmpty) {
        defaultIndex = 1;
      } else if (gameProvider.gameData.myUpcomingMatch!.isEmpty &&
          gameProvider.gameData.live!.isEmpty &&
          gameProvider.gameData.complete!.isNotEmpty) {
        defaultIndex = 2;
      }
      _tabController = TabController(
        length: 3,
        vsync: this,
        initialIndex: defaultIndex,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
  Future<void> _refreshMatches() async {
    // Provider.of<GameViewModel>(context, listen: false).getGameType(context);
    // Provider.of<PlayerViewModel>(context, listen: false).getPlayerDesignation(context);
    // Provider.of<ContestViewModel>(context, listen: false)
    //     .setEnableJoinContestBottomSheet(false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameViewModel>(builder: (context, gameProvider, child) {
      return Scaffold(
        key: scaffoldKey,
        drawer: const HomeScreenDrawer(),
        appBar: TabAppBar(
          title: "My Matches",
          scaffoldKey: scaffoldKey,
        ),
        body: _tabController == null
            ? const Center(child: CircularProgressIndicator())
            : Container(
                color: AppColor.whiteColor,
                child: Column(
                  children: [
                    TabBar(
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Upcoming'),
                        Tab(text: 'Live'),
                        Tab(text: 'Completed'),
                      ],
                      labelColor: AppColor.primaryRedColor,
                      indicatorColor: AppColor.primaryRedColor,
                      indicatorWeight: 2,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children:  const [
                          MyMatchListing(
                            index:0,
                          ),
                          MyMatchListing(
                            index:1,
                          ),
                          MyMatchListing(
                            index:2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
