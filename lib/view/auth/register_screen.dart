import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/app_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/auth_view_model.dart';

import '../../res/color_const.dart';
import '../const_widget/button_const.dart';
import '../const_widget/text_field_const.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authProvider, child) {
        return Scaffold(
          backgroundColor: AppColor.whiteColor,
          body: ContainerConst(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Sizes.spaceHeight25,
                  const CircleAvatar(radius: 45,backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/1.jpg"),),
                  Sizes.spaceHeight15,
                  TextConst(text: "You're all set to play!", fontSize: Sizes.fontSizeThree,fontWeight: FontWeight.w600,),
                  Sizes.spaceHeight10,
                  const TextConst(text: "Start your new innings with\n${AppConstants.appName}. Tell us your name",textAlign: TextAlign.center,),
                  Sizes.spaceHeight25,
                  nameTextField(authProvider.nameController, "Enter your name"),
                  Sizes.spaceHeight25,
                  ContainerConst(
                    color: Colors.blueGrey.shade50,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: TextConst(text: "Note: We will use this to generate a name for your team. You can change your team's name later.", fontSize: Sizes.fontSizeOne,textColor: AppColor.textGreyColor,)),
                  Sizes.spaceHeight20,
                  authProvider.state== AuthState.loading?
                      Utils.loadingGreen:
                  ButtonConst(
                    onTap: (){
                      if(authProvider.nameController.text.isNotEmpty){
                        authProvider.register(context);
                      }else{
                        Utils.showErrorMessage(context, "Please enter your name to continue");
                      }
                    },
                    label: "save name".toUpperCase(),color:authProvider.nameController.text.isNotEmpty?AppColor.activeButtonGreenColor:Colors.grey.withOpacity(0.5),textColor:authProvider.nameController.text.isNotEmpty? Colors.white:AppColor.textGreyColor,),
                  Sizes.spaceHeight10,
                  ButtonConst(
                    onTap: (){
                        authProvider.register(context);
                     },
                    label: "i'll do it later".toUpperCase(),border: Border.all(color:AppColor.textGreyColor),textColor: AppColor.blackColor,color: Colors.white,),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
  Widget nameTextField(TextEditingController controller, String labelText,
      {Widget? suffix}) {
    return TextFieldConst(
      fillColor: AppColor.scaffoldBackgroundColor,
      filled: true,
      controller: controller,
      fieldRadius: const BorderRadius.only(
          topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      contentPadding:
      const EdgeInsets.only(top: 8, bottom: 3, left: 10, right: 10),
      borderSide: const BorderSide(),
      borderSideFocus: const BorderSide(),
      label: TextConst(
        text: labelText,
        alignment: Alignment.centerLeft,
        textColor: AppColor.textGreyColor,
      ),
      fontWeight: FontWeight.w500,
      sufixIcon: suffix,
    );
  }
}
