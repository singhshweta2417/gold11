import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/view/team/team_preview_screen.dart';
import 'package:gold11/view/widgets/choose_c_vc_listing.dart';
import 'package:gold11/view_model/player_view_model.dart';
import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../../utils/route/app_routes.dart';
import '../const_widget/button_const.dart';
import '../const_widget/container_const.dart';
import '../const_widget/text_const.dart';

class ChooseCAndVCScreen extends StatefulWidget {
  final Map<String, dynamic>? args;
  const ChooseCAndVCScreen({super.key, this.args});

  @override
  State<ChooseCAndVCScreen> createState() => _ChooseCAndVCScreenState();
}

class _ChooseCAndVCScreenState extends State<ChooseCAndVCScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: const ChooseCAndVcFromSelectedPlayersListing(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionContent(),
    );
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      backgroundColor: AppColor.blackColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight * 2.99 + 16),
        child: Column(
          children: [
            ContainerConst(
              color: AppColor.whiteColor,
              gradient: const LinearGradient(
                  colors: [
                    Color(0xff6b0111),
                    AppColor.blackColor,
                    AppColor.blackColor
                  ],
                  begin: Alignment.centerLeft,
                  end: FractionalOffset.centerRight,
                  tileMode: TileMode.mirror),
              child: ContainerConst(
                height: kToolbarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    Sizes.spaceWidth10,
                    appBarTitle(),
                    const Spacer(),
                    appBarAction(),
                  ],
                ),
              ),
            ),
            Sizes.spaceHeight10,
            TextConst(
              text: "Choose your Captain and Vice Captain",
              fontSize: Sizes.fontSizeOne,
              textColor: Colors.grey.shade500,
            ),
            Sizes.spaceHeight10,
            Consumer<PlayerViewModel>(builder: (context, pvmCon, child) {
              return ContainerConst(
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: AppColor.whiteColor,
                gradient: LinearGradient(colors: [
                  AppColor.blackColor,
                  Colors.grey.shade900,
                  Colors.grey.shade800.withOpacity(0.6),
                  Colors.grey.shade800.withOpacity(0.6),
                  Colors.grey.shade900,
                  AppColor.blackColor
                ]),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContainerConst(
                      padding: const EdgeInsets.all(4),
                      border:
                          Border.all(color: Colors.grey.shade800, width: 1.5),
                      shape: BoxShape.circle,
                      child: TextConst(
                        width: 50,
                        text: "C",
                        textColor: Colors.grey.shade500,
                        fontSize: Sizes.fontSizeTwo,
                      ),
                    ),
                    SizedBox(
                      width: Sizes.screenWidth / 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextConst(
                            fontSize: Sizes.fontSizeOne,
                            alignment: Alignment.centerLeft,
                            text: pvmCon.captain != null
                                ? pvmCon.captain!.playerName ?? ""
                                : "Captain gets",
                            textColor: pvmCon.captain != null
                                ? AppColor.textGoldenColor
                                : Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Sizes.spaceHeight5,
                          TextConst(
                            fontSize: Sizes.fontSizeZero,
                            alignment: Alignment.centerLeft,
                            text: "2X (double) points",
                            textColor: Colors.grey.shade100,
                          ),
                        ],
                      ),
                    ),
                    Sizes.spaceWidth10,
                    ContainerConst(
                      width: 1,
                      color: Colors.grey.shade500,
                      height: 30,
                    ),
                    // Sizes.spaceWidth10,
                    ContainerConst(
                      padding: const EdgeInsets.all(2),
                      border:
                          Border.all(color: Colors.grey.shade800, width: 1.5),
                      shape: BoxShape.circle,
                      child: TextConst(
                        width: 50,
                        text: "VC",
                        textColor: Colors.grey.shade500,
                        fontSize: Sizes.fontSizeTwo,
                      ),
                    ),
                    SizedBox(
                      width: Sizes.screenWidth / 3.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextConst(
                            fontSize: Sizes.fontSizeOne,
                            alignment: Alignment.centerLeft,
                            text: pvmCon.viceCaptain != null
                                ? pvmCon.viceCaptain!.playerName ?? ""
                                : "Vice Captain gets",
                            textColor: pvmCon.viceCaptain != null
                                ? AppColor.textGoldenColor
                                : Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Sizes.spaceHeight5,
                          TextConst(
                            fontSize: Sizes.fontSizeZero,
                            alignment: Alignment.centerLeft,
                            text: "1.5X points",
                            textColor: Colors.grey.shade100,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            Sizes.spaceHeight10,
            Container(
              width: Sizes.screenWidth,
              height: Sizes.screenHeight * 0.03,
              color: AppColor.whiteColor,
              child: Row(
                children: [
                  SizedBox(width: Sizes.screenWidth*0.06,),
                  TextConst(
                    fontSize: Sizes.fontSizeZero,
                    alignment: Alignment.centerLeft,
                    text: "TYPE ↓",
                    textColor: AppColor.textGreyColor,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(width: Sizes.screenWidth*0.06,),
                  TextConst(
                    fontSize: Sizes.fontSizeZero,
                    alignment: Alignment.centerLeft,
                    text: "Points",
                    textColor: AppColor.textGreyColor,
                    fontWeight: FontWeight.w600,
                  ),
                  const Spacer(),
                  TextConst(
                    fontSize: Sizes.fontSizeZero,
                    alignment: Alignment.centerLeft,
                    textColor: AppColor.textGreyColor,
                    fontWeight: FontWeight.w600,
                    text: "% C by",
                  ),
                  SizedBox(width: Sizes.screenWidth*0.07,),
                  TextConst(
                    fontSize: Sizes.fontSizeZero,
                    alignment: Alignment.centerLeft,
                    text: "% VC by",
                    textColor: AppColor.textGreyColor,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(width: Sizes.screenWidth*0.08,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget floatingActionContent() {
    return Consumer<PlayerViewModel>(builder: (context, provider, child) {
      return ContainerConst(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ContainerConst(
              height: 40,
              borderRadius: BorderRadius.circular(25),
              width: Sizes.screenWidth / 1.8,
              color: AppColor.blackColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonConst(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (_) {
                            return const TeamPreviewScreen();
                          });
                    },
                    label: "preview".toUpperCase(),
                    width: Sizes.screenWidth / 4,
                    icon: Icons.remove_red_eye,
                    iconColor: AppColor.whiteColor,
                    color: Colors.transparent,
                    textColor: AppColor.whiteColor,
                  ),
                  TextConst(
                    text: "/",
                    fontSize: Sizes.fontSizeThree,
                    textColor: AppColor.whiteColor,
                  ),
                  ButtonConst(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.pastLineUpScreen);
                    },
                    label: "lineup".toUpperCase(),
                    width: Sizes.screenWidth / 4,
                    icon: Icons.theater_comedy_outlined,
                    iconColor: AppColor.whiteColor,
                    color: Colors.transparent,
                    textColor: AppColor.whiteColor,
                  ),
                ],
              ),
            ),
            ButtonConst(
              onTap: () {
                if (provider.captain != null && provider.viceCaptain != null) {
                  provider.modifyDataAndSaveTeamApiCall(context);
                  // provider.saveCurrentTeam(context);
                  //  Navigator.pushReplacementNamed(context, AppRoutes.contestScreen, arguments: {"tabIndex":2});
                } else {
                  if (kDebugMode) {
                    print("Please select captain and vice captain");
                  }
                }
              },
              label: "save".toUpperCase(),
              height: 40,
              borderRadius: BorderRadius.circular(25),
              width: 90,
              color: provider.captain != null && provider.viceCaptain != null
                  ? AppColor.activeButtonGreenColor
                  : Colors.grey.shade500,
              textColor: AppColor.whiteColor,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      );
    });
  }

  Widget appBarAction() {
    return ContainerConst(
      margin: const EdgeInsets.only(right: 15),
      shape: BoxShape.circle,
      padding: const EdgeInsets.all(5),
      border: Border.all(color: Colors.white, width: 1),
      child: Text(
        "PTS",
        style: TextStyle(fontSize: Sizes.fontSizeOne, color: Colors.white),
      ),
    );
  }

  Widget appBarTitle() {
    return TextConst(
      text: "Create Team",
      textColor: AppColor.whiteColor,
      fontSize: Sizes.fontSizeLarge / 1.25,
      alignment: FractionalOffset.centerLeft,
      fontWeight: FontWeight.w600,
    );
  }
}
