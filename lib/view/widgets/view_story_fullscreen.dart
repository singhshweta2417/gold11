import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';

import '../../utils/utils.dart';
import '../../view_model/basic_app_feature_view_model.dart';

class StoryViewScreen extends StatefulWidget {
  final dynamic args;
  const StoryViewScreen({super.key, this.args});

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late Color _backgroundColor;
  late AnimationController _controller;

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  void initState() {
    super.initState();
    _backgroundColor = getRandomColor();
    _pageController = PageController(
      initialPage: widget.args['initialIndex'] ?? 0,
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      final bafCon = Provider.of<BasicAppFeatureViewModel>(context, listen: false);
      if (_controller.isCompleted) {
        int nextIndex = _pageController.page!.toInt() + 1;
        if (nextIndex < bafCon.homeStoryPromotion!.data!.length) {
          _pageController.animateToPage(
            nextIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
          _controller.reset();
          _controller.forward();
        } else {
          Navigator.pop(context);
        }
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasicAppFeatureViewModel>(
        builder: (context, bafCon, child) {
          if(bafCon.homeStoryPromotion!.data!.isEmpty){
            return Utils.noDataAvailableVector();
          }
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColor.blackColor,
              body: PageView.builder(
                  controller: _pageController,
                  itemCount: bafCon.homeStoryPromotion!.data!.length,
                  itemBuilder: (context, int i) {
                    final storyData = bafCon.homeStoryPromotion!.data![i];
                    return ContainerConst(
                      borderRadius: BorderRadius.circular(15),
                      height: Sizes.screenHeight,
                      width: Sizes.screenWidth,
                      color: _backgroundColor.withOpacity(0.5),
                      image: DecorationImage(
                          image: NetworkImage(storyData.image??""),
                          fit: BoxFit.fitWidth),
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: 70,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(storyData.promoLogo??""),
                          ),
                          title: Container(
                            height: 10,
                            alignment: Alignment.center,
                            child: LinearProgressIndicator(
                              value: _controller.value,
                              minHeight: 2.0,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.grey),
                            ),
                          ),
                          subtitle: SizedBox(
                            height: 30,
                            child: TextConst(
                              text: storyData.type??"",
                              textColor: AppColor.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        }
    );
  }
}
