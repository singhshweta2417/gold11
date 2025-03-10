import 'package:flutter/material.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';

class CommentryPage extends StatefulWidget {
  const CommentryPage({super.key});

  @override
  State<CommentryPage> createState() => _CommentryPageState();
}

class _CommentryPageState extends State<CommentryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),

      children: [
        ContainerConst(
          alignment: Alignment.center,
          height: Sizes.screenHeight * 0.12,
          color: AppColor.textGreyColor.withOpacity(0.05),
          border: Border.all(color: AppColor.textGreyColor.withOpacity(0.1)),
          padding: const EdgeInsets.only(top: 22, left: 15),
          child: Column(
            children: [
              TextConst(
                text: "End of Over 12",
                textColor: AppColor.blackColor,
                alignment: Alignment.centerLeft,
                fontWeight: FontWeight.w500,
                fontSize: Sizes.fontSizeThree,
              ),
              Sizes.spaceHeight5,
              Row(
                children: [
                  TextConst(
                    text: "J'D Fikar",
                    textColor: AppColor.textGreyColor,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.w500,
                    fontSize: Sizes.fontSizeTwo,
                  ),
                  Sizes.spaceWidth5,
                  ContainerConst(
                    height: 18,
                    width: 1,
                    color: AppColor.textGreyColor.withOpacity(0.2),
                  ),
                  Sizes.spaceWidth5,
                  TextConst(
                    text: "3 Runs",
                    textColor: AppColor.textGreyColor,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.w500,
                    fontSize: Sizes.fontSizeTwo,
                  ),
                  Sizes.spaceWidth5,
                  ContainerConst(
                    height: 18,
                    width: 1,
                    color: AppColor.textGreyColor.withOpacity(0.2),
                  ),
                  Sizes.spaceWidth5,
                  TextConst(
                    text: "0 wickets",
                    textColor: AppColor.textGreyColor,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.w500,
                    fontSize: Sizes.fontSizeTwo,
                  ),
                  Sizes.spaceWidth5,
                  ContainerConst(
                    height: 18,
                    width: 1,
                    color: AppColor.textGreyColor.withOpacity(0.2),
                  ),
                  Sizes.spaceWidth5,
                  TextConst(
                    text: "MDV 75/2",
                    textColor: AppColor.textGreyColor,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.w500,
                    fontSize: Sizes.fontSizeTwo,
                  ),
                ],
              ),
            ],
          ),
        ),
        ContainerConst(
          margin: const EdgeInsets.only(left: 35),
          height: Sizes.screenHeight*0.02,
          width: 3,
          color: AppColor.textGreyColor.withOpacity(0.1),
        ),
        Sizes.spaceHeight5,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColor.textGreyColor.withOpacity(0.1),
                  child: const TextConst(
                    text: "0",
                    textColor: AppColor.textGreyColor,
                  ),
                ),
                TextConst(
                  text: "11.6",
                  textColor: AppColor.blackColor,
                  fontSize: Sizes.fontSizeThree,
                ),
              ],
            ),
            TextConst(
              text: "J'D fikar to S Hassan, No run, played\ntowards cover",
              textColor: AppColor.textGreyColor,
              fontSize: Sizes.fontSizeTwo,
            )
          ],
        ),
        ContainerConst(
          margin: const EdgeInsets.only(left: 35, top: 10),
          height: 28,
          width: 3,
          color: AppColor.textGreyColor.withOpacity(0.1),
        ),
        Sizes.spaceHeight5,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColor.textGreyColor.withOpacity(0.1),
                  child: const TextConst(
                    text: "0",
                    textColor: AppColor.textGreyColor,
                  ),
                ),
                TextConst(
                  text: "11.6",
                  textColor: AppColor.blackColor,
                  fontSize: Sizes.fontSizeThree,
                ),
              ],
            ),
            Column(
              children: [
                TextConst(
                  text:
                  "J'D fikar to S Hassan, No run, played\ntowards cover",
                  textColor: AppColor.textGreyColor,
                  fontSize: Sizes.fontSizeTwo,
                ),
                ContainerConst(
                  margin: const EdgeInsets.only(top: 5),
                  height: Sizes.screenHeight * 0.06,
                  width: Sizes.screenWidth * 0.65,
                  borderRadius: BorderRadius.circular(5),
                  color: AppColor.textGreyColor.withOpacity(0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.playersImgPlayer5,
                        height: 45,
                        fit: BoxFit.fitHeight,
                      ),
                      const TextConst(text: "Sachin Sharma",textColor: AppColor.textGreyColor,),
                      const Spacer(),
                      const TextConst(text: "+1 Pts",textColor: AppColor.textGreyColor,),
                      Sizes.spaceWidth15,
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        ContainerConst(
          margin: const EdgeInsets.only(left: 35),
          height: 55,
          width: 3,
          color: AppColor.textGreyColor.withOpacity(0.1),
        ),
        Sizes.spaceHeight5,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColor.textGreyColor.withOpacity(0.1),
                  child: const TextConst(
                    text: "0",
                    textColor: AppColor.textGreyColor,
                  ),
                ),
                TextConst(
                  text: "11.6",
                  textColor: AppColor.blackColor,
                  fontSize: Sizes.fontSizeThree,
                ),
              ],
            ),
            Column(
              children: [
                TextConst(
                  text:
                  "J'D fikar to S Hassan, No run, played\ntowards cover",
                  textColor: AppColor.textGreyColor,
                  fontSize: Sizes.fontSizeTwo,
                ),
                ContainerConst(
                  margin: const EdgeInsets.only(top: 5),
                  height: Sizes.screenHeight * 0.06,
                  width: Sizes.screenWidth * 0.65,
                  borderRadius: BorderRadius.circular(5),
                  color: AppColor.textGreyColor.withOpacity(0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.playersImgPlayer5,
                        height: 45,
                        fit: BoxFit.fitHeight,
                      ),
                      const TextConst(text: "Sachin Sharma",textColor: AppColor.textGreyColor,),
                      const Spacer(),
                      const TextConst(text: "+1 Pts",textColor: AppColor.textGreyColor,),
                      Sizes.spaceWidth15,
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        ContainerConst(
          margin: const EdgeInsets.only(left: 35),
          height: Sizes.screenHeight*0.08,
          width: 3,
          color: AppColor.textGreyColor.withOpacity(0.1),
        ),
        Sizes.spaceHeight5,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColor.textGreyColor.withOpacity(0.1),
                  child: const TextConst(
                    text: "0",
                    textColor: AppColor.textGreyColor,
                  ),
                ),
                TextConst(
                  text: "11.6",
                  textColor: AppColor.blackColor,
                  fontSize: Sizes.fontSizeThree,
                ),
              ],
            ),
            Column(
              children: [
                TextConst(
                  text:
                  "J'D fikar to S Hassan, No run, played\ntowards cover",
                  textColor: AppColor.textGreyColor,
                  fontSize: Sizes.fontSizeTwo,
                ),
                ContainerConst(
                  margin: const EdgeInsets.only(top: 5),
                  height: Sizes.screenHeight * 0.06,
                  width: Sizes.screenWidth * 0.65,
                  borderRadius: BorderRadius.circular(5),
                  color: AppColor.textGreyColor.withOpacity(0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.playersImgPlayer5,
                        height: 45,
                        fit: BoxFit.fitHeight,
                      ),
                      const TextConst(text: "Sachin Sharma",textColor: AppColor.textGreyColor,),
                      const Spacer(),
                      const TextConst(text: "+1 Pts",textColor: AppColor.textGreyColor,),
                      Sizes.spaceWidth15,
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        Sizes.spaceHeight15,
        Row(
          children: [
            ContainerConst(
              height: Sizes.screenHeight*0.08,
              width: 15,
              color: Colors.orange,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)
              ),
            ),
            Sizes.spaceWidth25,
            ContainerConst(
              height: Sizes.screenHeight*0.08,
              width: Sizes.screenWidth*0.08,
              shape: BoxShape.circle,
              border: Border.all(
                  color: Colors.orange,
                  width: 2
              ),
              child: const TextConst(
                text: "PTS",
                textColor: Colors.orange,
              ),
            ),
            Sizes.spaceWidth25,
            TextConst(
              text: "Ibrahim Hassan Shao'f strike rate\n decreased",
              textColor: AppColor.textGreyColor,
              fontSize: Sizes.fontSizeTwo,
            ),
          ],
        )
      ],
    );
  }
}