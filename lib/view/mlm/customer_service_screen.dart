import 'package:flutter/material.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/appbar_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';

import '../const_widget/text_const.dart';

class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({super.key});

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: const AppBarConst(
        title: "Customer Service",
      ),
      body: ContainerConst(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                Assets.assetsSupportIcon,
                width: Sizes.screenWidth / 1.2,
              ),
            ),
            Sizes.spaceHeight20,
            actionButtons(Icons.support_agent, "Telegram", ""),
            Sizes.spaceHeight15,
            actionButtons(Icons.wifi_channel, "Channel", ""),
            Sizes.spaceHeight15,
            actionButtons(Icons.email, "Email", ""),
          ],
        ),
      ),
    );
  }
  Widget actionButtons(IconData icon, String title, String trail,
      {void Function()? onTap}) {
    return ContainerConst(
      onTap: onTap,
      boxShadow: [
        BoxShadow(
            offset: const Offset(0, 2),
            color: AppColor.textGreyColor.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 1)
      ],
      gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            AppColor.scaffoldBackgroundColor,
            Colors.white,
            AppColor.scaffoldBackgroundColor,
          ]),
      padding: const EdgeInsets.only(top: 3, bottom: 10),
      borderRadius: BorderRadius.circular(15),
      color: AppColor.whiteColor,
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColor.primaryRedColor,
        ),
        title: TextConst(
          text: title,
          alignment: Alignment.centerLeft,
          fontWeight: FontWeight.w600,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextConst(
              text: trail,
              width: 100,
              alignment: Alignment.centerRight,
            ),
            const Icon(
              Icons.navigate_next,
              color: AppColor.blackColor,
            ),
          ],
        ),
      ),
    );
  }
}
