import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/app_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gold11/view_model/auth_view_model.dart';
import 'package:gold11/view_model/contest_view_model.dart';
import 'package:gold11/view_model/game_view_model.dart';
import 'package:gold11/view_model/basic_app_feature_view_model.dart';
import 'package:gold11/view_model/language_view_model.dart';
import 'package:gold11/view_model/mlm_view_model.dart';
import 'package:gold11/view_model/notification_view_model.dart';
import 'package:gold11/view_model/player_view_model.dart';
import 'package:gold11/view_model/profile_view_model.dart';
import 'package:gold11/view_model/services/bottom_navigation_service.dart';
import 'package:gold11/view_model/services/contest_filter.dart';
import 'package:gold11/view_model/services/notification_service.dart';
import 'package:gold11/view_model/services/player_selection_service.dart';
import 'package:gold11/view_model/services/resend_otp_timer.dart';
import 'package:gold11/view_model/services/splash_services.dart';
import 'package:gold11/view_model/services/team_service.dart';
import 'package:gold11/view_model/wallet_view_model.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  LanguageViewModel languageViewModel = LanguageViewModel();
  Locale languageData = await languageViewModel.loadLanguage();
  runApp(MyApp(languageD: languageData));
}

class MyApp extends StatelessWidget {
  final Locale? languageD;

  const MyApp({super.key, required this.languageD});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LanguageViewModel()),
          ChangeNotifierProvider(create: (_) => PlayerProviderService()),
          ChangeNotifierProvider(create: (_) => WalletViewModel()),
          ChangeNotifierProvider(create: (_) => ResendOtpTimerCountdownController()),
          ChangeNotifierProvider(create: (_) => FilterModel(),),
          ChangeNotifierProvider(create: (_) => TeamService()),
          ChangeNotifierProvider(create: (_) => NotificationProvider()),
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => SharedPrefViewModel()),
          ChangeNotifierProxyProvider<SharedPrefViewModel, ProfileViewModel>(
            create: (_) => ProfileViewModel(),
            update: (context, sharedPrefViewModel, profileViewModel) =>
            profileViewModel!..updateToken(sharedPrefViewModel.userToken),
          ),
          ChangeNotifierProxyProvider<SharedPrefViewModel, GameViewModel>(
            create: (_) => GameViewModel(),
            update: (context, sharedPrefViewModel, profileViewModel) =>
            profileViewModel!..updateToken(sharedPrefViewModel.userToken),
          ),
          ChangeNotifierProvider(create: (_) => ContestViewModel()),
          ChangeNotifierProvider(create: (_) => BottomNavigationViewModel()),
          ChangeNotifierProvider(create: (_) => MlmViewModel()),
          ChangeNotifierProvider(create: (_) => BasicAppFeatureViewModel()),
          ChangeNotifierProxyProvider<SharedPrefViewModel, NotificationViewModel>(
            create: (_) => NotificationViewModel(),
            update: (context, sharedPrefViewModel, profileViewModel) =>
            profileViewModel!..updateToken(sharedPrefViewModel.userToken),
          ),
          ChangeNotifierProvider(create: (context)=> PlayerViewModel()),
          ChangeNotifierProvider(create: (context)=> SplashServices())
        ],
        child: Consumer<LanguageViewModel>(
          builder: (context, provider, child) {
            Sizes.init(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: provider.appLocal ?? languageD,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              supportedLocales: const [Locale('en'), Locale('hi')],
              theme: ThemeData(dividerColor: Colors.transparent),
              title: AppConstants.appName,
              initialRoute: AppRoutes.splash,
              // home: TicTacToeScreen(),
              onGenerateRoute: AppRoutes.generateRoute,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child!,
                );
              },
            );
          },
        ));
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}