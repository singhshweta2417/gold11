import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:gold11/generated/assets.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/view_model/services/splash_services.dart';

import '../../utils/route/app_routes.dart';
import '../const_widget/container_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      final splashServices=Provider.of<SplashServices>(context,listen: false);
      splashServices.updateApkApi(context);
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
    return Scaffold(
        body:  ContainerConst(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      color: AppColor.primaryRedColor,
      image: const DecorationImage(
          image: AssetImage(Assets.assetsSplashLogo,),scale: 2.5
      ),
      child: Consumer<SplashServices>(
          builder: (context, splashViewModel, child) {
            return splashViewModel.loading == 0.0
                ? Container() // Hide progress bar when loading is complete
                : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const Text('Please wait while updating app...',style: TextStyle(fontSize: 15,
                  color: Colors.white,),),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 10),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.black54,
                    valueColor:  const AlwaysStoppedAnimation<Color>(
                        AppColor.blackColor
                    ),
                    value: splashViewModel.loading,
                    minHeight: 10,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          }),
    ));
  }

  Future<bool> _checkUserSessionAndManageNavigation(context) async {
    // Provider.of<GameViewModel>(context, listen: false).getMatchType(context);
    final sharedPrefViewModel =
    Provider.of<SharedPrefViewModel>(context, listen: false);

    final isUserLoggedIn = await sharedPrefViewModel.isLoggedIn();
    await Future.delayed(const Duration(seconds: 2));
    if (isUserLoggedIn) {
      // Navigator.pushReplacementNamed(context, AppRoutes.bottomNavigationScreen);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.languageScreen);
    }

    return isUserLoggedIn;
  }
}
