
import 'package:flutter/material.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view/drawer/drawer_screen.dart';
import 'package:gold11/view/widgets/circular_profile_image_widget.dart';

import '../../../res/color_const.dart';

class BottomNavWinnersScreen extends StatefulWidget {
  const BottomNavWinnersScreen({super.key});

  @override
  State<BottomNavWinnersScreen> createState() => _BottomNavWinnersScreenState();
}

class _BottomNavWinnersScreenState extends State<BottomNavWinnersScreen>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      key: scaffoldKey,
      drawer:const HomeScreenDrawer(),
      appBar: AppBar(
        leading:  CircularProfileImageWidget(onPressed: (){
          if (scaffoldKey.currentState!.isDrawerOpen) {
            scaffoldKey.currentState!.closeDrawer();
          } else {
            scaffoldKey.currentState!.openDrawer();
          }
        },),
        title: TextConst(text: "Rewards",textColor: AppColor.whiteColor,fontSize: Sizes.fontSizeLarge/1.25,alignment: FractionalOffset.centerLeft,fontWeight: FontWeight.w600,),
        backgroundColor: AppColor.blackColor,
        elevation: 0,
        actions: const [
          // ContainerConst(
          //     onTap: (){
          //       Navigator.pushNamed(context, AppRoutes.mlmHomeScreen);
          //     },
          //     height: 35,
          //     width: Sizes.screenWidth/3,
          //     padding: const EdgeInsets.only(left: 2),
          //     color: AppColor.scaffoldBackgroundColor.withOpacity(0.2),
          //     gradient: AppColor.darkRedToBlackGradient,
          //     borderRadius: BorderRadius.circular(5),
          //     border: Border.all(color: AppColor.scaffoldBackgroundColor),
          //     child:Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         TextConst(text: "Explore MLM".toUpperCase(), textColor: AppColor.whiteColor,fontWeight: FontWeight.w600,),
          //         const Icon(Icons.navigate_next_outlined, color: AppColor.whiteColor,)
          //       ],
          //     )
          // ),
          Sizes.spaceWidth10
        ],
      ),

      // TabAppBar(
      //   scaffoldKey: scaffoldKey,
      //   title: "Winners",
      // ),
      body: ContainerConst(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Sizes.spaceHeight15,
              // const StoryListingScreen(),
              Sizes.spaceHeight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextConst(
                    text: "Mega Contest Winners",
                    fontWeight: FontWeight.w600,
                    padding: EdgeInsets.only(left: 15),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextConst(
                        text: "Filter by Series",
                        fontSize: Sizes.fontSizeOne,
                      ),
                      const Icon(Icons.filter_alt_outlined),
                      Sizes.spaceWidth10,
                    ],
                  ),
                ],
              ),
              winnerDataBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget winnerDataBox() {
    List<MatchData> dummyData = List.generate(10, (index) {
      return MatchData(
        matchTitle: "World Cup 2024",
        date: "27 Jun, 2024",
        team1Name: "INDIA",
        team1ImageUrl: "https://www.worldometers.info//img/flags/small/tn_be-flag.gif",
        team2Name: "AUSTRALIA",
        team2ImageUrl: "https://www.worldometers.info//img/flags/small/tn_bn-flag.gif",
        prize: "50 Crores",
        winners: [
          WinnerData(rank: "Rank #1", name: "ashu 123", prize: "Won 2 crore"),
          WinnerData(rank: "Rank #2", name: "john_doe", prize: "Won 1 crore"),
          WinnerData(rank: "Rank #1", name: "ashu 123", prize: "Won 2 crore"),
          WinnerData(rank: "Rank #2", name: "john_doe", prize: "Won 1 crore"),
          WinnerData(rank: "Rank #1", name: "ashu 123", prize: "Won 2 crore"),
          WinnerData(rank: "Rank #2", name: "john_doe", prize: "Won 1 crore"),
        ],
      );
    });

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: dummyData.length,
      itemBuilder: (_, int i) {
        final match = dummyData[i];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: ContainerConst(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.scaffoldBackgroundColor, width: 2),
            child: Column(
              children: [
                ContainerConst(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextConst(text: match.matchTitle, fontSize: Sizes.fontSizeZero),
                      TextConst(text: match.date, fontSize: Sizes.fontSizeZero),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Sizes.screenWidth / 3.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ContainerConst(
                                  shape: BoxShape.circle,
                                  width: 45,
                                  height: 45,
                                  image: DecorationImage(
                                    image: NetworkImage(match.team1ImageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Sizes.spaceWidth5,
                                TextConst(
                                  text: match.team1Name.substring(0,3),
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            Sizes.spaceHeight5,
                            TextConst(
                              maxLines: 1,
                              alignment: Alignment.centerLeft,
                              text: match.team1Name,
                              textColor: AppColor.textGreyColor,
                              fontSize: Sizes.fontSizeOne,
                            ),
                          ],
                        ),
                      ),
                      const TextConst(text: "VS"),
                      SizedBox(
                        width: Sizes.screenWidth / 3.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextConst(
                                  text: match.team2Name.substring(0,3),
                                  fontWeight: FontWeight.bold,
                                ),
                                Sizes.spaceWidth5,
                                ContainerConst(
                                  shape: BoxShape.circle,
                                  width: 45,
                                  height: 45,
                                  image: DecorationImage(
                                    image: NetworkImage(match.team2ImageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            Sizes.spaceHeight5,
                            TextConst(
                              alignment: FractionalOffset.centerRight,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: match.team2Name,
                              textColor: AppColor.textGreyColor,
                              fontSize: Sizes.fontSizeOne,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      const Icon(Icons.emoji_events),
                      Sizes.spaceWidth5,
                      TextConst(text: match.prize),
                    ],
                  ),
                ),
                ContainerConst(
                  height: 160,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: match.winners.length,
                    itemBuilder: (_, int index) {
                      final winner = match.winners[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ContainerConst(
                          width: Sizes.screenWidth / 3.5,
                          border: Border.all(color: AppColor.scaffoldBackgroundColor),
                          borderRadius: BorderRadius.circular(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextConst(
                                text: winner.rank,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                              ),
                              TextConst(
                                text: winner.name,
                                alignment: Alignment.centerLeft,
                                fontSize: Sizes.fontSizeZero,
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                              ),
                              const ContainerConst(
                                height: 70,
                                width: 70,
                                shape: BoxShape.circle,
                                // color: Colors.red,
                                image: DecorationImage(image: NetworkImage("https://randomuser.me/api/portraits/men/1.jpg"),fit: BoxFit.fill),
                              ),
                              ContainerConst(
                                color: Colors.grey.shade100,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                child: TextConst(
                                  text: winner.prize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MatchData {
  final String matchTitle;
  final String date;
  final String team1Name;
  final String team1ImageUrl;
  final String team2Name;
  final String team2ImageUrl;
  final String prize;
  final List<WinnerData> winners;

  MatchData({
    required this.matchTitle,
    required this.date,
    required this.team1Name,
    required this.team1ImageUrl,
    required this.team2Name,
    required this.team2ImageUrl,
    required this.prize,
    required this.winners,
  });
}

class WinnerData {
  final String rank;
  final String name;
  final String prize;

  WinnerData({
    required this.rank,
    required this.name,
    required this.prize,
  });
}

