import 'package:flutter/material.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/appbar_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';

class InvitationRulesScreen extends StatefulWidget {
  const InvitationRulesScreen({super.key});

  @override
  State<InvitationRulesScreen> createState() => _InvitationRulesScreenState();
}

class _InvitationRulesScreenState extends State<InvitationRulesScreen> {
  final List<String> rules = [
    "Ensure all data entries are completed accurately and timely.",
    "Maintain a clean and organized workspace at all times.",
    "Follow all company safety protocols and procedures.",
    "Respect the privacy and confidentiality of client information.",
    "Submit all reports and documents by the designated deadlines.",
    "Participate in mandatory training sessions and workshops.",
    "Adhere to the company's dress code and grooming standards.",
    "Use company resources responsibly and for work-related purposes only.",
    "Report any suspicious activity or security breaches immediately.",
    "Maintain professional and respectful communication with colleagues and clients.",
    "Avoid conflicts of interest and disclose any potential conflicts to management.",
    "Comply with all local, state, and federal regulations relevant to your role.",
    "Participate in team meetings and contribute to group discussions.",
    "Ensure that all customer interactions are conducted with integrity and honesty.",
    "Regularly review and update personal and professional development plans.",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: const AppBarConst(title: "Invitation rules",appBarColor: AppColor.primaryRedColor,),
      body: ContainerConst(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextConst(text: '【Privacy Agreement】 program',textColor: AppColor.primaryRedColor,fontSize: Sizes.fontSizeThree,fontWeight: FontWeight.w600,),
              Sizes.spaceHeight10,
              const TextConst(text: 'This activity is valid for long time',textColor: AppColor.textGreyColor,),
              Sizes.spaceHeight20,
              rulesListing(),
            ],
          ),
        ),
      ),
    );
  }
  Widget rulesListing(){
    return ListView.builder(
        physics:const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      shrinkWrap: true,
        itemCount: rules.length,
        itemBuilder: (_, int i){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ContainerConst(
          border: Border.all(
            color: Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(10),
          padding: const EdgeInsets.all(4),
          child: ContainerConst(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  const Color(0xffe3f9e7).withOpacity(0.5),
                  const Color(0xffe3f9e7).withOpacity(0.1),
                  const Color(0xffe3f9e7).withOpacity(0.1),
                  const Color(0xffe3f9e7).withOpacity(0.1),
                ]),
            child: ListTile(
              title: TextConst(text: "Rule 0${i+1}",alignment: Alignment.centerLeft,textColor: AppColor.textGreyColor,fontWeight: FontWeight.w600,),
              subtitle: TextConst(text: rules[i],alignment: Alignment.centerLeft,),
            ),
          ),
        ),
      );
    });
  }
}
