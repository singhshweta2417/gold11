import 'package:flutter/material.dart';
import 'package:gold11/res/sliding_animation.dart';
import 'package:gold11/view/auth/login_screen.dart';
import 'package:gold11/view/auth/other_login_screen.dart';
import 'package:gold11/view/auth/otp_screen.dart';
import 'package:gold11/view/auth/register_screen.dart';
import 'package:gold11/view/contest/contest_detail.dart';
import 'package:gold11/view/contest/contest_screen.dart';
import 'package:gold11/view/drawer/how_to_play/how_to_play_game_type_screen.dart';
import 'package:gold11/view/drawer/how_to_play/how_to_play_screen.dart';
import 'package:gold11/view/drawer/info_setting/app_setting_language.dart';
import 'package:gold11/view/drawer/info_setting/view_profile_screen.dart';
import 'package:gold11/view/home_screen.dart';
import 'package:gold11/view/initial_pages/intro_screen.dart';
import 'package:gold11/view/initial_pages/language_screen.dart';
import 'package:gold11/view/mlm/customer_service_screen.dart';
import 'package:gold11/view/mlm/invitation_rules_screen.dart';
import 'package:gold11/view/mlm/new_subordinate_screen.dart';
import 'package:gold11/view/mlm/promotion_screen.dart';
import 'package:gold11/view/mlm/referral_list_screen.dart';
import 'package:gold11/view/mlm/sub_ordinate_screen.dart';
import 'package:gold11/view/notification/notification_screen.dart';
import 'package:gold11/view/initial_pages/splash_screen.dart';
import 'package:gold11/view/team/choose_c_vc_screen.dart';
import 'package:gold11/view/team/create_team_screen.dart';
import 'package:gold11/view/team/past_lineup_screen.dart';
import 'package:gold11/view/team/select_team_screen.dart';
import 'package:gold11/view/wallet/add_bank_account_screen.dart';
import 'package:gold11/view/wallet/add_cash_screen.dart';
import 'package:gold11/view/wallet/my_balance_screen.dart';
import 'package:gold11/view/wallet/my_transactions_screen.dart';
import 'package:gold11/view/wallet/picked_image_view_screen.dart';
import 'package:gold11/view/wallet/verify_details.dart';
import 'package:gold11/view/wallet/withdraw_cash_screen.dart';

import '../../view/bottom_navigation/bottom_navigation_screen.dart';
import '../../view/drawer/more_setting/common_tc_pp_au_screen.dart';
import '../../view/drawer/help_support/help_support_screen.dart';
import '../../view/drawer/info_setting/mobile_email_update.dart';
import '../../view/drawer/info_setting/my_info.dart';
import '../../view/drawer/info_setting/verify_update_mobile_email.dart';
import '../../view/drawer/more_setting/more_setting_screen.dart';
import '../../view/widgets/view_story_fullscreen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String languageScreen = '/languageScreen';
  static const String introScreen = '/introScreen';
  static const String loginScreen = '/loginScreen';
  static const String otherLoginOptionScreen = '/otherLoginOptionScreen';
  static const String verifyOTPScreen = '/verifyOTPScreen';
  static const String userRegistrationScreen = '/userRegistrationScreen';
  static const String homeScreen = "/homeScreen";
  static const String myProfileInfo = "/myProfileInfo";
  static const String updateMobileOrEmail = "/updateMobileOrEmail";
  static const String verifyOtpForUpdateMobileOrEmail =
      "/verifyOtpForUpdateMobileOrEmail";
  static const String helpAndSupportScreen = "/helpAndSupportScreen";
  static const String bottomNavigationScreen = "/bottomNavigationScreen";
  static const String contestScreen = "/contestScreen";
  static const String contestDetailScreen = "/contestDetailScreen";
  static const String createTeamScreen = "/createTeamScreen";
  static const String chooseTeamCAndVC = "/chooseTeamCAndVC";
  static const String pastLineUpScreen = "/pastLineUpScreen";
  static const String notificationScreen = "/notificationScreen";
  static const String walletAddCashScreen = "/walletAddCashScreen";
  static const String walletVerifyDetailsScreen = "/walletVerifyDetailsScreen";
  static const String walletViewSelectedImage = "/walletViewSelectedImage";
  static const String mlmHomeScreen = "/mlmHomeScreen";
  static const String mlmSubordinateScreen = "/mlmSubordinateScreen";
  static const String mlmInvitationRuleScreen = "/mlmInvitationRuleScreen";
  static const String mlmCustomerServiceScreen = "/mlmCustomerServiceScreen";
  static const String mlmNewSubordinateScreen = "/mlmNewSubordinateScreen";
  static const String mlmReferralListScreen = "/mlmReferralListScreen";
  static const String walletMyBalanceScreen = "/walletMyBalanceScreen";
  static const String walletMyTransactionScreen = "/walletMyTransactionScreen";
  static const String howToPlayDataScreen = "/drawerHowToPlayScreen";
  static const String appLanguageScreen = "/appLanguageScreen";
  static const String viewProfileScreen = "/viewProfileScreen";
  static const String walletWithdrawAmount = "/walletWithdrawAmount";
  static const String howToPlayGameTypeScreen = "/HowToPlayGameTypeScreen";
  static const String commonSettingScreen = "/commonSettingScreen";
  static const String moreSettingScreen = "/moreSettingScreen";
  static const String fullPageStoryScreen = "/fullPageStoryScreen";
  static const String addBankAccountScreen = "/addBankAccountScreen";
  static const String selectTeamScreen = "/selectTeamScreen";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case languageScreen:
        return MaterialPageRoute(
            builder: (_) => const LanguageSelectionScreen());
      case introScreen:
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case otherLoginOptionScreen:
        return CustomSlidePageRoute(page: const OtherLoginScreen());
      case verifyOTPScreen:
        return CustomSlidePageRoute(page: const VerifyOTPScreen());
      case userRegistrationScreen:
        return CustomSlidePageRoute(page: const RegisterScreen());
      case homeScreen:
        return CustomSlidePageRoute(page: const HomeScreen());
      case myProfileInfo:
        final args = settings.arguments as Map<String, dynamic>;
        return CustomSlidePageRoute(
            page: MyProfileInfo(
          args: args,
        ));
      case updateMobileOrEmail:
        final args = settings.arguments as Map<String, dynamic>;
        return CustomSlidePageRoute(page: ChangeMobileNoOrEmail(args: args));
      case verifyOtpForUpdateMobileOrEmail:
        final args = settings.arguments as Map<String, dynamic>;
        return CustomSlidePageRoute(
            page: VerifyOtpForUpdateMobileOrEmail(
          args: args,
        ));
      case helpAndSupportScreen:
        return CustomSlidePageRoute(page: const HelpAndSupportScreen());
      // tab screens
      case bottomNavigationScreen:
        return CustomSlidePageRoute(page: const BottomNavigationScreen());
      case contestScreen:
        if (settings.arguments != null) {
          final args = settings.arguments as Map<String, dynamic>;
          return CustomSlidePageRoute(
              page: ContestScreen(
            args: args,
          ));
        } else {
          return CustomSlidePageRoute(page: const ContestScreen());
        }
      case contestDetailScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return CustomSlidePageRoute(page: ContestDetailScreen(args: args, data: null));
      case createTeamScreen:
        if (settings.arguments != null) {
          final args = settings.arguments as Map<String, dynamic>;
          return CustomSlidePageRoute(page: CreateTeamScreen(args: args));
        } else {
          return CustomSlidePageRoute(page: const CreateTeamScreen(args: null));
        }
      case chooseTeamCAndVC:
        return CustomSlidePageRoute(page: const ChooseCAndVCScreen());
      case pastLineUpScreen:
        return CustomSlidePageRoute(page: PastLineUpPlayersScreen());
      case notificationScreen:
        return CustomSlidePageRoute(page: const NotificationScreen());
      case walletAddCashScreen:
        return CustomSlidePageRoute(page: const AddCashScreen());
      case walletVerifyDetailsScreen:
        return CustomSlidePageRoute(page: const VerifyDetailsScreen());
      case walletViewSelectedImage:
        return CustomSlidePageRoute(page: const PickedImageViewScreen());
      case mlmHomeScreen:
        return CustomSlidePageRoute(page: const PromotionScreen());
      case mlmSubordinateScreen:
        return CustomSlidePageRoute(page: const SubOrdinateScreen());
      case mlmInvitationRuleScreen:
        return CustomSlidePageRoute(page: const InvitationRulesScreen());
      case mlmCustomerServiceScreen:
        return CustomSlidePageRoute(page: const CustomerServiceScreen());
      case mlmNewSubordinateScreen:
        return CustomSlidePageRoute(page: const NewSubordinateScreen());
      case mlmReferralListScreen:
        return CustomSlidePageRoute(page: const ReferralListScreen());
      case walletMyBalanceScreen:
        return CustomSlidePageRoute(page: const MyBalanceScreen());
      case walletMyTransactionScreen:
        return CustomSlidePageRoute(page: const MyTransactionsScreen());
      case howToPlayDataScreen:
        return CustomSlidePageRoute(page: const HowToPlayScreen());
      case appLanguageScreen:
        return CustomSlidePageRoute(page: const AppLanguageSelectionScreen());
      case viewProfileScreen:
        return CustomSlidePageRoute(page: const ViewProfileScreen());
      case walletWithdrawAmount:
        return CustomSlidePageRoute(page: const WithdrawCashScreen());
      case howToPlayGameTypeScreen:
        return CustomSlidePageRoute(page: const HowToPlayGameTypeScreen());
      case commonSettingScreen:
        return CustomSlidePageRoute(page: const CommonTcPpAuScreen());
      case moreSettingScreen:
        return CustomSlidePageRoute(page: const MoreSettingScreen());
      case fullPageStoryScreen:
        if (settings.arguments != null) {
          final args = settings.arguments as Map<String, dynamic>?;
          return CustomSlidePageRoute(page: StoryViewScreen(args: args));
        } else {
          return CustomSlidePageRoute(page: const StoryViewScreen(args: null));
        }
      case addBankAccountScreen:
        return CustomSlidePageRoute(page:  const AddBankAccountScreen());
      case selectTeamScreen:
        return CustomSlidePageRoute(page:  const SelectTeamScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
