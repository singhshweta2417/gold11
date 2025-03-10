// import 'package:flutter/material.dart';
// import 'package:gold11/res/app_const.dart';
// import 'package:gold11/res/sizes_const.dart';
// import 'package:gold11/view/const_widget/text_const.dart';
//
//
//
// class PageWithListView extends StatelessWidget {
//   // // Sample data for each page
//   // final List<List<String>> pageItems = [
//   //   ['Item 1.1', 'Item 1.2', 'Item 1.3'],
//   //   ['Item 2.1', 'Item 2.2', 'Item 2.3'],
//   //   ['Item 3.1', 'Item 3.2', 'Item 3.3'],
//   // ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leadingWidth: Sizes.screenWidth,
//         leading: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Row(mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Icon(Icons.arrow_back,color: Colors.white,),
//               SizedBox(width: 20,),
//               TextConst(text: "Player Info",textColor: Colors.white,fontWeight: FontWeight.bold,),
//               Spacer(),
//               Container(
//                 height: 24,
//                 width: 24,
//                 decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     border: Border.all(width: 1.5,color: Colors.white),
//                     borderRadius: BorderRadius.circular(15)
//                 ),
//                 child:TextConst(text: "PTS",textColor: Colors.white,fontSize: 10,fontWeight: FontWeight.bold,),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: PageView.builder(
//         // itemCount: pageItems.length,
//         itemCount: 5,
//         itemBuilder: (context, pageIndex) {
//           return Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.all(20),
//                 height: Sizes.screenHeight*0.7,
//                 width: Sizes.screenWidth,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 3,
//                       blurRadius: 5,
//                       offset: Offset(0, 2), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: Sizes.screenHeight*0.15,
//                       width: Sizes.screenWidth,
//                       color: Colors.black,
//                       decoration: BoxDecoration(
//                         borderRadius:
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
