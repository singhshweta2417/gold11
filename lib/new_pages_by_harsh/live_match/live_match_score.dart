import 'package:flutter/material.dart';
import 'package:gold11/model/game_data_model.dart';
import 'package:gold11/new_pages_by_harsh/live_match/live_data_formate.dart';
import 'package:gold11/new_pages_by_harsh/my_match_complete/complete_match_score.dart';
import 'package:gold11/new_pages_by_harsh/web_socket_api.dart';
import 'package:gold11/res/app_url_const.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/doted_border.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';

class LiveMatchScore extends StatefulWidget {
  final GameData data;
  const LiveMatchScore({super.key, required this.data});

  @override
  State<LiveMatchScore> createState() => _LiveMatchScoreState();
}

class _LiveMatchScoreState extends State<LiveMatchScore> {
  late WebSocketService _webSocketService;
  dynamic _socketData;

  @override
  void initState() {
    super.initState();
    _webSocketService = WebSocketService();
    _webSocketService.connect(
      '${AppApiUrls.liveMatchSocket}${widget.data.sportsMonkMatchId}',
          (data) {
        setState(() {
          _socketData = data;
        });
      },
    );
  }

  @override
  void dispose() {
    _webSocketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      widget.data.status == 3 ?
      CompleteMatchScore(data:widget.data):
      Container(
        color: AppColor.blackColor,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: _socketData == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextConst(
                    text: widget.data.homeTeamName ?? "",
                    textColor: AppColor.whiteColor,
                    fontSize: 12,
                    alignment: FractionalOffset.centerLeft,
                    fontWeight: FontWeight.w400,
                  ),
                  TextConst(
                    text: widget.data.visitorTeamName ?? "",
                    textColor: AppColor.whiteColor,
                    fontSize: 12,
                    alignment: FractionalOffset.centerLeft,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ContainerConst(
                        shape: BoxShape.circle,
                        width: 30,
                        height: 30,
                        image: DecorationImage(
                          image:
                          NetworkImage(widget.data.homeTeamImage ?? ""),
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(
                        width: 5,
                      ),
                      _socketData['home_team_over']=='0.0'
                          ?const TextConst(
                        text: "Yet to bat",
                        textColor: Colors.white,
                        fontSize: 14,
                        alignment: FractionalOffset.centerLeft,
                        fontWeight: FontWeight.w700,
                      ):
                      Row(
                        children: [
                          TextConst(
                            text:
                            "${_socketData['home_team_score']?? "0"}/${_socketData['home_team_wicket'] ?? "0"}",
                            textColor: Colors.white70,
                            fontSize: 16,
                            alignment: FractionalOffset.centerLeft,
                            fontWeight: FontWeight.w800,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TextConst(
                            text: "(${_socketData['home_team_over']?? "0"})",
                            textColor: Colors.white,
                            fontSize: 12,
                            alignment: FractionalOffset.centerLeft,
                            fontWeight: FontWeight.w200,
                          ),
                        ],
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      _socketData['visitor_team_over']=='0.0'?
                      const TextConst(
                        text: "Yet to bat",
                        textColor: Colors.white,
                        fontSize: 14,
                        alignment: FractionalOffset.centerLeft,
                        fontWeight: FontWeight.w700,
                      ):
                      Row(
                        children: [
                          TextConst(
                            text: "(${_socketData['visitor_team_over'] ?? "0"})",
                            textColor: Colors.white70,
                            fontSize: 12,
                            alignment: FractionalOffset.centerLeft,
                            fontWeight: FontWeight.w200,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TextConst(
                            text:
                            "${_socketData['visitor_team_score'] ?? "0"}/${_socketData['visitor_team_wicket'] ?? "0"}",
                            textColor: Colors.white70,
                            fontSize: 16,
                            alignment: FractionalOffset.centerLeft,
                            fontWeight: FontWeight.w800,
                          ),
                        ],
                      ),

                      const SizedBox(
                        width: 5,
                      ),
                      ContainerConst(
                        shape: BoxShape.circle,
                        width: 30,
                        height: 30,
                        image: DecorationImage(
                          image: NetworkImage(
                              widget.data.visitorTeamImage ?? ""),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              ContainerConst(
                width: 55,
                color: AppColor.primaryRedColor.withOpacity(0.1),
                child: const TextConst(
                  text: "• Live",
                  textColor: AppColor.primaryRedColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Column(
                children: [
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Sizes.screenWidth*0.43,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextConst(
                              text: getBatsmanData(_socketData, 'batter1', 'batsman_data'),
                              textColor: AppColor.whiteColor,
                              fontSize: 10,
                              alignment: FractionalOffset.centerLeft,
                              fontWeight: FontWeight.w700,
                              width: 60,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            TextConst(
                              text:
                              '${getBatsmanData(_socketData, 'batter1_score', 'batsman_data')}/(${getBatsmanData(_socketData, 'batter1_faced_ball', 'batsman_data')})',
                              textColor: AppColor.whiteColor,
                              fontSize: 12,
                              alignment: FractionalOffset.centerLeft,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      TextConst(
                        text: getBatsmanData(
                            _socketData, 'bowler', 'bowler_data'),
                        textColor: AppColor.whiteColor,
                        fontSize: 12,
                        alignment: FractionalOffset.centerLeft,
                        fontWeight: FontWeight.w700,
                        width: 50,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      TextConst(
                        text:
                        "${getBatsmanData(_socketData, 'bowler_wicket', 'bowler_data')}/${getBatsmanData(_socketData, 'bowler_run', 'bowler_data')}(${getBatsmanData(_socketData, 'bowler_overs', 'bowler_data')})",
                        textColor: AppColor.whiteColor,
                        fontSize: 12,
                        alignment: FractionalOffset.centerLeft,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          width: Sizes.screenWidth * 0.43,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              TextConst(
                                text: getBatsmanData(
                                    _socketData, 'batter2', 'batsman_data'),
                                textColor: AppColor.whiteColor,
                                fontSize: 12,
                                alignment: FractionalOffset.centerLeft,
                                fontWeight: FontWeight.w400,
                                width: 50,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              TextConst(
                                text:
                                '${getBatsmanData(_socketData, 'batter2_score', 'batsman_data')}/(${getBatsmanData(_socketData, 'batter2_faced_ball', 'batsman_data')})',
                                textColor: AppColor.whiteColor,
                                fontSize: 12,
                                alignment: FractionalOffset.centerLeft,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Sizes.screenWidth * 0.47,
                        height: 30,
                        child:
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          // itemCount: _socketData['balls'].length>6?_socketData['balls'].length:6,
                          itemCount: (_socketData['balls']?.length ?? 0) > 6
                              ? _socketData['balls']!.length
                              : 6,
                          itemBuilder: (context, index) {
                            // if (index < _socketData['balls'].length)
                            if (_socketData['balls'] != null && index < _socketData['balls']!.length)
                            {
                              final ballData = _socketData['balls'][index]['scores'];
                              final colorCodeString = _socketData['balls'][index]['color_code'];
                              final colorTextString = _socketData['balls'][index]['text_color'];
                              final sanitizedColorCode = colorCodeString.startsWith('0x')
                                  ? colorCodeString.substring(2)
                                  : colorCodeString;
                              final sanitizedColorText = colorTextString.startsWith('0x')
                                  ? colorTextString.substring(2)
                                  : colorTextString;
                              final Color ballColor = Color(int.parse(sanitizedColorCode, radix: 16));
                              final Color ballTextColor = Color(int.parse(sanitizedColorText, radix: 16));
                              return Container(
                                margin: const EdgeInsets.all(2.0),
                                height: ballData.toString().length > 1 ? 35.0 : 25.0,
                                width: ballData.toString().length > 1 ? 35.0 : 25.0,
                                decoration: BoxDecoration(
                                  color: ballColor,
                                  shape: ballData.toString().length > 1
                                      ? BoxShape.rectangle
                                      : BoxShape.circle,
                                  borderRadius: ballData.toString().length > 1
                                      ? BorderRadius.circular(20.0)
                                      : null,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: TextConst(
                                      text: ballData.toString(),
                                      textColor: ballTextColor,
                                      fontSize: 10,
                                      alignment: FractionalOffset.center,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: CustomPaint(
                                  size: const Size(2.0, 3.0),
                                  painter: DottedBorderPainter(),
                                  child: Container(
                                    height: 18,
                                    width: 18,
                                    margin: const EdgeInsets.all(2.0),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
  }
}