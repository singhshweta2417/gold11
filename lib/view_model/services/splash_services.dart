import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:gold11/repo/update_apk_repo.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/app_const.dart';
import 'package:gold11/utils/route/app_routes.dart';

class SplashServices with ChangeNotifier {

  Future<bool> _checkUserSessionAndManageNavigation(context) async {
    final sharedPrefViewModel =
        Provider.of<SharedPrefViewModel>(context, listen: false);

    final isUserLoggedIn = await sharedPrefViewModel.isLoggedIn();
    await Future.delayed(const Duration(seconds: 2));
    if (isUserLoggedIn) {
      Navigator.pushReplacementNamed(context, AppRoutes.bottomNavigationScreen);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.languageScreen);
    }

    return isUserLoggedIn;
  }

  double _loading = 0.0;
  double get loading => _loading;

  void setIndicator(double value) {
    _loading = value;
    notifyListeners();
  }

  final _updateApk = UpdateApkRepository();
  Future<void> updateApkApi(context) async {
    _updateApk.updateApkApi().then((value) {
      if (value['status'] == "200") {
        if (value['data']['versions'] != AppConstants.appVersion) {
          _downloadAndInstall(context, value['data']['link']);
        } else {
          _checkUserSessionAndManageNavigation(context);
        }
      } else {
        _checkUserSessionAndManageNavigation(context);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

  void _downloadAndInstall(context, String downloadUrl) async {
    Dio dio = Dio();
    var dir = await getExternalStorageDirectory();
    String filePath = "${dir?.path}/gold11.apk";

    await dio.download(
      downloadUrl,
      filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          double progress = (received / total);
          setIndicator(progress);
        }
      },
    );

    InstallPlugin.installApk(filePath, appId: 'com.fc.gold11').then((result) {
      _checkUserSessionAndManageNavigation(context);
      if (kDebugMode) {
        print('Install result: $result');
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('Install error: $error');
      }
    });
  }
}
