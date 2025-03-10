import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/view_model/basic_app_feature_view_model.dart';

import '../../../res/sizes_const.dart';

class HomeSliderScreen extends StatelessWidget {
  const HomeSliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BasicAppFeatureViewModel>(builder: (context, bafProvider, child) {
      return bafProvider.homeSlider== null || bafProvider.homeSlider!.data!.isEmpty?const SizedBox.shrink():
      CarouselSlider(
        options: CarouselOptions(
          disableCenter: true,
          height: Sizes.screenHeight/5,
          autoPlay: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayInterval: const Duration(seconds: 5),
          viewportFraction: 0.9,
        ),
        items: bafProvider.homeSlider!.data!.map((match) {
          return Image.network(match.image.toString(),fit: BoxFit.fill,);
        }).toList(),
      );
    });
  }
}
