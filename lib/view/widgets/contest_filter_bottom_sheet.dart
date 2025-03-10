import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view_model/contest_view_model.dart';

class ContestFilterBottomSheet extends StatelessWidget {
  const ContestFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContestViewModel>(
      builder: (context, contestProvider, child) {
        final filterByEntry = contestProvider.contestFilterType.contestFilter!.where((e)=> e.type!.toLowerCase()=="entry").toList();
        final filterBySpots = contestProvider.contestFilterType.contestFilter!.where((e)=> e.type!.toLowerCase()=="spots").toList();
        final filterByPrizePool = contestProvider.contestFilterType.contestFilter!.where((e)=> e.type!.toLowerCase()=="prize pool").toList();
        final filterByContestType = contestProvider.contestFilterType.contestFilter!.where((e)=> e.type!.toLowerCase()=="contest type").toList();
        return ContainerConst(
          height: Sizes.screenHeight/1.5,
          alignment: Alignment.topCenter,
          color: AppColor.whiteColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerConst(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  color: AppColor.scaffoldBackgroundColor.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap:(){
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.clear)),
                      const TextConst(
                        text: "Filter",
                        fontWeight: FontWeight.w600,
                      ),
                      TextConst(
                        text: "Clear".toUpperCase(),
                        textColor: AppColor.textGreyColor,
                      ),
                    ],
                  )),
              Sizes.spaceHeight15,
              TextConst(
                text: "Entry",
                fontSize: Sizes.fontSizeOne,
                fontWeight: FontWeight.w600,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 15),
              ),
              Sizes.spaceHeight10,
              ContainerConst(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: List.generate(filterByEntry.length, (i) {
                    return ContainerConst(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColor.scaffoldBackgroundColor),
                      child: Text(
                        filterByEntry[i].value??"",
                        style: TextStyle(fontSize: Sizes.fontSizeOne),
                      ),
                    );
                  }),
                ),
              ),
              Sizes.spaceHeight15,
              const Divider(),
              Sizes.spaceHeight15,
              TextConst(
                text: "Spots",
                fontSize: Sizes.fontSizeOne,
                fontWeight: FontWeight.w600,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 15),
              ),
              Sizes.spaceHeight10,
              ContainerConst(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: List.generate(filterBySpots.length, (i) {
                    return ContainerConst(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColor.scaffoldBackgroundColor),
                      child: Text(
                        filterBySpots[i].value??"",
                        style: TextStyle(fontSize: Sizes.fontSizeOne),
                      ),
                    );
                  }),
                ),
              ),
              Sizes.spaceHeight15,
              const Divider(),
              Sizes.spaceHeight15,
              TextConst(
                text: "Prize Pool",
                fontSize: Sizes.fontSizeOne,
                fontWeight: FontWeight.w600,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 15),
              ),
              Sizes.spaceHeight10,
              ContainerConst(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  alignment: WrapAlignment.start,
                  children: List.generate(filterByPrizePool.length, (i) {
                    return ContainerConst(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColor.scaffoldBackgroundColor),
                      child: Text(
                        filterByPrizePool[i].value??"",
                        style: TextStyle(fontSize: Sizes.fontSizeOne),
                      ),
                    );
                  }),
                ),
              ),
              Sizes.spaceHeight15,
              const Divider(),
              Sizes.spaceHeight15,
              TextConst(
                text: "Contest Type",
                fontSize: Sizes.fontSizeOne,
                fontWeight: FontWeight.w600,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 15),
              ),
              Sizes.spaceHeight10,
              ContainerConst(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Wrap(
                 alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: List.generate(filterByContestType.length, (i) {
                    return ContainerConst(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColor.scaffoldBackgroundColor),
                      child: Text(
                        filterByContestType[i].value??"",
                        style: TextStyle(fontSize: Sizes.fontSizeOne),
                      ),
                    );
                  }),
                ),
              ),
              Sizes.spaceHeight25,
              ButtonConst(label: "apply".toUpperCase(),margin: const EdgeInsets.symmetric(horizontal: 15),onTap: (){
                // filterModel.setFilters([
                //   {'type': 'prizePool', 'value': 10000},
                //   // More filter conditions
                // ]);
              },)
            ],
          ),
        );
      }
    );
  }
}
