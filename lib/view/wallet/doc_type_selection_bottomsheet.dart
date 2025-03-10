import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view_model/wallet_view_model.dart';

import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../const_widget/text_const.dart';

class DocTypeSelectionBottomSheetScreen extends StatelessWidget {
  const DocTypeSelectionBottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletViewModel>(
      builder: (context, walletProvider, child) {
        return ContainerConst(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(15),
          padding: const EdgeInsets.only(bottom: 10,),
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.clear, size: 30,)),
                    const Spacer(),
                    TextConst(text: "Select Any One",fontWeight: FontWeight.w600,fontSize: Sizes.fontSizeThree,alignment: Alignment.center,textAlign: TextAlign.center,),
                    const Spacer(),
                    Sizes.spaceWidth25
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(children:List.generate(walletProvider.docTypeList.length, (i){
                  final docType= walletProvider.docTypeList[i];
                  return ContainerConst(
                    onTap: (){
                      walletProvider.chooseDocType(docType);
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    border: Border(top: BorderSide(color: AppColor.scaffoldBackgroundColor,width: 1)),
                    child: Row(
                      children: [
                        TextConst(text: docType,alignment: Alignment.centerLeft,),
                       const Spacer(),
                        Radio(
                            value: docType, groupValue: walletProvider.initialDocType, onChanged: (v){
                        },
                        activeColor: AppColor.blackColor,
                        )
                      ],
                    ),
                  );
                }),),
              ),
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
