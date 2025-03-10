import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/profile_view_model.dart';

import '../../../generated/assets.dart';
import '../../../res/color_const.dart';
import '../../../res/sizes_const.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
        builder: (context, profileProvider, child) {
      return Scaffold(
        body: ContainerConst(
            height: Sizes.screenHeight,
            image: const DecorationImage(
              image: AssetImage(Assets.assetsBallBgImg),
              fit: BoxFit.fitWidth,
              filterQuality: FilterQuality.high,
              alignment: Alignment.topCenter,
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                ContainerConst(
                  color: AppColor.blackColor.withOpacity(0.4),
                  height: Sizes.screenHeight / 10,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop(true);
                      }, icon: const Icon(Icons.arrow_back, color: AppColor.whiteColor,size: 30,)),
                      const Spacer(),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.email_outlined, color: AppColor.whiteColor,size: 30,)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert, color: AppColor.whiteColor,size: 30,)),
                    ],
                  ),
                ),
                ContainerConst(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  height: Sizes.screenHeight / 1.15,
                  color: AppColor.whiteColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: Column(
                    children: [
                      _buildUserInfo(context, profileProvider),
                      Sizes.spaceHeight20,
                      const Row(
                        children: [
                          TextConst(text: "0 Followers", textColor: AppColor.blackColor,),
                          Sizes.spaceWidth15,
                          TextConst(text: "0 Following", textColor: AppColor.blackColor,),
                          Sizes.spaceWidth15,
                          TextConst(text: "0 Friends", textColor: AppColor.blackColor,),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      );
    });
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
        return  Row(
            children: [
              InkWell(
                onTap: (){
                  profileProvider.pickImage(context,ImageSource.gallery);
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ContainerConst(
                      shape: BoxShape.circle,
                      width: Sizes.screenWidth/4,
                      height: Sizes.screenWidth/4,
                      border: Border.all(color: AppColor.scaffoldBackgroundColor, width: 2),
                      image: userData?.image != null
                          ? DecorationImage(
                              image: NetworkImage(userData!.image!),
                            )
                          : const DecorationImage(
                              image: NetworkImage(
                                  "https://randomuser.me/api/portraits/men/1.jpg"),
                            ),
                    ),
                    const Positioned(
                      right: 10,
                      child: CircleAvatar(
                        radius: 13,
                        backgroundColor:AppColor.textGreyColor,
                        child: Icon(Icons.camera_alt_outlined, color: AppColor.whiteColor,size: 15,),),
                    )
                  ],
                ),
              ),
              Sizes.spaceWidth15,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextConst(
                    text: (userData?.name ?? "Unknown").toUpperCase(),
                    textColor: AppColor.blackColor,
                    alignment: FractionalOffset.centerLeft,
                    fontWeight: FontWeight.w600,
                    maxLines: 1,
                  ),
                  Sizes.spaceHeight5,
                  TextConst(
                    text: "Skill Score: ${userData?.skillScore ?? '🔒'}",
                    textColor: AppColor.blackColor,
                    alignment: FractionalOffset.centerLeft,
                  ),
                ],
              ),

            ],
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
}
