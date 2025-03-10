import 'package:flutter/material.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';

class AppBarConst extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? appBarColor;

   const AppBarConst({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = true, this.appBarColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:appBarColor?? AppColor.blackColor,
      iconTheme: const IconThemeData(color: Colors.white),
      title: TextConst(text: title,textColor: AppColor.whiteColor,fontSize: Sizes.fontSizeLarge/1.25,alignment: FractionalOffset.centerLeft,fontWeight: FontWeight.w600,),
      actions: actions,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
