import 'package:flutter/material.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/sheemar/shimmer_code.dart';

class ContestShimmer extends StatefulWidget {
  const ContestShimmer({super.key});

  @override
  _ContestShimmerState createState() => _ContestShimmerState();
}

class _ContestShimmerState extends State<ContestShimmer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    const horizontalPadding = EdgeInsets.symmetric(horizontal: 20);
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 6.0),
      itemCount: 5, // Number of items in the list
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: horizontalPadding,
            child: buildCustomShimmerContainer(context),
          ),
        );
      },
    );
  }

  buildCustomShimmerContainer(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: listData(),
    );
  }

  listData() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomShimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade200,
                    child: Container(
                      height: 15,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  Sizes.spaceHeight20,
                  CustomShimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade200,
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomShimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade200,
                    child: Container(
                      height: 15,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  Sizes.spaceHeight20,
                  CustomShimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade200,
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Sizes.spaceHeight20,
          CustomShimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade200,
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.grey.shade300,
              ),
            ),
          ),
          Sizes.spaceHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomShimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade200,
                child: Container(
                  height: 15,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              CustomShimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade200,
                child: Container(
                  height: 15,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ],
          ),
          Sizes.spaceHeight20,
          Container(
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: AppColor.scaffoldBackgroundColorTwo.withOpacity(0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Icon(
                    Icons.looks_one_outlined,
                    color: Colors.grey.shade300,
                  ),
                  CustomShimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade200,
                    child: Container(
                      width: 60,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  Sizes.spaceWidth10,
                  Icon(
                    Icons.emoji_events_outlined,
                    color: Colors.grey.shade300,
                  ),
                  CustomShimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade200,
                    child: Container(
                      width: 40,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  Sizes.spaceWidth10,
                  Icon(
                    Icons.airplane_ticket_outlined,
                    color: Colors.grey.shade300,
                  ),
                  CustomShimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade200,
                    child: Container(
                      width: 90,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  Sizes.spaceWidth10,
                  CustomShimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade200,
                    child: Container(
                      width: 20,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
