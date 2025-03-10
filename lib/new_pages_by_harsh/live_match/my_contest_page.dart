import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:gold11/model/game_data_model.dart';
import 'package:gold11/new_pages_by_harsh/live_match/live_team_preview.dart';
import 'package:gold11/new_pages_by_harsh/model/live_my_constant.dart';
import 'package:gold11/new_pages_by_harsh/my_contest/my_contest_view.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/app_url_const.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/contest_view_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../view_model/services/bottom_navigation_service.dart';

class MyContestPage extends StatefulWidget {
  final GameData data;
  const MyContestPage({
    super.key,
    required this.data,
  });

  @override
  State<MyContestPage> createState() => _MyContestPageState();
}

class _MyContestPageState extends State<MyContestPage> {
  bool isAnimated = true;

  @override
  void initState() {
    myContestApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.whiteColor,
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              if (myContestItems.isNotEmpty &&
                  myContestItems[0].matchstatus == 3 &&
                  totalWinningContest != '0')
                InkWell(
                  onTap: () {},
                  child: TextConst(
                    text:
                        "Congratulations! You've won in ${totalWinningContest.toString()} Contest",
                    fontSize: Sizes.fontSizeTwo,
                    alignment: Alignment.bottomLeft,
                    textColor: AppColor.activeButtonGreenColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (myContestItems.isNotEmpty &&
                  myContestItems[0].matchstatus == 3 &&
                  totalWinningContest != '0')
                Row(
                  children: [
                    Sizes.spaceWidth15,
                    const Icon(
                      Icons.emoji_events,
                      size: 20,
                      color: AppColor.primaryRedColor,
                    ),
                    Sizes.spaceWidth5,
                    TextConst(
                      text: "₹ ${totalWinnings.toString()}",
                      fontSize: Sizes.fontSizeThree,
                      textColor: AppColor.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              Sizes.spaceHeight20,
              responseStatusCode == 400
                  ? Utils.noDataAvailableContest(onTap: () {
                    Provider.of<BottomNavigationViewModel>(context, listen: false).updateBottomNavItemIndex(0,context);
                    Navigator.pushReplacementNamed(context, AppRoutes.bottomNavigationScreen);

              })
                  : myContestItems.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : Builder(builder: (context) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: myContestItems.length,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              final data = myContestItems[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ContainerConst(
                                  onTap: () {
                                    Provider.of<ContestViewModel>(context,
                                            listen: false)
                                        .getContestDetail(
                                            context, data.contestId.toString());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyContestView(
                                                data: widget.data,
                                                myContestData: data)));
                                  },
                                  color: AppColor.whiteColor,
                                  border: Border.all(
                                      width: 2,
                                      color: AppColor.scaffoldBackgroundColor),
                                  borderRadius: BorderRadius.circular(10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextConst(
                                                    text: "Prize Pool",
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                    fontSize: Sizes.fontSizeOne,
                                                  ),
                                                  TextConst(
                                                    text: "₹ ${data.prizePool}",
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    textColor:
                                                        AppColor.blackColor,
                                                    fontSize: Sizes.fontSizeTwo,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  TextConst(
                                                    text: "Spots",
                                                    alignment: Alignment.center,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                    fontSize: Sizes.fontSizeOne,
                                                  ),
                                                  TextConst(
                                                    text: "₹ ${data.totalSpot}",
                                                    alignment: Alignment.center,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                    fontSize: Sizes.fontSizeOne,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  TextConst(
                                                    text: "Entry",
                                                    alignment:
                                                        Alignment.centerRight,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                    fontSize: Sizes.fontSizeOne,
                                                  ),
                                                  TextConst(
                                                    text: "₹ ${data.entryFee}",
                                                    alignment:
                                                        Alignment.centerRight,
                                                    textColor:
                                                        AppColor.textGreyColor,
                                                    fontSize: Sizes.fontSizeOne,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ContainerConst(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            top: 8,
                                            bottom: 8,
                                            right: 15),
                                        color: AppColor.scaffoldBackgroundColor
                                            .withOpacity(0.6),
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(1),
                                            bottomLeft: Radius.circular(1)),
                                        child: Row(
                                          children: [
                                            // Image.asset(
                                            //   Assets.assetsStraightCoinReward,
                                            //   width: 18,
                                            // ),
                                            Sizes.spaceWidth5,
                                            TextConst(
                                              text: "₹${data.firstPrize}",
                                              fontSize: Sizes.fontSizeOne,
                                              textColor: AppColor.textGreyColor,
                                            ),
                                            Sizes.spaceWidth10,
                                            Sizes.spaceWidth10,
                                            ContainerConst(
                                              width: 16,
                                              height: 16,
                                              border: Border.all(
                                                  color: AppColor.blackColor
                                                      .withOpacity(0.5)),
                                              shape: BoxShape.circle,
                                              child: TextConst(
                                                text:
                                                    data.entryLimit == 'Single'
                                                        ? "S"
                                                        : "M",
                                                fontSize: Sizes.fontSizeZero,
                                                textColor:
                                                    AppColor.textGreyColor,
                                              ),
                                            ),
                                            Sizes.spaceWidth5,
                                            TextConst(
                                              text: data.entryLimit.toString(),
                                              fontSize: Sizes.fontSizeOne,
                                              textColor: AppColor.textGreyColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                      ContainerConst(
                                        color:
                                            AppColor.scaffoldBackgroundColorTwo,
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: data.teamsData!.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              final datas =
                                                  data.teamsData![index];
                                              return InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (_) {
                                                        return LiveTeamPreview(
                                                          type: 2,
                                                          data: null,
                                                          data2: null,
                                                          data3: datas,
                                                          data4: null,
                                                        );
                                                      });
                                                },
                                                child: Column(
                                                  children: [
                                                    index > 0
                                                        ? const Divider()
                                                        : Container(),
                                                    ContainerConst(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              top: 8,
                                                              bottom: 8,
                                                              right: 15),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              TextConst(
                                                                text: datas
                                                                    .username
                                                                    .toString(),
                                                                fontSize: Sizes
                                                                    .fontSizeTwo,
                                                                textColor: AppColor
                                                                    .blackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              Sizes
                                                                  .spaceWidth10,
                                                              ContainerConst(
                                                                width: 22,
                                                                height: 16,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                color: AppColor
                                                                    .scaffoldBackgroundColor,
                                                                child:
                                                                    TextConst(
                                                                  text: datas
                                                                      .teamName
                                                                      .toString(),
                                                                  fontSize: Sizes
                                                                      .fontSizeOne,
                                                                  textColor:
                                                                      AppColor
                                                                          .blackColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              Sizes
                                                                  .spaceWidth10,
                                                              TextConst(
                                                                text: datas
                                                                    .allPoint
                                                                    .toString(),
                                                                fontSize: Sizes
                                                                    .fontSizeOne,
                                                                textColor: AppColor
                                                                    .textGreyColor,
                                                              ),
                                                              const Spacer(),
                                                              TextConst(
                                                                text:
                                                                    "#${datas.ranks}",
                                                                width: Sizes
                                                                        .screenWidth /
                                                                    3,
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                fontSize: Sizes
                                                                    .fontSizeTwo,
                                                                textColor: AppColor
                                                                    .blackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ],
                                                          ),
                                                          data.matchstatus == 3
                                                              ? TextConst(
                                                                  text: datas.winningNote !=
                                                                          null
                                                                      ? datas
                                                                          .winningNote
                                                                          .toString()
                                                                      : '',
                                                                  fontSize: Sizes
                                                                      .fontSizeOne,
                                                                  textColor:
                                                                      AppColor
                                                                          .activeButtonGreenColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                )
                                                              : TextConst(
                                                                  text: datas.winingZone !=
                                                                              null &&
                                                                          datas.winingZone ==
                                                                              '1'
                                                                      ? 'Winning Zone'
                                                                      : '',
                                                                  fontSize: Sizes
                                                                      .fontSizeOne,
                                                                  textColor:
                                                                      AppColor
                                                                          .activeButtonGreenColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
            ],
          ),
          if (myContestItems.isNotEmpty &&
              myContestItems[0].matchstatus == 3 &&
              totalWinningContest != '0' &&
              !isAnimated)
            Lottie.asset(
              "assets/rive/confetti.json",
              onLoaded: (composition) {
                Future.delayed(composition.duration, () {
                  setState(() {
                    isAnimated = true;
                  });
                });
              },
            ),
        ],
      ),
    );
  }

  int? responseStatusCode;
  List<MyLiveContest> myContestItems = [];
  String? totalWinnings;
  String? totalWinningContest;
  Future<void> myContestApi() async {
    final userToken =
        Provider.of<SharedPrefViewModel>(context, listen: false).userToken;
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};
    final body = jsonEncode({
      "userid": userToken,
      "gameid": widget.data.gameId.toString(),
      "matchid": widget.data.id.toString(),
      "type": "2"
    });
    debugPrint('Request Body: $body');
    try {
      final response = await http.post(
        Uri.parse(AppApiUrls.getContestApiEndPoint),
        headers: headers,
        body: body,
      );

      debugPrint('API body: $body');
      debugPrint('API Endpoint: ${AppApiUrls.getContestApiEndPoint}');
      debugPrint('Response Status Code: ${response.statusCode}');
      setState(() {
        responseStatusCode = response.statusCode;
      });
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final List<dynamic> responseData = responseBody['mycontest'];
        totalWinnings = responseBody['total_winnings'].toString();
        totalWinningContest = responseBody['total_winning_contest'].toString();
        setState(() {
          myContestItems =
              responseData.map((item) => MyLiveContest.fromJson(item)).toList();
          isAnimated = false;
        });
      } else {
        setState(() {
          myContestItems = [];
        });
        if (response.statusCode == 400) {
          debugPrint('Data not found');
        } else {
          throw Exception(
              'Failed to load data. Status Code: ${response.statusCode}');
        }
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
    }
  }
}
