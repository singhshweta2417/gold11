import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gold11/model/game_data_model.dart';
import 'package:gold11/new_pages_by_harsh/live_match/live_team_preview.dart';
import 'package:gold11/new_pages_by_harsh/model/live_my_constant.dart';
import 'package:gold11/new_pages_by_harsh/model/my_contest_leader_board.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/app_url_const.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MyContestLeaderBoard extends StatefulWidget {
  final GameData data;
  final MyLiveContest MyLiveContestdata;
  const MyContestLeaderBoard(
      {super.key, required this.data, required this.MyLiveContestdata});

  @override
  State<MyContestLeaderBoard> createState() => _MyContestLeaderBoardState();
}

class _MyContestLeaderBoardState extends State<MyContestLeaderBoard> {
  List<MyContestLeaderBoardModel> matchingUserItems = [];
  List<MyContestLeaderBoardModel> otherUserItems = [];

  @override
  void initState() {
    super.initState();
    myContestLeaderBoardApi();
  }

  Future<void> _refreshMatches() async {
    myContestLeaderBoardApi();
  }

  @override
  Widget build(BuildContext context) {
    return matchingUserItems.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            color: Colors.white,
            backgroundColor: AppColor.primaryRedColor,
            strokeWidth: 4.0,
            onRefresh: _refreshMatches,
            child: ListView(
              shrinkWrap: true,
              children: [
                if (matchingUserItems.isNotEmpty) ...[
                  _buildLeaderBoardList(
                      matchingUserItems, AppColor.scaffoldBackgroundColorTwo),
                ],
                if (otherUserItems.isNotEmpty) ...[
                  _buildLeaderBoardList(otherUserItems, AppColor.whiteColor),
                ],
              ],
            ),
          );
  }

  Widget _buildLeaderBoardList(
      List<MyContestLeaderBoardModel> items, Color colors) {
    return items.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              final data = items[index];
              return InkWell(
                onTap: () {
                  final userToken =
                      Provider.of<SharedPrefViewModel>(context, listen: false)
                          .userToken;
                  if (data.matchstatus == 2 || data.matchstatus == 3) {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (_) {
                          return LiveTeamPreview(
                            type: 1,
                            data2: data,
                            data: null,
                            data3: null,
                            data4: null,
                          );
                        });
                  } else {
                    if (userToken.toString() != data.userid.toString()) {
                      Utils.showErrorMessage(context,
                          'Please wait till the match starts to view other teams');
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LiveTeamPreview(
                                  type: 1,
                                  data2: data,
                                  data: null,
                                  data3: null,
                                  data4: null,
                                )),
                      );
                    }
                  }
                },
                child: Container(
                  color: colors,
                  child: _buildLeaderBoardItem(data),
                ),
              );
            },
          );
  }

  Widget _buildLeaderBoardItem(MyContestLeaderBoardModel data) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Sizes.screenWidth * 0.52,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: data.userimage != null
                          ? NetworkImage(data.userimage!)
                          : null,
                      radius: 20,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextConst(
                          width: 100,
                          alignment: Alignment.centerLeft,
                          text: data.username ?? 'Unknown User',
                          fontSize: Sizes.fontSizeTwo,
                          textColor: AppColor.blackColor,
                          fontWeight: FontWeight.w500,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        data.matchstatus == 3
                            ? TextConst(
                                text: data.winningNote != null
                                    ? data.winningNote.toString()
                                    : '',
                                fontSize: Sizes.fontSizeOne,
                                textColor: AppColor.activeButtonGreenColor,
                                fontWeight: FontWeight.w500,
                                alignment: Alignment.centerLeft,
                              )
                            : TextConst(
                                text: data.winingZone != null &&
                                        data.winingZone == "1"
                                    ? "Winning Zone"
                                    : '',
                                fontSize: Sizes.fontSizeOne,
                                textColor: AppColor.activeButtonGreenColor,
                                fontWeight: FontWeight.w500,
                                alignment: Alignment.centerLeft,
                              ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    ContainerConst(
                      width: 22,
                      height: 16,
                      borderRadius: BorderRadius.circular(2),
                      color: AppColor.scaffoldBackgroundColor,
                      child: TextConst(
                        text: data.teamName ?? 'No Team',
                        fontSize: Sizes.fontSizeOne,
                        textColor: AppColor.blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              TextConst(
                text: data.allPoint?.toString() ?? '0',
                fontSize: Sizes.fontSizeTwo,
                textColor: AppColor.textGreyColor,
                fontWeight: FontWeight.w500,
              ),
              TextConst(
                text: "#${data.ranks ?? 0}",
                fontSize: Sizes.fontSizeTwo,
                textColor: AppColor.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Future<void> myContestLeaderBoardApi() async {
    final userToken =
        Provider.of<SharedPrefViewModel>(context, listen: false).userToken;
    final teamId = widget.data.id.toString();
    final contestId = widget.MyLiveContestdata.contestId.toString();

    try {
      final response = await http.get(
        Uri.parse(
            '${AppApiUrls.getLiveMatchLeaderBoard}$teamId/$contestId/$userToken'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        final allItems = responseData
            .map((item) => MyContestLeaderBoardModel.fromJson(item))
            .toList();
        setState(() {
          matchingUserItems = allItems
              .where((item) => item.userid.toString() == userToken.toString())
              .toList();
          otherUserItems = allItems
              .where((item) => item.userid.toString() != userToken.toString())
              .toList();
        });
      } else {
        setState(() {
          matchingUserItems = [];
          otherUserItems = [];
        });
      }
    } catch (e) {
    }
  }
}
