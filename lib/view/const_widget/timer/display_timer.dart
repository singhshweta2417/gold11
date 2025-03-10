
import 'package:flutter/material.dart';
import 'package:gold11/view/const_widget/timer/timer_class.dart';
import '../../../res/sizes_const.dart';
import '../text_const.dart';


class LiveTimeDisplay extends StatelessWidget {
  final LiveTime liveTime = LiveTime();

  LiveTimeDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: liveTime.getTimeStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return TextConst(
              text: "${snapshot.data}",
              textColor: Colors.white,
              fontSize: Sizes.fontSizeTwo,
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
