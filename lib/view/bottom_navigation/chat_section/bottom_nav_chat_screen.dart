import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold11/generated/assets.dart';

import '../../../res/color_const.dart';
import '../../../res/sizes_const.dart';
import '../../const_widget/container_const.dart';
import '../../const_widget/text_const.dart';
import '../../widgets/circular_profile_image_widget.dart';

class BottomNavChatScreen extends StatefulWidget {
  const BottomNavChatScreen({super.key});

  @override
  State<BottomNavChatScreen> createState() => _BottomNavChatScreenState();
}

class _BottomNavChatScreenState extends State<BottomNavChatScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      key: scaffoldKey,
      appBar: appBarWidget(),
      body: ContainerConst(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              leaderBoardChatDesign(),
              Sizes.spaceHeight15,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextConst(text: "Suggested People", fontWeight: FontWeight.w600,),
                  TextConst(text: "View all"),
                ],
              ),
              Sizes.spaceHeight15,
              findContactButton(),
              Sizes.spaceHeight25,
              messageContacts()
            ],
          )),
    );
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      backgroundColor: AppColor.primaryRedColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 0,
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
                    CircularProfileImageWidget(onPressed: (){
                      if (scaffoldKey.currentState!.isDrawerOpen) {
                        scaffoldKey.currentState!.closeDrawer();
                      } else {
                        scaffoldKey.currentState!.openDrawer();
                      }
                    },),
                    Sizes.spaceWidth10,
                    appBarTitle(),
                    const Spacer(),
                    appBarActionForChatScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarActionForChatScreen() {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.info_outline,
          color: AppColor.whiteColor,
        ));
  }

  Widget appBarTitle() {
    return TextConst(
      text: "Chat",
      textColor: AppColor.whiteColor,
      fontSize: Sizes.fontSizeLarge / 1.25,
      alignment: FractionalOffset.centerLeft,
      fontWeight: FontWeight.w600,
    );
  }

  Widget leaderBoardChatDesign() {
    final leaderBoardChatList = [
      {
        "name": "Rjn@8381",
        "subtitle": "Ajay kumar: hii",
        "date": "15/06/2024",
        "msg_count": "48",
        "status": false
      },
      {
        "name": "Ashu@8381",
        "subtitle": "Ashutosh: hello",
        "date": "20/06/2024",
        "msg_count": "13",
        "status": false
      },
    ];
    return ListView.builder(
        shrinkWrap: true,
        itemCount: leaderBoardChatList.length,
        itemBuilder: (context, int i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ContainerConst(
              padding: const EdgeInsets.all(2),
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  AppColor.scaffoldBackgroundColor,
                  AppColor.scaffoldBackgroundColor,
                  AppColor.primaryRedColor.withOpacity(0.1)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              child: ContainerConst(
                color: AppColor.whiteColor,
                padding: const EdgeInsets.all(10),
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const ContainerConst(
                          width: 40,
                          height: 40,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(Assets.assetsSplashLogo)),
                          color: AppColor.primaryRedColor,
                        ),
                        Sizes.spaceWidth15,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextConst(
                              text: leaderBoardChatList[i]["name"].toString(),
                              fontWeight: FontWeight.w600,
                              alignment: Alignment.centerLeft,
                            ),
                            TextConst(
                              text:
                                  leaderBoardChatList[i]["subtitle"].toString(),
                              fontSize: Sizes.fontSizeOne,
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ContainerConst(
                              width: 20,
                              height: 20,
                              shape: BoxShape.circle,
                              color: AppColor.primaryRedColor,
                              padding: const EdgeInsets.all(3),
                              child: TextConst(
                                text: leaderBoardChatList[i]["msg_count"]
                                    .toString(),
                                fontSize: Sizes.fontSizeZero,
                                textColor: AppColor.whiteColor,
                              ),
                            ),
                            Sizes.spaceHeight5,
                            TextConst(
                              text: leaderBoardChatList[i]["date"].toString(),
                              fontSize: Sizes.fontSizeZero,
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Sizes.spaceHeight20,
                    ContainerConst(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(colors: [
                        Colors.grey.shade50,
                        Colors.grey.shade100,
                        Colors.grey.shade200
                      ]),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const TextConst(
                        text: "No active leaderboard",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget findContactButton() {
    return ContainerConst(
      width: Sizes.screenWidth,
      color: AppColor.whiteColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColor.scaffoldBackgroundColor, width: 2),
      child: ListTile(
        leading: const Icon(Icons.group),
        title: TextConst(
          text: "Find your contacts who play on Dream11",
          fontSize: Sizes.fontSizeOne,
          width: Sizes.screenWidth,
          alignment: Alignment.centerLeft,
        ),
        trailing: const Icon(Icons.navigate_next),
      ),
    );
  }

  Widget messageContacts() {
    return ListTile(
      leading: const ContainerConst(
        width: 40,
        height: 40,
        shape: BoxShape.circle,
        image: DecorationImage(image: AssetImage(Assets.assetsSplashLogo)),
        color: AppColor.primaryRedColor,
      ),
      title: const TextConst(
        text: "Ashutosh Tripathi",
        alignment: Alignment.centerLeft,
      ),
      subtitle: TextConst(
        text: "Skill Score: 525",
        alignment: Alignment.centerLeft,
        fontSize: Sizes.fontSizeOne,
      ),
      trailing: ContainerConst(
        color: AppColor.whiteColor,
        height: 35  ,
        width: Sizes.screenWidth / 4,
        border: Border.all(color: AppColor.scaffoldBackgroundColor, width: 2),
        borderRadius: BorderRadius.circular(10),
        child: TextConst(
          text: "message".toUpperCase(),
        ),
      ),
    );
  }
}
