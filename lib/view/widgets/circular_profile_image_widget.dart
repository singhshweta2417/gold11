import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/view_model/profile_view_model.dart';

import '../../res/color_const.dart';
import '../const_widget/container_const.dart';

class CircularProfileImageWidget extends StatelessWidget {
  final void Function()? onPressed;
   const CircularProfileImageWidget({super.key, this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileProvider, child) {
        final userData = profileProvider.userProfile?.data;
        return IconButton(
          onPressed:onPressed,
          icon: Stack(
            children: [
              ContainerConst(
                shape: BoxShape.circle,
                height: 40,
                width: 40,
                color: Colors.grey.shade300,
                border: Border.all(
                    width: 2, color: AppColor.whiteColor),
                image: userData?.image != null
                    ? DecorationImage(
                  image: NetworkImage(userData!.image!),
                )
                    : const DecorationImage(
                  image: NetworkImage(
                      "https://randomuser.me/api/portraits/men/1.jpg"),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.grey.shade100,
                  child: const Icon(
                    Icons.menu,
                    size: 10,
                    color: AppColor.textGreyColor,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
