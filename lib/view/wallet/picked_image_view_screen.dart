// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:gold11/res/shared_preferences_util.dart';
// import 'package:gold11/utils/utils.dart';
// import 'package:gold11/view/const_widget/container_const.dart';
// import 'package:gold11/view_model/wallet_view_model.dart';
//
// import '../../res/color_const.dart';
// import '../../res/sizes_const.dart';
// import '../const_widget/appbar_const.dart';
// import '../const_widget/button_const.dart';
//
// class PickedImageViewScreen extends StatelessWidget {
//   const PickedImageViewScreen({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<WalletViewModel>(builder: (context, walletProvider, child) {
//       return Scaffold(
//           appBar: AppBarConst(
//               title: walletProvider.selectedImage != null &&
//                       walletProvider.selectedImageBack == null
//                   ? "Upload Front"
//                   : "Upload Back (2/2)"),
//           body:walletProvider.initialDocType==walletProvider.docTypeList[0]?multipleImageCondition(context, walletProvider):singleImageCondition(context, walletProvider));
//     });
//   }
//
//   Widget singleImageCondition(context, WalletViewModel walletProvider) {
//     return Column(
//       children: [
//         Expanded(
//             flex: 8,
//             child: Image.file(
//               walletProvider.selectedImage!,
//               fit: BoxFit.cover,
//             )),
//         ButtonConst(
//           onTap: () {
//               walletProvider.makeDataAsPerDocTypeAndHiTApi(
//                   context,
//                   Provider.of<SharedPrefViewModel>(context, listen: false)
//                       .userToken);
//           },
//           margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//           label: walletProvider.initialDocType.toUpperCase(),
//           color: AppColor.activeButtonGreenColor,
//           fontSize: Sizes.fontSizeTwo,
//           fontWeight: FontWeight.w600,
//           space: 10,
//           textColor: AppColor.whiteColor,
//         ),
//       ],
//     );
//   }
//
//   Widget multipleImageCondition(context, WalletViewModel walletProvider) {
//     return Column(
//       children: [
//         if(walletProvider.selectedImage != null && walletProvider.selectedImageBack == null)
//         Expanded(
//             flex: 8,
//             child: Image.file(
//               walletProvider.selectedImage!,
//               fit: BoxFit.cover,
//             )),
//         if(walletProvider.selectedImage != null && walletProvider.selectedImageBack != null)
//           Expanded(
//               flex: 8,
//               child: Image.file(
//                 walletProvider.selectedImageBack!,
//                 fit: BoxFit.cover,
//               )),
//         walletProvider.savedImageList.length == 1
//             ? ContainerConst(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                 child: Column(
//                   children: [
//                     ButtonConst(
//                       onTap: () {
//                         walletProvider.makeDataAsPerDocTypeAndHiTApi(
//                             context,
//                             Provider.of<SharedPrefViewModel>(context,
//                                     listen: false)
//                                 .userToken);
//                           },
//                       label: "Submit back image".toUpperCase(),
//                       color: AppColor.activeButtonGreenColor,
//                       fontSize: Sizes.fontSizeTwo,
//                       fontWeight: FontWeight.w600,
//                       space: 10,
//                       textColor: AppColor.whiteColor,
//                     ),
//                     Sizes.spaceHeight10,
//                     Utils.walletInfoNote()
//                   ],
//                 ),
//               )
//             : Expanded(
//                 flex: 2,
//                 child: ContainerConst(
//                   color: Colors.white,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ButtonConst(
//                         onTap: () {
//                           if (walletProvider.initialDocType ==
//                               walletProvider.docTypeList[0]) {
//                             walletProvider
//                                 .addImage(walletProvider.selectedImage!);
//                           } else {
//                             walletProvider.makeDataAsPerDocTypeAndHiTApi(
//                                 context,
//                                 Provider.of<SharedPrefViewModel>(context,
//                                         listen: false)
//                                     .userToken);
//                           }
//
//                           // walletProvider.pickImage(walletProvider.selectedImageSource);
//
//                           // if(walletProvider.savedImageList.isNotEmpty){
//                           //   walletProvider.makeDataAsPerDocTypeAndHiTApi(context, Provider.of<SharedPrefViewModel>(context).userToken);
//                           // }
//                         },
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 15, vertical: 10),
//                         label: walletProvider.selectedImage != null &&
//                                 walletProvider.selectedImageBack == null
//                             ? "Submit Front image".toUpperCase()
//                             : "Submit Back image".toUpperCase(),
//                         color: AppColor.activeButtonGreenColor,
//                         fontSize: Sizes.fontSizeTwo,
//                         fontWeight: FontWeight.w600,
//                         space: 10,
//                         textColor: AppColor.whiteColor,
//                       ),
//                       ButtonConst(
//                         onTap: () {
//                           if (walletProvider.savedImageList.isNotEmpty) {
//                             walletProvider
//                                 .removeImage(walletProvider.selectedImage!);
//                           }
//                           Navigator.of(context).pop;
//                           walletProvider.pickImage(
//                               context, walletProvider.selectedImageSource);
//                         },
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 15, vertical: 10),
//                         icon: Icons.camera_alt_outlined,
//                         label: "try again".toUpperCase(),
//                         fontSize: Sizes.fontSizeTwo,
//                         fontWeight: FontWeight.w600,
//                         space: 10,
//                         textColor: AppColor.blackColor,
//                         iconColor: AppColor.blackColor,
//                         border: Border.all(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view_model/wallet_view_model.dart';

import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../const_widget/appbar_const.dart';
import '../const_widget/button_const.dart';

class PickedImageViewScreen extends StatelessWidget {
  const PickedImageViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletViewModel>(
      builder: (context, walletProvider, child) {
        return Scaffold(
          appBar: AppBarConst(
            title: walletProvider.selectedImage != null &&
                walletProvider.selectedImageBack == null
                ? "Upload Front"
                : "Upload Back (2/2)",
          ),
          body:
          // walletProvider.initialDocType == walletProvider.docTypeList[0]
          //     ? multipleImageCondition(context, walletProvider)
          //     :
          singleImageCondition(context, walletProvider),
        );
      },
    );
  }

  Widget singleImageCondition(BuildContext context, WalletViewModel walletProvider) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: Image.file(
            walletProvider.selectedImage!,
            fit: BoxFit.cover,
          ),
        ),
        ButtonConst(
          onTap: () {
            walletProvider.makeDataAsPerDocTypeAndHiTApi(
              context,
              Provider.of<SharedPrefViewModel>(context, listen: false).userToken,
            );
          },
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          label: walletProvider.initialDocType.toUpperCase(),
          color: AppColor.activeButtonGreenColor,
          fontSize: Sizes.fontSizeTwo,
          fontWeight: FontWeight.w600,
          space: 10,
          textColor: AppColor.whiteColor,
        ),
      ],
    );
  }

  Widget multipleImageCondition(BuildContext context, WalletViewModel walletProvider) {
    return Column(
      children: [
        if (walletProvider.selectedImage != null && walletProvider.selectedImageBack == null)
          Expanded(
            flex: 8,
            child: Image.file(
              walletProvider.selectedImage!,
              fit: BoxFit.cover,
            ),
          ),
        if (walletProvider.selectedImage != null && walletProvider.selectedImageBack != null)
          Expanded(
            flex: 8,
            child: Image.file(
              walletProvider.selectedImageBack!,
              fit: BoxFit.cover,
            ),
          ),
        walletProvider.savedImageList.length == 1
            ? ContainerConst(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              ButtonConst(
                onTap: () {
                  walletProvider.makeDataAsPerDocTypeAndHiTApi(
                    context,
                    Provider.of<SharedPrefViewModel>(context, listen: false).userToken,
                  );
                },
                label: "Submit back image".toUpperCase(),
                color: AppColor.activeButtonGreenColor,
                fontSize: Sizes.fontSizeTwo,
                fontWeight: FontWeight.w600,
                space: 10,
                textColor: AppColor.whiteColor,
              ),
              const SizedBox(height: 10),
              Utils.walletInfoNote(),
            ],
          ),
        )
            : Expanded(
          flex: 2,
          child: ContainerConst(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonConst(
                  onTap: () {
                    if (walletProvider.initialDocType == walletProvider.docTypeList[0]) {
                      walletProvider.addImage(walletProvider.selectedImage!);
                    } else {
                      walletProvider.makeDataAsPerDocTypeAndHiTApi(
                        context,
                        Provider.of<SharedPrefViewModel>(context, listen: false).userToken,
                      );
                    }
                  },
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  label: walletProvider.selectedImage != null &&
                      walletProvider.selectedImageBack == null
                      ? "Submit Front image".toUpperCase()
                      : "Submit Back image".toUpperCase(),
                  color: AppColor.activeButtonGreenColor,
                  fontSize: Sizes.fontSizeTwo,
                  fontWeight: FontWeight.w600,
                  space: 10,
                  textColor: AppColor.whiteColor,
                ),
                ButtonConst(
                  onTap: () {
                    if (walletProvider.savedImageList.isNotEmpty) {
                      walletProvider.removeImage(walletProvider.selectedImage!);
                    }
                    Navigator.of(context).pop();
                    walletProvider.pickImage(
                      context,
                      walletProvider.selectedImageSource,
                    );
                  },
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  icon: Icons.camera_alt_outlined,
                  label: "try again".toUpperCase(),
                  fontSize: Sizes.fontSizeTwo,
                  fontWeight: FontWeight.w600,
                  space: 10,
                  textColor: AppColor.blackColor,
                  iconColor: AppColor.blackColor,
                  border: Border.all(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
