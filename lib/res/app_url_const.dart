class AppApiUrls {
  // Base Api config...
  static const String domainUrl = "https://gold11.co.in/";
  // static const String domainUrl = "https://gold11.co.in/";
  static const String liveMatchSocket = "wss://gold11.co.in/socket?fixture_id=";
  static const String apiPath = "api/";
  static const String baseUrl = "$domainUrl$apiPath";

  // Auth end points...
  static const String loginApiEndPoint = "${baseUrl}user/login";
  static const String sendOtpApiEndPoint = "${baseUrl}send_otp/";
  static const String verifyOtpApiEndPoint = "${baseUrl}verify_otp/";
  static const String registerApiEndPoint = "${baseUrl}user/signup";
  static const String checkReferralApiEndPoint = "${baseUrl}check/invite_cupon";

  // user profile end points...
  static const String userProfileApiEndPoint = "${baseUrl}get_profile/";
  static const String userBasicProfileDetailUpdateApiEndPoint =
      "${baseUrl}update/profile";
  static const String userContactDetailUpdateApiEndPoint =
      "${baseUrl}update/email_mobile";
  static const String userProfileImageUpdateApiEndPoint =
      "${baseUrl}updateProfileImage";

  // wallet api end points...
  static const String addAmountApiEndPoint = "${baseUrl}user/add_wallet";
  static const String transactionTypeApiEndPoint =
      "${baseUrl}get/transactions_type";
  static const String userTransactionsApiEndPoint =
      "${baseUrl}get/transactions/";
  static const String userWithdrawalApiEndPoint = "${baseUrl}user/withdrawal";
  static const String addAccountApiEndPoint = "${baseUrl}add/bank_details";
  static const String getAccountsApiEndPoint = "${baseUrl}get/bank_details";
  static const String uploadDocsApiEndPoint = "${baseUrl}user/doc_verify";

  // home screen--> bottom navigation
  static const String getGameTypeApiEndPoint = "${baseUrl}get/games";
  static const String getGameDataApiEndPoint = "${baseUrl}my/matches/";
  static const String getMatchTypeApiEndPoint = "${baseUrl}get/match_status";
  static const String getHomeScreenBannerApiEndPoint = "${baseUrl}get/banner";
  static const String getHomeScreenPromoStoryApiEndPoint =
      "${baseUrl}get/promo/banner";

  static const String getContestApiEndPoint = "${baseUrl}match_details";
  static const String getContestFiltersApiEndPoint =
      "${baseUrl}contest/filterType";
  static const String getContestDetailApiEndPoint =
      "${baseUrl}contest/details/";
  static const String getLiveMatchLeaderBoard = "${baseUrl}get/leaderboard/";
  static const String getLiveTeamState = "${baseUrl}get/team_state/";

  // mlm api end points..
  static const String getReferralDataApiEndPoint = "${baseUrl}my_refereral";
  static const String getUserPromotionDataApiEndPoint =
      "${baseUrl}my_yesterday_refereral";
  static const String getReferralDataOnFilterApiEndPoint =
      "${baseUrl}my_tear_wise_subordinatedata";

  // how to play end points...
  static const String howToPlayDataApiEndPoint = "${baseUrl}get/how_to_play/";
  static const String commonSettingApiEndPoint = "${baseUrl}get/settings/";

  // notification api end point...
  static const String notificationApiEndPoint = "${baseUrl}get/notification/";
  static const String viewNotificationApiEndPoint =
      "${baseUrl}save/viewed/notification";

  // player api end points..
  static const String playersApiEndPoint = "${baseUrl}get/players_by_series";
  static const String playerDesignationApiEndPoint =
      "${baseUrl}get/designations";
  static const String saveTeamApiEndPoint = "${baseUrl}create/team";
  static const String updateTeamApiEndPoint = "${baseUrl}update/team";
  static const String getTeamApiEndPoint = "${baseUrl}get/myteam";
  static const String joinContestApiEndPoint = "${baseUrl}join/contest";

  /// update apk
  static const String updateApk = "${baseUrl}get/app_version";

  ////
  static const String liveTeamPreview = "${baseUrl}get/usersteam";
  static const String versionUpdate = "${baseUrl}get/app_version";
  static const String playerInfo = "${baseUrl}get/playerinfo/";
  static const String allPlayerInfo = "${baseUrl}get/allplayerinfo";
  static const String scoreboards = "${baseUrl}get/scoreboards";
}
