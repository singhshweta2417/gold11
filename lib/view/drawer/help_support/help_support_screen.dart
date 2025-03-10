import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../res/color_const.dart';
import '../../../res/sizes_const.dart';
import '../../const_widget/container_const.dart';
import '../../const_widget/text_const.dart';


class HelpAndSupportScreen extends StatefulWidget {
   const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  final List<Map<String, String>> faqData = [
    {
      'question': 'How do I withdraw my winnings?',
      'answer': 'To withdraw your winnings, you must have a verified account. To verify, go to Profile > My Balance > Verify to Withdraw and follow the steps thereafter. Once verified, go to Profile > My Balance > Withdraw. Enter the amount you wish to withdraw and that\'s it.'
    },
    {
      'question': 'I can\'t see my added money, what should I do?',
      'answer': 'If you can\'t see your added money, please check your transaction history or contact support for assistance.'
    },
    {
      'question': 'My PAN/Bank verification was rejected. What do I do?',
      'answer': 'If your PAN/Bank verification was rejected, please ensure that all the details you provided are correct and try again. If the issue persists, contact support.'
    },
    {
      'question': 'How do I unlink PAN Card?',
      'answer': 'To unlink your PAN Card, go to Profile > PAN Card > Unlink. Follow the instructions provided.'
    },
    {
      'question': 'How do I verify the points given to my team?',
      'answer': 'To verify the points given to your team, go to the Points section in your Profile and check the detailed points breakdown.'
    },
    {
      'question': 'What should I do if I encounter a technical issue?',
      'answer': 'If you encounter a technical issue, there are several steps you can take to try to resolve the problem:\n\n'
          '1. **Restart the App**: Sometimes, simply restarting the app can resolve temporary issues.\n\n'
          '2. **Check for Updates**: Ensure that you are using the latest version of the app. Check the app store for any available updates and install them.\n\n'
          '3. **Clear Cache**: Clearing the app cache can help resolve performance issues. Go to your device settings, find the app, and clear its cache.\n\n'
          '4. **Reinstall the App**: Uninstalling and reinstalling the app can help fix persistent issues. Make sure to back up any important data before doing this.\n\n'
          '5. **Check Internet Connection**: Ensure that you have a stable internet connection. Try switching between Wi-Fi and mobile data to see if the issue persists.\n\n'
          '6. **Contact Support**: If none of the above steps work, contact our support team. Provide as much detail as possible about the issue, including any error messages you received and the steps you took before encountering the problem.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.scaffoldBackgroundColor,
        appBar: appBarDesign(context),
    body: Column(
      children: [
        Sizes.spaceHeight15,
        recentActivity(),
        Sizes.spaceHeight25,
        mostAskedQuestions(),
        Sizes.spaceHeight25,
        viewPastTickets(),
      ],
    ),
    );

  }

  PreferredSizeWidget appBarDesign(context) {
    return AppBar(
      elevation: 0,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: ContainerConst(
            color: AppColor.whiteColor,
            gradient: AppColor.darkRedToBlackGradient,
            height: kToolbarHeight,
            // child: ListTile(leading: IconButton(onPressed: (){},icon: const Icon(Icons.arrow_back, color: AppColor.whiteColor,),),title: TextConst(text:AppLocalizations.of(context)!.helpSupport,textColor: AppColor.whiteColor,fontSize: Sizes.fontSizeLarge/1.25,alignment: FractionalOffset.centerLeft,fontWeight: FontWeight.w600,),contentPadding: EdgeInsets.all(0),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColor.whiteColor,
                  ),
                ),
                Sizes.spaceWidth20,
                TextConst(
                  text: AppLocalizations.of(context)!.helpSupport,
                  textColor: AppColor.whiteColor,
                  fontSize: Sizes.fontSizeLarge / 1.25,
                  alignment: FractionalOffset.centerLeft,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          )),
    );
  }

  Widget mostAskedQuestions(){
    return ContainerConst(
      color: AppColor.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          TextConst(text: AppLocalizations.of(context)!.mostAskedQues, alignment: FractionalOffset.centerLeft,fontSize: Sizes.fontSizeThree,fontWeight: FontWeight.w600,),
          Sizes.spaceHeight10,
          ListView.builder(
            shrinkWrap: true,
            itemCount: faqData.length,
            itemBuilder: (context, index) {
              return ContainerConst(
                border: Border(
                  bottom: BorderSide(width: 1, color: AppColor.scaffoldBackgroundColor)
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: TextConst(text:faqData[index]['question']!, alignment: FractionalOffset.centerLeft,),
                  onTap: () => _showAnswerBottomSheet(context, faqData[index]['question']!, faqData[index]['answer']!),
                ),
              );
            },
          ),
          const ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Icon(Icons.menu),
            title: TextConst(text: "Browse all topics",alignment: FractionalOffset.centerLeft,fontWeight: FontWeight.w600,),
            trailing: Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }

  Widget recentActivity(){
    return const ContainerConst(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      color: AppColor.whiteColor,
      child: Column(
        children: [
          TextConst(text: "No recent activity yet to show",fontWeight: FontWeight.w600,),
          Sizes.spaceHeight10,
          TextConst(text: "All the activities related to deposits and withdrawals will be shown here",textAlign: TextAlign.center,),
        ],
      ),
    );
  }

  Widget viewPastTickets(){
    return Container(
      color: AppColor.whiteColor,
      child: const ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        title: TextConst(text: "View past tickets",alignment: FractionalOffset.centerLeft,fontWeight: FontWeight.w600,),
        trailing: Icon(Icons.navigate_next),
      ),
    );
  }

  void _showAnswerBottomSheet(BuildContext context, String question, String answer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ContainerConst(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(20),
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.clear_sharp,size: 35,)),
              Divider(color: AppColor.scaffoldBackgroundColor,),
              TextConst(text: question,
                fontWeight: FontWeight.w600,
                fontSize: Sizes.fontSizeThree,
                alignment: FractionalOffset.centerLeft,
              ),
             Sizes.spaceHeight10,
              TextConst(
               text: answer,
               fontSize: Sizes.fontSizeOne,
               alignment: FractionalOffset.centerLeft,
              ),
              const SizedBox(height: 16),
               Divider(color: AppColor.scaffoldBackgroundColor,),
              ContainerConst(
                color:Colors.grey.shade200.withOpacity(0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     const TextConst(
                       padding: EdgeInsets.only(left: 10),
                      text:'Was this helpful?',
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.thumb_up_alt_outlined),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.thumb_down_alt_outlined),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
