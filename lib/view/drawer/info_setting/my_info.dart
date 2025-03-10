import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/appbar_const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gold11/view/const_widget/button_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';
import 'package:gold11/view/drawer/info_setting/logout_bottomsheet.dart';
import 'package:gold11/view_model/profile_view_model.dart';

import '../../const_widget/text_field_const.dart';
import 'data_updated_success_bottomsheet.dart';

class MyProfileInfo extends StatefulWidget {
  final Map<String, dynamic>? args;
  const MyProfileInfo({super.key, this.args});

  @override
  State<MyProfileInfo> createState() => _MyProfileInfoState();
}

class _MyProfileInfoState extends State<MyProfileInfo> {
  @override
  void initState() {
    super.initState();
    if (widget.args!["navigateForm"] == "profileUpdate") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
            context: context,
            builder: (_) {
              return DataSuccessUpdatedBottomSheet(
                args: widget.args!,
              );
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
        builder: (context, profileProvider, child) {
      return Scaffold(
        backgroundColor: AppColor.scaffoldBackgroundColor,
        appBar: AppBarConst(title: AppLocalizations.of(context)!.myInfoSetting),
        body: ContainerConst(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ContainerConst(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    color: AppColor.whiteColor,
                    child: ListTile(
                      title: TextConst(
                        text:
                            AppLocalizations.of(context)!.permissionAndSettings,
                        fontWeight: FontWeight.w600,
                        alignment: FractionalOffset.centerLeft,
                      ),
                      trailing: const Icon(Icons.navigate_next),
                    )),
                Sizes.spaceHeight15,
                ContainerConst(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    color: AppColor.whiteColor,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.appLanguageScreen);
                      },
                      title: TextConst(
                        text: AppLocalizations.of(context)!.appLang,
                        fontWeight: FontWeight.w600,
                        alignment: FractionalOffset.centerLeft,
                      ),
                      trailing: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextConst(
                            text: "(English)",
                            fontWeight: FontWeight.w600,
                          ),
                          Icon(Icons.navigate_next),
                        ],
                      ),
                    )),
                Sizes.spaceHeight15,
                userProfileData(),
                ContainerConst(
                    color: AppColor.whiteColor,
                    child: ListTile(
                      title: TextConst(
                        text: AppLocalizations.of(context)!.manageAccount,
                        fontWeight: FontWeight.w600,
                        alignment: FractionalOffset.centerLeft,
                      ),
                      trailing: const Icon(Icons.navigate_next),
                    )),
                ListTile(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return const LogoutBottomSheet();
                        });
                  },
                  leading: const Icon(CupertinoIcons.power),
                  title: TextConst(
                    text: AppLocalizations.of(context)!.logout.toUpperCase(),
                    fontWeight: FontWeight.w600,
                    alignment: FractionalOffset.centerLeft,
                  ),
                ),
                Sizes.spaceHeight15,
                ButtonConst(
                  onTap: () {
                    profileProvider.updateUserProfile(context);
                  },
                  label:
                      AppLocalizations.of(context)!.updateProfile.toUpperCase(),
                  width: Sizes.screenWidth / 3,
                  color: AppColor.activeButtonGreenColor,
                  height: 35,
                  textColor: AppColor.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
                Sizes.spaceHeight20
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget userProfileData() {
    return Consumer<ProfileViewModel>(
        builder: (context, profileProvider, child) {
      switch (profileProvider.state) {
        case ProfileState.loading:
          return Utils.loadingGreen;
        case ProfileState.error:
          return TextConst(
            text: profileProvider.message,
            textColor: AppColor.blackColor,
            alignment: FractionalOffset.centerLeft,
          );
        case ProfileState.success:
          return ContainerConst(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            color: AppColor.whiteColor,
            child: Column(
              children: [
                myInfoTextField(profileProvider.nameController, "Name"),
                Sizes.spaceHeight25,
                myInfoTextField(profileProvider.emailController, "Email",
                    suffix: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.updateMobileOrEmail,
                              arguments: {
                                "title":
                                    AppLocalizations.of(context)!.enterNewEmail,
                                "label": AppLocalizations.of(context)!.newEmail,
                                "updateType": "Email"
                              });
                        },
                        child: const Icon(Icons.edit_outlined))),
                Sizes.spaceHeight25,
                myInfoTextField(profileProvider.mobileController, "Mobile",
                    suffix: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.updateMobileOrEmail,
                              arguments: {
                                "title": AppLocalizations.of(context)!
                                    .enterNewMobile,
                                "label":
                                    AppLocalizations.of(context)!.newMobile,
                                "updateType": "Mobile"
                              });
                        },
                        child: const Icon(Icons.edit_outlined))),
                Sizes.spaceHeight25,
                InkWell(
                    onTap: () async {
                      final DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate:
                            profileProvider.dobController.text.isNotEmpty
                                ? DateTime.tryParse(
                                        profileProvider.dobController.text) ??
                                    DateTime.now()
                                : DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        profileProvider.dobController.text =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                      }
                    },
                    child: myInfoTextField(
                        profileProvider.dobController, "Date of birth",
                        isEnabled: false)),
                Sizes.spaceHeight25,
                const TextConst(
                  text: "Gender",
                  alignment: FractionalOffset.centerLeft,
                  textColor: AppColor.textGreyColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Radio<Gender>(
                      activeColor: AppColor.activeButtonGreenColor,
                      value: Gender.male,
                      groupValue: profileProvider.selectedGender,
                      onChanged: (Gender? value) {
                        profileProvider.setSelectedGender(value);
                      },
                    ),
                    const TextConst(
                      text: "Male",
                      alignment: AlignmentDirectional.centerStart,
                    ),
                    const Spacer(),
                    Radio<Gender>(
                      activeColor: AppColor.activeButtonGreenColor,
                      value: Gender.female,
                      groupValue: profileProvider.selectedGender,
                      onChanged: (Gender? value) {
                        profileProvider.setSelectedGender(value);
                      },
                    ),
                    const TextConst(
                      text: "Female",
                      alignment: AlignmentDirectional.centerStart,
                    ),
                    const Spacer(),
                    Radio<Gender>(
                      activeColor: AppColor.activeButtonGreenColor,
                      value: Gender.others,
                      groupValue: profileProvider.selectedGender,
                      onChanged: (Gender? value) {
                        profileProvider.setSelectedGender(value);
                      },
                    ),
                    const TextConst(
                      text: "Other",
                      alignment: AlignmentDirectional.centerStart,
                    ),
                  ],
                ),
              ],
            ),
          );
        default:
          return const TextConst(
            text: "Loading...",
            textColor: AppColor.whiteColor,
            alignment: FractionalOffset.centerLeft,
          );
      }
    });
  }

  Widget myInfoTextField(TextEditingController controller, String labelText,
      {Widget? suffix, bool isEnabled = true}) {
    return TextFieldConst(
      enabled: isEnabled,
      fillColor: AppColor.scaffoldBackgroundColor,
      filled: true,
      controller: controller,
      fieldRadius: const BorderRadius.only(
          topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      contentPadding:
          const EdgeInsets.only(top: 5, bottom: 3, left: 10, right: 10),
      borderSide: const BorderSide(),
      borderSideFocus: const BorderSide(),
      label: TextConst(
        text: labelText,
        alignment: Alignment.centerLeft,
        textColor: AppColor.textGreyColor,
      ),
      fontWeight: FontWeight.w500,
      sufixIcon: suffix,
    );
  }
}
