import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/text_field_const.dart';
import 'package:gold11/view/wallet/doc_type_selection_bottomsheet.dart';
import 'package:gold11/view/wallet/file_uploading_options_bottomsheet.dart';
import 'package:gold11/view_model/wallet_view_model.dart';

import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../const_widget/container_const.dart';
import '../const_widget/text_const.dart';

class VerifyDetailsScreen extends StatefulWidget {
  const VerifyDetailsScreen({super.key});

  @override
  State<VerifyDetailsScreen> createState() => _VerifyDetailsScreenState();
}

class _VerifyDetailsScreenState extends State<VerifyDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WalletViewModel>(context, listen: false).clearFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: appBarDesign(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            headingDetails(),
            Sizes.spaceHeight15,
            infoHeading(),
            Sizes.spaceHeight10,
            stepOneContent(),
            // Sizes.spaceHeight25,
            // stepTwoContent()
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBarDesign(context) {
    return AppBar(
      elevation: 0,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: ContainerConst(
            color: AppColor.whiteColor,
            gradient: AppColor.darkRedToBlackGradientTwo,
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColor.whiteColor,
                  ),
                ),
                Sizes.spaceWidth20,
                TextConst(
                  text: "Verify Details",
                  textColor: AppColor.whiteColor,
                  fontSize: Sizes.fontSizeLarge / 1.25,
                  alignment: FractionalOffset.centerLeft,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          )),
    );
  }

  Widget headingDetails() {
    return ContainerConst(
      width: Sizes.screenWidth,
      color: const Color(0xffe3f9e7),
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xffe3f9e7),
            const Color(0xffe3f9e7).withOpacity(0.5),
            const Color(0xffe3f9e7).withOpacity(0.1)
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Sizes.spaceHeight25,
          Image.asset(
            Assets.iconsSecure,
            width: 60,
          ),
          Sizes.spaceHeight10,
          TextConst(
            text: "Verify in 2 Easy Steps",
            fontSize: Sizes.fontSizeLarge,
            textColor: const Color(0xff03591a),
            fontWeight: FontWeight.bold,
          ),
          Sizes.spaceHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextConst(
                text: "Let's ensure you're ",
                fontSize: Sizes.fontSizeOne,
                textColor: AppColor.blackColor.withOpacity(0.8),
              ),
              TextConst(
                  text: "18+ ",
                  fontSize: Sizes.fontSizeOne,
                  fontWeight: FontWeight.w600,
                  textColor: AppColor.blackColor.withOpacity(0.8)),
              TextConst(
                  text: "and not from a ",
                  fontSize: Sizes.fontSizeOne,
                  textColor: AppColor.blackColor.withOpacity(0.8)),
              TextConst(
                  text: "restricted states ",
                  fontSize: Sizes.fontSizeOne,
                  fontWeight: FontWeight.w600,
                  textColor: AppColor.blackColor.withOpacity(0.8)),
              const Icon(
                CupertinoIcons.info,
                size: 17,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget infoHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ContainerConst(
          height: 1,
          color: CupertinoColors.white,
          width: Sizes.screenWidth / 5,
          gradient: LinearGradient(colors: [
            AppColor.blackColor.withOpacity(0.1),
            AppColor.blackColor.withOpacity(0.3)
          ]),
        ),
        ContainerConst(
          color: Colors.blueAccent.withOpacity(0.08),
          borderRadius: BorderRadius.circular(30),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: const Text(
            "Corers have already verified",
          ),
        ),
        ContainerConst(
          height: 1,
          color: CupertinoColors.white,
          width: Sizes.screenWidth / 5,
          gradient: LinearGradient(colors: [
            AppColor.blackColor.withOpacity(0.3),
            AppColor.blackColor.withOpacity(0.1)
          ]),
        ),
      ],
    );
  }

  Widget stepOneContent() {
    return Consumer<WalletViewModel>(builder: (context, walletProvider, child) {
      return
        // Provider.of<ProfileViewModel>(context)
        //           .userProfile!
        //           .data!
        //           .isVerify ==
        //       1
        //   ? stepOneCompleted():
           ContainerConst(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              border: Border.all(
                color: Colors.grey.shade400,
              ),
              borderRadius: BorderRadius.circular(10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: CircleAvatar(
                      backgroundColor: AppColor.scaffoldBackgroundColor,
                      child: const Icon(Icons.supervised_user_circle),
                    ),
                    title: TextConst(
                      text: "Step 1",
                      textColor: AppColor.textGreyColor,
                      fontSize: Sizes.fontSizeOne,
                      alignment: Alignment.centerLeft,
                    ),
                    subtitle: const TextConst(
                      text: "Enter your details",
                      fontWeight: FontWeight.w600,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Sizes.spaceHeight10,
                  ContainerConst(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return const DocTypeSelectionBottomSheetScreen();
                          });
                    },
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.blackColor),
                    child: ListTile(
                      title: TextConst(
                        text: walletProvider.initialDocType,
                        alignment: Alignment.centerLeft,
                      ),
                      trailing: const Icon(
                        Icons.arrow_drop_down,
                        color: AppColor.blackColor,
                      ),
                    ),
                  ),
                  Sizes.spaceHeight20,
                  commonTextField(walletProvider.idNumberType),
                  ButtonConst(
                    onTap: () {
                      if (walletProvider.idNumber.text.isNotEmpty) {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return const FileUploadingOptionsBottomSheet();
                            });
                      } else {
                        Utils.showErrorMessage(context,
                            "Please ${walletProvider.idNumberType.toLowerCase()} to continue");
                      }
                    },
                    label: walletProvider.initialDocType.toUpperCase(),
                    color: AppColor.activeButtonGreenColor,
                    textColor: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    fontWeight: FontWeight.bold,
                  ),
                  Sizes.spaceHeight15,
                  noteInfo()
                ],
              ),
            );
    });
  }

  Widget stepOneCompleted() {
    return ContainerConst(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      border: Border.all(
        color: Colors.grey.shade400,
      ),
      borderRadius: BorderRadius.circular(10),
      padding: const EdgeInsets.all(4),
      child: ContainerConst(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              const Color(0xffe3f9e7),
              const Color(0xffe3f9e7).withOpacity(0.5),
              const Color(0xffe3f9e7).withOpacity(0.1),
              const Color(0xffe3f9e7).withOpacity(0.1),
              const Color(0xffe3f9e7).withOpacity(0.1),
            ]),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColor.scaffoldBackgroundColor,
            child: const Icon(Icons.supervised_user_circle),
          ),
          title: TextConst(
            text: "Step 1",
            textColor: AppColor.textGreyColor,
            fontSize: Sizes.fontSizeOne,
            alignment: Alignment.centerLeft,
          ),
          subtitle: const TextConst(
            text: "Enter your details",
            fontWeight: FontWeight.w600,
            alignment: Alignment.centerLeft,
          ),
          trailing: const Icon(
            CupertinoIcons.checkmark_alt_circle_fill,
            color: AppColor.activeButtonGreenColor,
          ),
        ),
      ),
    );
  }

  Widget stepTwoContent() {
    return ContainerConst(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      border: Border.all(
        color: Colors.grey.shade400,
      ),
      borderRadius: BorderRadius.circular(10),
      padding: const EdgeInsets.all(4),
      child: ContainerConst(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              AppColor.scaffoldBackgroundColor,
              Colors.white,
              AppColor.scaffoldBackgroundColor,
            ]),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColor.scaffoldBackgroundColor,
            child: const Icon(Icons.supervised_user_circle),
          ),
          title: TextConst(
            text: "Step 1",
            textColor: AppColor.textGreyColor,
            fontSize: Sizes.fontSizeOne,
            alignment: Alignment.centerLeft,
          ),
          subtitle: const TextConst(
            text: "Enter your details",
            fontWeight: FontWeight.w600,
            alignment: Alignment.centerLeft,
            textColor: AppColor.textGreyColor,
          ),
        ),
      ),
    );
  }

  Widget commonTextField(String label) {
    return Consumer<WalletViewModel>(builder: (context, wvmCon, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFieldConst(
            controller: wvmCon.idNumber,
            margin: const EdgeInsets.only(bottom: 15),
            fillColor: AppColor.whiteColor,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            textAlignVertical: TextAlignVertical.center,
            label: Text(
              label,
              style: const TextStyle(color: AppColor.blackColor),
            ),
            fieldRadius: BorderRadius.circular(10),
            outLineBorderEnabled: true,
            borderSide: const BorderSide(color: AppColor.blackColor),
          ),
        ],
      );
    });
  }

  Widget noteInfo() {
    return TextConst(
      text:
          "Note: Any details, once submitted, can't be unlinked and used on any other account",
      textColor: AppColor.blackColor,
      fontSize: Sizes.fontSizeOne,
    );
  }
}
