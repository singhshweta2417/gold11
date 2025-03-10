import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:gold11/view_model/wallet_view_model.dart';

import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../const_widget/button_const.dart';
import '../const_widget/container_const.dart';
import '../const_widget/text_const.dart';

class FileUploadingOptionsBottomSheet extends StatefulWidget {
  const FileUploadingOptionsBottomSheet({super.key});

  @override
  State<FileUploadingOptionsBottomSheet> createState() => _FileUploadingOptionsBottomSheetState();
}

class _FileUploadingOptionsBottomSheetState extends State<FileUploadingOptionsBottomSheet> {
  // File? _selectedFile;
  //
  // Future<void> _pickImage(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(source: source);
  //   if (pickedFile != null) {
  //     File? croppedFile = await _cropImage(File(pickedFile.path));
  //     if (croppedFile != null) {
  //      Navigator.pushNamed(context, AppRoutes.walletViewSelectedImage, arguments: {"imageFile":croppedFile});
  //     }
  //   }
  // }
  //
  // Future<File?> _cropImage(File imageFile) async {
  //   final croppedFile = await ImageCropper.cropImage(
  //     sourcePath: imageFile.path,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //     androidUiSettings: const AndroidUiSettings(
  //       backgroundColor: Colors.black87,
  //       toolbarTitle: 'Edit Image',
  //       toolbarColor: Colors.black87,
  //       toolbarWidgetColor: Colors.white,
  //       initAspectRatio: CropAspectRatioPreset.original,
  //       lockAspectRatio: false,
  //     ),
  //     iosUiSettings: const IOSUiSettings(
  //       minimumAspectRatio: 1.0,
  //     ),
  //   );
  //
  //   if (croppedFile != null) {
  //     final directory = await getApplicationDocumentsDirectory();
  //     final fileName = path.basename(croppedFile.path);
  //     final savedImage = await File(croppedFile.path).copy('${directory.path}/$fileName');
  //     return savedImage;
  //   }
  //   return null;
  //
  // }
  //
  // Future<void> _pickPDF() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );
  //
  //   if (result != null) {
  //     setState(() {
  //       _selectedFile = File(result.files.single.path!);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletViewModel>(
      builder: (context, walletProvider, child) {
        if (walletProvider.selectedImage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // if(walletProvider.initialDocType==walletProvider.docTypeList[0] && walletProvider.selectedImage!=null) {
            //   Navigator.pushNamed(
            //     context,
            //     AppRoutes.walletViewSelectedImage,
            //     arguments: {"imageFile": walletProvider.selectedImage},
            //   );
            // }else{
            //   print("it is support only one image");
            // }
          });
        }
        return ContainerConst(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(15),
          padding: const EdgeInsets.only(bottom: 10,),
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Sizes.spaceHeight15,
              ButtonConst(
                onTap: (){
                  walletProvider.pickImage(context,ImageSource.camera);
                },
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                icon:Icons.camera_alt_outlined,
                label:"open camera".toUpperCase(),
                color:AppColor.activeButtonGreenColor,
                fontSize: Sizes.fontSizeTwo,
                fontWeight: FontWeight.w600,
                space: 10,
                textColor: AppColor.whiteColor,
              ),
              ButtonConst(
                  onTap: (){
                    walletProvider.pickImage(context,ImageSource.gallery);
                  },
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                icon:Icons.image_outlined,
                label:"upload image".toUpperCase(),
                fontSize: Sizes.fontSizeTwo,
                fontWeight: FontWeight.w600,
                space: 10,
                textColor: AppColor.blackColor,
                iconColor: AppColor.blackColor,
                border: Border.all(color: Colors.grey),
              ),
              // ButtonConst(
              //   onTap: (){
              //     walletProvider.pickPdf();
              //   },
              //   margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //   icon:Icons.picture_as_pdf,
              //   label:"upload pdf".toUpperCase(),
              //   fontSize: Sizes.fontSizeTwo,
              //   fontWeight: FontWeight.w600,
              //   space: 10,
              //   textColor: AppColor.blackColor,
              //   iconColor: AppColor.blackColor,
              //   border: Border.all(color: Colors.grey),
              // ),
              Sizes.spaceHeight10,
              ContainerConst(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: const Color(0xffebf7ff),
                  child: TextConst(text: "Note: Any details, once submitted, can't be unlinked and used on any other account", textColor: Colors.black54,fontSize: Sizes.fontSizeOne,))
            ],
          ),
        );
      }
    );
  }
}
