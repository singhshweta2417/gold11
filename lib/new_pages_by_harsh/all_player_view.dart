import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gold11/new_pages_by_harsh/model/all_player_info_model.dart';
import 'package:gold11/res/app_url_const.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:http/http.dart' as http;
import 'package:gold11/view_model/game_view_model.dart';
import 'package:provider/provider.dart';

class AllPlayerView extends StatefulWidget {
  final String matchId;
  final String playerId;
  final String teamId;
  final String matchType;

  const AllPlayerView({
    super.key,
    required this.matchId,
    required this.playerId,
    required this.teamId,
    required this.matchType,
  });

  @override
  State<AllPlayerView> createState() => _AllPlayerViewState();
}

class _AllPlayerViewState extends State<AllPlayerView> {
  late PageController _pageController;
  List<AllPlayerInfoModel> playerInfoDetail = [];
  int? responseStatusCode;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    playerInfo();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> playerInfo() async {
    final matchId = widget.matchId;
    final playerId = widget.playerId;
    final gameID =
        Provider.of<GameViewModel>(context, listen: false).selectedGameTypeId;
    final matchType =  widget.matchType;
    final teamID =matchType=='3'? widget.teamId:'';

    final headers = {"Content-Type": "application/json; charset=UTF-8"};
    final body = json.encode({
      "type": matchType.toString(),
      "matchid": matchId.toString(),
      "gameid": gameID.toString(),
      "playerid": playerId.toString(),
      "teamid": teamID.toString(),

    });
    try {
      final response = await http.post(
        Uri.parse(AppApiUrls.allPlayerInfo),
        headers: headers,
        body: body,
      );
      setState(() {
        responseStatusCode = response.statusCode;
      });

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body)['data']['playerindex'];
        final List<dynamic> responseData =
        json.decode(response.body)['data']['record'];

        setState(() {
          playerInfoDetail = responseData
              .map((item) => AllPlayerInfoModel.fromJson(item))
              .toList();
          _pageController = PageController(
              initialPage: responseBody, viewportFraction: 0.9);
        });
      } else if (response.statusCode == 400) {
        setState(() {
          playerInfoDetail = [];
        });
        if (kDebugMode) {
          print('Data not found');
        }
      } else {
        throw Exception(
            'Failed to load data with status code ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.blackColor,
        leadingWidth: 300,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: AppColor.whiteColor),
            ),
            const TextConst(
              textAlign: TextAlign.start,
              text: "Player Info",
              textColor: AppColor.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ContainerConst(
              height: Sizes.screenHeight * 0.07,
              width: Sizes.screenWidth * 0.07,
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.whiteColor, width: 2),
              child: TextConst(
                text: "PTS",
                textColor: AppColor.whiteColor,
                fontWeight: FontWeight.w500,
                fontSize: Sizes.fontSizeOne,
              ),
            ),
          ),
        ],
      ),
      body: playerInfoDetail.isEmpty
          ? Center(
        child: responseStatusCode == null
            ? const CircularProgressIndicator()
            : const TextConst(
          text: "No data available",
          textColor: AppColor.textGreyColor,
        ),
      )
          : PageView.builder(
            controller: _pageController,
            itemCount: playerInfoDetail.length,
            itemBuilder: (context, index) {
              final data = playerInfoDetail[index];
              return Container(
                margin: const EdgeInsets.symmetric(
                   horizontal: 5, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    playerInfoHeader(data),
                    playerInfoDetails(data),
                    Expanded(
                      child: playerEventList(data),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }

  Widget playerInfoHeader(AllPlayerInfoModel data) {
    return ContainerConst(
      height: Sizes.screenHeight * 0.1,
      color: Colors.black,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CachedNetworkImage(
            imageUrl: data.playerImage.toString(),
            imageBuilder: (context, imageProvider) => Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
               // shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.error),
            ),
          ),
          columnWithTitle(
              "Selected By",
              data.selectedBy == null ? 'N/A' : '${data.selectedBy}%'),
          columnWithTitle("Credits",
              data.creditPoints == null ? 'N/A' : data.creditPoints.toString()),
          columnWithTitle("Points",
              data.totalPoint == null ? 'N/A' : data.totalPoint.toString()),
        ],
      ),
    );
  }

  Widget columnWithTitle(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Sizes.spaceHeight25,
        TextConst(
          text: title,
          textColor: Colors.grey,
          fontSize: Sizes.fontSizeOne,
        ),
        TextConst(
          text: value,
          textColor: Colors.grey,
          fontSize: Sizes.fontSizeThree,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }

  Widget playerInfoDetails(AllPlayerInfoModel data) {
    return Column(
      children: [
        Sizes.spaceHeight10,
        TextConst(
          text: data.playerName ?? 'N/A',
          fontWeight: FontWeight.bold,
          fontSize: Sizes.fontSizeThree,
          textAlign: TextAlign.start,
        ),
        Sizes.spaceHeight5,
        Divider(color: AppColor.scaffoldBackgroundColor),
      ],
    );
  }

  Widget playerEventList(AllPlayerInfoModel data) {
    return ListView.builder(
      itemCount: data.eventData?.length ?? 0,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final subData = data.eventData![index];
        return Container(
          height: Sizes.screenHeight * 0.05,
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColor.scaffoldBackgroundColor),
            ),
          ),
          child: Row(
            children: [
              TextConst(
                text: subData.event.toString(),
                fontSize: Sizes.fontSizeOne,
                fontWeight: FontWeight.w400,
                alignment: Alignment.centerLeft,
                width: Sizes.screenWidth * 0.3,
              ),
              TextConst(
                text: subData.points.toString(),
                fontSize: Sizes.fontSizeOne,
                fontWeight: FontWeight.w400,
                width: Sizes.screenWidth * 0.1,
              ),
              TextConst(
                text: subData.actual.toString(),
                fontSize: Sizes.fontSizeOne,
                fontWeight: FontWeight.w400,
                alignment: Alignment.centerRight,
                width: Sizes.screenWidth * 0.3,
              ),
            ],
          ),
        );
      },
    );
  }
}
