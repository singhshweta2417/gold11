
import 'package:flutter/material.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/drawer/drawer_screen.dart';

import '../generated/assets.dart';
import '../res/app_const.dart';
import '../res/color_const.dart';
import '../res/sizes_const.dart';
import 'const_widget/text_const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<dynamic> winnerList = [
    {
      "name": "Ashutosh Tripathi",
      "winAmount": "1 Crore",
      "message": "Trusting Dream 11 and my skills have finally paid off",
      "isVideoAvailable": false,
      "image": "https://randomuser.me/api/portraits/men/1.jpg",
      "match": "IND vs AUS"
    },
    {
      "name": "Ravi Kumar",
      "winAmount": "50 Lakh",
      "message": "This win is life-changing! Thank you Dream 11!",
      "isVideoAvailable": true,
      "image": "https://randomuser.me/api/portraits/men/2.jpg",
      "match": "ENG vs SA"
    },
    {
      "name": "Sneha Patel",
      "winAmount": "75 Lakh",
      "message": "I couldn't believe my luck, Dream 11 is amazing!",
      "isVideoAvailable": false,
      "image": "https://randomuser.me/api/portraits/women/3.jpg",
      "match": "WI vs PAK"
    },
    {
      "name": "Arjun Singh",
      "winAmount": "1.5 Crore",
      "message": "Hard work and Dream 11's platform made this possible.",
      "isVideoAvailable": true,
      "image": "https://randomuser.me/api/portraits/men/4.jpg",
      "match": "SL vs NZ"
    },
    {
      "name": "Neha Sharma",
      "winAmount": "60 Lakh",
      "message": "Dream 11 has made my dreams come true.",
      "isVideoAvailable": true,
      "image": "https://randomuser.me/api/portraits/women/5.jpg",
      "match": "BAN vs ZIM"
    },
    {
      "name": "Vikram Joshi",
      "winAmount": "80 Lakh",
      "message": "This win feels surreal, all thanks to Dream 11.",
      "isVideoAvailable": false,
      "image": "https://randomuser.me/api/portraits/men/6.jpg",
      "match": "IND vs ENG"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      key: scaffoldKey,
      drawer: const HomeScreenDrawer(),
      appBar: appBarDesign(),
      body: SingleChildScrollView(
        child: ContainerConst(
          child: Stack(
            children: [
              Column(
                children: [
                  ContainerConst(
                      height: Sizes.screenHeight / 3.5,
                      color: AppColor.blackColor,
                      gradient: AppColor.lightToDarkRedGradient,
                      width: Sizes.screenWidth),
                ],
              ),
              Column(
                children: [
                  Sizes.spaceHeight20,
                  upcomingMatchHeading(),
                  Sizes.spaceHeight25,
                  upcomingContest(),
                  howToPlayBanner(),
                  Sizes.spaceHeight25,
                  meetOurWinners(),
                  Sizes.spaceHeight20,
                  bottomSection()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBarDesign() {
    return AppBar(
      elevation: 0,
      // backgroundColor: AppColor.primaryRedColor,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: ContainerConst(
            color: AppColor.whiteColor,
            gradient: AppColor.lightToDarkRedGradient,
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    if (scaffoldKey.currentState!.isDrawerOpen) {
                      scaffoldKey.currentState!.closeDrawer();
                    } else {
                      scaffoldKey.currentState!.openDrawer();
                    }
                  },
                  icon: Stack(
                    children: [
                      ContainerConst(
                        shape: BoxShape.circle,
                        height: 40,
                        width: 40,
                        color: Colors.grey.shade300,
                        border:
                            Border.all(width: 2, color: AppColor.whiteColor),
                        child: const Icon(
                          Icons.person,
                          size: 30,
                          color: AppColor.textGreyColor,
                        ),
                      ),
                      Positioned(
                          bottom: -0,
                          right: -0,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.grey.shade100,
                            child: const Icon(
                              Icons.menu,
                              size: 10,
                              color: AppColor.textGreyColor,
                            ),
                          ))
                    ],
                  ),
                ),
                appLogoWithName(),
                Sizes.spaceWidth25,
              ],
            ),
          )),
    );
  }

  Widget upcomingMatchHeading() {
    return ContainerConst(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ContainerConst(
              width: Sizes.screenWidth / 7,
              height: 2,
              gradient: LinearGradient(colors: [
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.5),
                AppColor.whiteColor
              ], begin: Alignment.topLeft, end: FractionalOffset.centerRight),
              color: Colors.blue),
          Sizes.spaceWidth5,
          TextConst(
            text: AppLocalizations.of(context)!.upcomingMatch.toUpperCase(),
            textColor: AppColor.whiteColor,
            fontSize: Sizes.fontSizeThree / 1.2,
            fontWeight: FontWeight.bold,
          ),
          Sizes.spaceWidth5,
          ContainerConst(
              width: Sizes.screenWidth / 7,
              height: 2,
              gradient: LinearGradient(colors: [
                AppColor.whiteColor,
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.3),
              ], begin: Alignment.centerLeft, end: FractionalOffset.topRight),
              color: Colors.blue),
        ],
      ),
    );
  }

  Widget upcomingContest() {
    return ContainerConst(
      borderRadius: BorderRadius.circular(15),
      // height: Sizes.screenHeight/3,
      color: AppColor.whiteColor,
      width: Sizes.screenWidth / 1.1,
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          ContainerConst(
              padding: const EdgeInsets.symmetric(vertical: 5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Colors.grey.shade100,
              child: TextConst(
                text: "${AppLocalizations.of(context)!.worldCup} 2024",
                textColor: AppColor.textGreyColor,
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const ContainerConst(
                          shape: BoxShape.circle,
                          width: 45,
                          height: 45,
                          color: Colors.red,
                        ),
                        Sizes.spaceWidth5,
                        TextConst(
                          text: "Ind".toUpperCase(),
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                    Sizes.spaceHeight5,
                    TextConst(
                      text: "India",
                      textColor: AppColor.textGreyColor,
                      fontSize: Sizes.fontSizeOne,
                    )
                  ],
                ),
                Column(
                  children: [
                    TextConst(
                      text: AppLocalizations.of(context)!.matchStartIn,
                      fontSize: Sizes.fontSizeZero,
                    ),
                    Sizes.spaceHeight5,
                    ContainerConst(
                      width: 60,
                      color: AppColor.primaryRedColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                      child: const TextConst(
                        text: "31h",
                        textColor: AppColor.primaryRedColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        TextConst(
                          text: "Eng".toUpperCase(),
                          fontWeight: FontWeight.bold,
                        ),
                        Sizes.spaceWidth5,
                        const ContainerConst(
                          shape: BoxShape.circle,
                          width: 45,
                          height: 45,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    Sizes.spaceHeight5,
                    TextConst(
                      text: "England",
                      textColor: AppColor.textGreyColor,
                      fontSize: Sizes.fontSizeOne,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: ContainerConst(
              padding: const EdgeInsets.all(10),
              border: Border.all(color: Colors.grey.shade200, width: 1.5),
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextConst(
                            text: AppLocalizations.of(context)!.prizePool,
                            alignment: FractionalOffset.centerLeft,
                          ),
                          TextConst(
                            text: "₹50 Crores",
                            fontSize: Sizes.fontSizeThree,
                            fontWeight: FontWeight.w600,
                            alignment: FractionalOffset.centerLeft,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextConst(
                            text: AppLocalizations.of(context)!.firstPrize,
                            alignment: FractionalOffset.centerLeft,
                          ),
                          TextConst(
                            text: "₹2 Crores",
                            fontSize: Sizes.fontSizeThree,
                            fontWeight: FontWeight.w600,
                            alignment: FractionalOffset.centerLeft,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const LinearProgressIndicator(
                    value: 5,
                    minHeight: 5,
                    backgroundColor: Colors.grey,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColor.primaryRedColor),
                  ),
                  Sizes.spaceHeight5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextConst(
                        text: "1,16,05,031 spots left",
                        fontSize: Sizes.fontSizeZero,
                      ),
                      TextConst(
                        text: "1,19,36,022 spots",
                        fontSize: Sizes.fontSizeZero,
                      ),
                    ],
                  ),
                  Sizes.spaceHeight15,
                  ContainerConst(
                      width: Sizes.screenWidth / 1.3,
                      height: 1,
                      color: AppColor.whiteColor,
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey.shade50,
                          Colors.grey.shade200,
                          Colors.grey.shade300,
                          Colors.grey.shade200,
                          Colors.grey.shade50,
                        ],
                      )),
                  Sizes.spaceHeight15,
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        AppColor.textGoldenColor.withOpacity(0.2),
                        AppColor.whiteColor,
                        AppColor.whiteColor,
                        AppColor.whiteColor,
                        AppColor.whiteColor
                      ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          children: [
                            TextConst(
                              text: "Join for",
                            ),
                            TextConst(
                              text: "₹1 Only",
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        ButtonConst(
                          width: Sizes.screenWidth / 2,
                          label: AppLocalizations.of(context)!
                              .joinNow
                              .toUpperCase(),
                          color: AppColor.activeButtonGreenColor,
                          textColor: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          viewAllContestButton(),
          allUpcomingMatchesButton()
        ],
      ),
    );
  }

  Widget viewAllContestButton() {
    return ContainerConst(
        width: Sizes.screenWidth / 2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(Sizes.screenWidth / 2, 40),
              painter: TrapezoidPainter(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextConst(
                  text: AppLocalizations.of(context)!.viewAllContest,
                  textColor: AppColor.textGreyColor,
                ),
                const Icon(
                  Icons.navigate_next,
                  size: 20,
                )
              ],
            ),
          ],
        ));
  }

  Widget allUpcomingMatchesButton() {
    return ContainerConst(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(1, 0),
            spreadRadius: 2,
            blurRadius: 2),
      ],
      borderRadius: BorderRadius.circular(10),
      border: Border(
          top: BorderSide(
              width: 0.5, color: AppColor.primaryRedColor.withOpacity(0.2))),
      color: AppColor.whiteColor,
      child: ListTile(
        leading: const Icon(Icons.gamepad),
        title: TextConst(
          text: AppLocalizations.of(context)!.allUpcomingMatch,
          fontWeight: FontWeight.w600,
          alignment: FractionalOffset.centerLeft,
        ),
        subtitle: TextConst(
          text: "Cricket, football, kabaddi,and more",
          fontSize: Sizes.fontSizeOne,
          alignment: FractionalOffset.centerLeft,
        ),
        trailing: const Icon(Icons.navigate_next),
      ),
    );
  }

  Widget howToPlayBanner() {
    return ContainerConst(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      color: Colors.grey.shade100,
      child: Image.asset(Assets.assetsHowToPlayBanner),
    );
  }

  Widget meetOurWinners() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContainerConst(
                width: Sizes.screenWidth / 7,
                height: 1.5,
                gradient: LinearGradient(colors: [
                  Colors.grey.shade50.withOpacity(0.3),
                  Colors.grey.shade200.withOpacity(0.8),
                ], begin: Alignment.topLeft, end: FractionalOffset.centerRight),
                color: Colors.blue),
            Sizes.spaceWidth5,
            TextConst(
              text: AppLocalizations.of(context)!.meetOurWinners.toUpperCase(),
              textColor: AppColor.blackColor,
              fontSize: Sizes.fontSizeThree / 1.2,
              fontWeight: FontWeight.bold,
            ),
            Sizes.spaceWidth5,
            ContainerConst(
                width: Sizes.screenWidth / 7,
                height: 1.5,
                gradient: LinearGradient(colors: [
                  Colors.grey.shade200.withOpacity(0.8),
                  Colors.grey.shade50.withOpacity(0.3),
                ], begin: Alignment.centerLeft, end: FractionalOffset.topRight),
                color: Colors.blue),
          ],
        ),
        Sizes.spaceHeight15,
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  winnerList.length, (i) => winnerBoardDesign(winnerList[i])),
            )),
        Sizes.spaceHeight15,
      ],
    );
  }

  Widget winnerBoardDesign(dynamic winnerData) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ContainerConst(
          margin: const EdgeInsets.only(top: 25, left: 10, right: 10),
          borderRadius: BorderRadius.circular(15),
          color: AppColor.whiteColor,
          gradient: LinearGradient(colors: [
            AppColor.primaryRedColor.withOpacity(0.5),
            Colors.grey.shade200,
            Colors.grey.shade200
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          width: Sizes.screenWidth / 1.5,
          height: Sizes.screenWidth / 2.1,
          padding: const EdgeInsets.all(2),
          child: ContainerConst(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2, color: AppColor.whiteColor),
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ContainerConst(
                  padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  color: AppColor.whiteColor,
                  alignment: FractionalOffset.centerRight,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  gradient: LinearGradient(colors: [
                    AppColor.primaryRedColor.withOpacity(0.1),
                    AppColor.primaryRedColor.withOpacity(0.2),
                    AppColor.primaryRedColor.withOpacity(0.3)
                  ]),
                  child: TextConst(
                    text: winnerData["match"],
                    alignment: FractionalOffset.centerRight,
                    fontSize: Sizes.fontSizeOne,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Sizes.spaceHeight25,
                TextConst(
                  padding: const EdgeInsets.only(top: 5),
                  text: winnerData["name"],
                  fontWeight: FontWeight.w600,
                ),
                Sizes.spaceHeight5,
                ContainerConst(
                  width: Sizes.screenWidth / 2,
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  color: AppColor.whiteColor,
                  gradient: LinearGradient(colors: [
                    AppColor.primaryRedColor.withOpacity(0.0),
                    AppColor.primaryRedColor.withOpacity(0.1),
                    AppColor.primaryRedColor.withOpacity(0.2),
                    AppColor.primaryRedColor.withOpacity(0.1),
                    AppColor.primaryRedColor.withOpacity(0.0),
                  ]),
                  child: TextConst(
                    text: winnerData["winAmount"],
                  ),
                ),
                Sizes.spaceHeight10,
                TextConst(
                  text: winnerData["message"],
                  maxLines: winnerData["isVideoAvailable"] ? 1 : null,
                  textColor: AppColor.textGreyColor,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  textAlign: TextAlign.center,
                ),
                Sizes.spaceHeight5,
                winnerData["isVideoAvailable"]
                    ? ButtonConst(
                        icon: Icons.play_circle,
                        iconColor: AppColor.primaryRedColor,
                        width: Sizes.screenWidth / 2.8,
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.red.shade50,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              offset: const Offset(1, 0),
                              spreadRadius: 2,
                              blurRadius: 3),
                        ],
                        height: 30,
                        border: Border.all(
                            width: 0.5,
                            color: AppColor.primaryRedColor.withOpacity(0.4)),
                        label: AppLocalizations.of(context)!
                            .watchNow
                            .toUpperCase(),
                        fontWeight: FontWeight.w600,
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
        ContainerConst(
          shape: BoxShape.circle,
          height: Sizes.screenWidth / 5,
          width: Sizes.screenWidth / 5,
          border: Border.all(color: AppColor.whiteColor, width: 2),
          color: Colors.blue,
          image: DecorationImage(image: NetworkImage(winnerData["image"])),
        )
      ],
    );
  }

  Widget bottomSection() {
    return ContainerConst(
      color: AppColor.whiteColor,
      gradient: LinearGradient(
          colors: [Colors.grey.shade50, Colors.grey.shade300],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          ListTile(
            leading: ContainerConst(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(3),
              image: const DecorationImage(
                  image: AssetImage(Assets.iconsStadium),
                  fit: BoxFit.fitHeight),
              border: Border.all(color: Colors.grey.shade500),
              width: 60,
            ),
            title: TextConst(
              text: "6+ Sports",
              fontWeight: FontWeight.bold,
              fontSize: Sizes.fontSizeThree,
              alignment: FractionalOffset.centerLeft,
            ),
            subtitle: const TextConst(
              text: "Cricket, football, kabaddi and more",
              textColor: AppColor.textGreyColor,
              alignment: FractionalOffset.centerLeft,
            ),
          ),
          ListTile(
            leading: ContainerConst(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.all(3),
                image: const DecorationImage(
                    image: AssetImage(Assets.iconsMoneyPouch),
                    fit: BoxFit.fitHeight),
                width: 60,
                border: Border.all(color: Colors.grey.shade500)),
            title: TextConst(
              text: "500+ Crorepatis",
              fontWeight: FontWeight.bold,
              fontSize: Sizes.fontSizeThree,
              alignment: FractionalOffset.centerLeft,
            ),
            subtitle: const TextConst(
              text: "From all over India",
              textColor: AppColor.textGreyColor,
              alignment: FractionalOffset.centerLeft,
            ),
          ),
          Sizes.spaceHeight15,
          TextConst(
            text: "For the Fans, By the Fans",
            textColor: AppColor.textGreyColor,
            fontSize: Sizes.fontSizeLarge,
            fontWeight: FontWeight.bold,
            alignment: FractionalOffset.centerLeft,
            padding: const EdgeInsets.only(left: 25),
          ),
        ],
      ),
    );
  }

  Widget appLogoWithName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.assetsSplashLogo,
          width: Sizes.screenWidth / 12,
        ),
        Sizes.spaceWidth5,
        TextConst(
          text: AppConstants.appName,
          fontSize: Sizes.fontSizeThree,
          fontWeight: FontWeight.bold,
          textColor: AppColor.whiteColor,
        ),
        Sizes.spaceWidth20
      ],
    );
  }
}

class TrapezoidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..color = Colors.grey.shade100;

    Path path = Path();
    path.moveTo(size.width * 0.1, size.height); // bottom-left corner
    path.lineTo(size.width * 0.9, size.height); // bottom-right corner
    path.lineTo(size.width, 0); // top-right corner
    path.lineTo(0, 0); // top-left corner
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
