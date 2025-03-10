import 'package:flutter/material.dart';
import 'package:gold11/model/game_data_model.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';

class CompleteMatchScore extends StatefulWidget {
  final GameData data;
  const CompleteMatchScore({super.key, required  this.data});

  @override
  State<CompleteMatchScore> createState() => _CompleteMatchScoreState();
}

class _CompleteMatchScoreState extends State<CompleteMatchScore> {
  @override
  Widget build(BuildContext context) {
    return  Container(
    color: AppColor.blackColor,
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextConst(
                text: "${widget.data.homeTeamName}",
                textColor: AppColor.whiteColor,
                fontSize: 12,
                alignment: FractionalOffset.centerLeft,
                fontWeight: FontWeight.w400,
              ),
              TextConst(
                text: "${widget.data.visitorTeamName}",
                textColor: AppColor.whiteColor,
                fontSize: 12,
                alignment: FractionalOffset.centerLeft,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ContainerConst(
                    shape: BoxShape.circle,
                    width: 30,
                    height: 30,
                    image: DecorationImage(
                      image:
                          NetworkImage(widget.data.homeTeamImage ?? ""),
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextConst(
                    text:
                        "${widget.data.homeTeamScore}/${widget.data.homeTeamWicket}",
                    textColor: Colors.white70,
                    fontSize: 16,
                    alignment: FractionalOffset.centerLeft,
                    fontWeight: FontWeight.w800,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextConst(
                    text: "(${widget.data.homeTeamOvers})",
                    textColor: Colors.white,
                    fontSize: 12,
                    alignment: FractionalOffset.centerLeft,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
              Row(
                children: [
                  TextConst(
                    text: "(${widget.data.visitorTeamOvers})",
                    textColor: Colors.white,
                    fontSize: 12,
                    alignment: FractionalOffset.centerLeft,
                    fontWeight: FontWeight.w300,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextConst(
                    text:
                        "${widget.data.visitorTeamScore}/${widget.data.visitorTeamWicket}",
                    textColor: Colors.white70,
                    fontSize: 16,
                    alignment: FractionalOffset.centerLeft,
                    fontWeight: FontWeight.w800,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ContainerConst(
                    shape: BoxShape.circle,
                    width: 30,
                    height: 30,
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.data.visitorTeamImage ?? ""),
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ContainerConst(
            width: 120,
            color: AppColor.primaryRedColor.withOpacity(0.1),
            child: Row(
              children: [
                const TextConst(
                  text: "•  ",
                  textColor: AppColor.activeButtonGreenColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
                TextConst(
                  text: "Completed".toUpperCase(),
                  textColor: AppColor.whiteColor,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          TextConst(
            text: widget.data.note.toString(),
            textColor: AppColor.whiteColor,
            fontWeight: FontWeight.w700,
            fontSize: 10,
          ),
        ],
      ),
    ),
  );



  }
}
