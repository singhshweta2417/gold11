// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../res/color_const.dart';
// import '../../res/sizes_const.dart';
// import '../../view_model/contest_view_model.dart';
// import '../const_widget/container_const.dart';
// import '../const_widget/text_const.dart';
//
// class ContestLeaderboardList extends StatelessWidget {
//   const ContestLeaderboardList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ContestViewModel>(
//         builder: (context, contestProvider, child) {
//       return ListView.builder(
//           itemCount: leaderBoardList.length,
//           itemBuilder: (context, i) {
//             final leader = leaderBoardList[i];
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 7),
//               child: ListTile(
//                 leading: ContainerConst(
//                   height: 50,
//                   width: 50,
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                       image: NetworkImage(
//                         leader["profile_image"].toString(),
//                       ),
//                       fit: BoxFit.cover),
//                 ),
//                 title: Row(
//                   children: [
//                     TextConst(
//                       text: leader["name"].toString(),
//                       alignment: Alignment.centerLeft,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     Sizes.spaceWidth5,
//                     ContainerConst(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 6, vertical: 2),
//                       borderRadius: BorderRadius.circular(5),
//                       color: AppColor.scaffoldBackgroundColor,
//                       child: Text(
//                         leader["team"].toString(),
//                         style: TextStyle(
//                             fontSize: Sizes.fontSizeOne,
//                             color: AppColor.textGreyColor),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           });
//     });
//   }
// }
