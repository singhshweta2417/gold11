import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/app_const.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gold11/view_model/basic_app_feature_view_model.dart';
import 'package:gold11/view_model/profile_view_model.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileProvider, child) {
        return Drawer(
          backgroundColor: AppColor.scaffoldBackgroundColor,
          width: Sizes.screenWidth / 1.2,
          child: Column(
            children: [
              ContainerConst(
                color: AppColor.blackColor,
                gradient: LinearGradient(
                  colors: [AppColor.blackColor, Colors.grey.shade200],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.28, 0.2],
                ),
                padding: const EdgeInsets.only(top: 15, bottom: 40),
                child: Column(
                  children: [
                    _buildUserInfo(context, profileProvider),
                    Sizes.spaceHeight25,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: itemsBox(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.walletMyBalanceScreen);
                        },
                        Icons.wallet,
                        AppLocalizations.of(context)!.myWallet,
                        radius: true,
                        trailing: TextConst(
                          text:
                              "${Utils.rupeeSymbol}${profileProvider.userProfile == null ? "" : profileProvider.userProfile!.data!.wallet}",
                          fontWeight: FontWeight.w600,
                          width: Sizes.screenWidth / 4,
                          maxLines: 1,
                          alignment: FractionalOffset.centerRight,
                        ),
                      ),
                    ),
                    ContainerConst(
                      height: 40,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      color: const Color(0xfff2fceb),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.blackColor.withOpacity(0.2),
                          offset: const Offset(0, 2),
                          blurRadius: 2,
                          spreadRadius: 0,
                        ),
                      ],
                      border: const Border(
                        bottom: BorderSide(
                            color: AppColor.textGreyColor, width: 0.5),
                        left: BorderSide(
                            color: AppColor.textGreyColor, width: 0.5),
                        right: BorderSide(
                            color: AppColor.textGreyColor, width: 0.5),
                      ),
                      width: Sizes.screenWidth / 1.4,
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: (
                          profileProvider.userProfile!.data!.winningWallet != null &&
                              profileProvider.userProfile!.data!.winningWallet != 0
                      )
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ButtonConst(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.walletAddCashScreen);
                                  },
                                  width: Sizes.screenWidth / 3,
                                  label: 'add cash'.toUpperCase(),
                                  color: Colors.transparent,
                                ),
                                const VerticalDivider(),
                                ButtonConst(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        AppRoutes.walletWithdrawAmount);
                                  },
                                  width: Sizes.screenWidth / 3,
                                  label: 'Withdraw'.toUpperCase(),
                                  color: Colors.transparent,
                                ),
                              ],
                            )
                          : ButtonConst(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.walletAddCashScreen);
                              },
                              label: 'add cash'.toUpperCase(),
                              color: Colors.transparent,
                            ),
                    ),
                    Sizes.spaceHeight10,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: itemsBox(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.myProfileInfo,
                            arguments: {"navigateForm": "drawer"},
                          );
                        },
                        Icons.settings,
                        AppLocalizations.of(context)!.myInfoSetting,
                        radius: true,
                      ),
                    ),
                    Sizes.spaceHeight10,
                    ContainerConst(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(3),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.whiteColor,
                      child: Column(
                        children: [
                          itemsBox(
                            Icons.support_agent,
                            AppLocalizations.of(context)!.helpSupport,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.helpAndSupportScreen);
                            },
                          ),
                          itemsBox(
                            Icons.videogame_asset_sharp,
                            AppLocalizations.of(context)!.howToPlay,
                            onTap: () {
                              Provider.of<BasicAppFeatureViewModel>(context,
                                      listen: false)
                                  .fetchTCPrivacyPolicyAboutUs(
                                      AppConstants.commonSettingPrivacyPolicy);
                              Navigator.pushNamed(
                                  context, AppRoutes.howToPlayGameTypeScreen);
                            },
                          ),
                          itemsBox(
                            Icons.more_horiz,
                            AppLocalizations.of(context)!.more,
                            onTap: () {
                              // Provider.of<BasicAppFeatureViewModel>(context).fetchTCPrivacyPolicyAboutUs(AppConstants.commonSettingPrivacyPolicy);
                              Navigator.pushNamed(
                                  context, AppRoutes.moreSettingScreen);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserInfo(context, ProfileViewModel profileProvider) {
    switch (profileProvider.state) {
      case ProfileState.loading:
        return const CircularProgressIndicator();
      case ProfileState.error:
        return TextConst(
          text: profileProvider.message,
          textColor: AppColor.whiteColor,
          alignment: FractionalOffset.centerLeft,
        );
      case ProfileState.success:
        final userData = profileProvider.userProfile?.data;
        return ListTile(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.viewProfileScreen);
          },
          leading: ContainerConst(
            shape: BoxShape.circle,
            width: 60,
            border: Border.all(color: Colors.white, width: 2),
            image: userData?.image != null
                ? DecorationImage(
                    image: NetworkImage(userData!.image!),
                  )
                : const DecorationImage(
                    image: NetworkImage(
                        "https://randomuser.me/api/portraits/men/1.jpg"),
                  ),
          ),
          title: TextConst(
            text: (userData?.name ?? "Unknown").toUpperCase(),
            textColor: AppColor.whiteColor,
            alignment: FractionalOffset.centerLeft,
            fontWeight: FontWeight.w600,
          ),
          subtitle: TextConst(
            text: "Skill Score: ${userData?.skillScore ?? '🔒'}",
            textColor: AppColor.whiteColor,
            alignment: FractionalOffset.centerLeft,
          ),
          trailing: const Icon(
            Icons.navigate_next,
            color: Colors.white,
          ),
        );
      case ProfileState.idle:
      default:
        return const TextConst(
          text: "Loading...",
          textColor: AppColor.whiteColor,
          alignment: FractionalOffset.centerLeft,
        );
    }
  }

  Widget itemsBox(IconData icon, String title,
      {bool radius = false, Widget? trailing, void Function()? onTap}) {
    return ContainerConst(
      onTap: onTap,
      color: AppColor.whiteColor,
      borderRadius: BorderRadius.circular(radius ? 10 : 0),
      child: ListTile(
        leading: Icon(icon),
        title: TextConst(
          text: title,
          alignment: FractionalOffset.centerLeft,
        ),
        trailing: trailing,
      ),
    );
  }
}
