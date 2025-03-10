import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/view/const_widget/appbar_const.dart';

import '../../../res/app_const.dart';
import '../../../res/color_const.dart';
import '../../../res/sizes_const.dart';
import '../../../utils/route/app_routes.dart';
import '../../../view_model/basic_app_feature_view_model.dart';
import '../../const_widget/container_const.dart';
import '../../const_widget/text_const.dart';

class MoreSettingScreen extends StatelessWidget {
  const MoreSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      appBar: const AppBarConst(
        title: "More Options",
      ),
      body: ListView(
        children: [
          _buildSettingOption(
            context,
            title: "Privacy Policy",
            icon: Icons.privacy_tip_outlined,
            onTap: () => _navigateToSetting(
              context,
              AppConstants.commonSettingPrivacyPolicy,
            ),
          ),
          Sizes.spaceHeight5,
          _buildSettingOption(
            context,
            title: "Terms & Conditions",
            icon: Icons.description_outlined,
            onTap: () => _navigateToSetting(
              context,
              AppConstants.commonSettingTC,
            ),
          ),
          Sizes.spaceHeight5,
          _buildSettingOption(
            context,
            title: "About Us",
            icon: Icons.info_outline,
            onTap: () => _navigateToSetting(
              context,
              AppConstants.commonSettingAboutUs,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingOption(
      BuildContext context, {
        required String title,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return ContainerConst(
      padding: const EdgeInsets.symmetric(vertical: 7),
      color: AppColor.whiteColor,
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: AppColor.primaryRedColor,
        ),
        title: TextConst(
          text: title,
          fontWeight: FontWeight.w600,
          alignment: FractionalOffset.centerLeft,
        ),
        trailing: const Icon(Icons.navigate_next),
      ),
    );
  }

  void _navigateToSetting(BuildContext context, String settingType) {
    Provider.of<BasicAppFeatureViewModel>(context, listen: false)
        .fetchTCPrivacyPolicyAboutUs(settingType)
        .then((_) {
      Navigator.pushNamed(context, AppRoutes.commonSettingScreen);
    });
  }
}
