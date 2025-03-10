import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/model/common_api_response.dart';
import 'package:gold11/model/verify_otp_model.dart';
import 'package:gold11/res/shared_preferences_util.dart';
import 'package:gold11/res/app_const.dart';
import 'package:gold11/utils/route/app_routes.dart';
import 'package:gold11/view_model/profile_view_model.dart';

import '../model/otp_response_model.dart';
import '../repo/auth_repo.dart';
import '../utils/utils.dart';

enum AuthState { idle, loading, success, error }

class AuthViewModel extends ChangeNotifier {
  final AuthApiService _authApiService = AuthApiService();
  final mobileNumberController = TextEditingController();
  final nameController = TextEditingController();
  final otpController = TextEditingController();
  final referralCodeController = TextEditingController();
  AuthState _state = AuthState.idle;
  String _message = '';
  bool _isAbove18 = false;
  bool _couponApplied = false;

  AuthState get state => _state;
  String get message => _message;
  bool get isAbove18 => _isAbove18;
  bool get couponApplied => _couponApplied;

  void setIsAbove18(bool value) {
    _isAbove18 = value;
    notifyListeners();
  }

  void _setState(AuthState state) {
    _state = state;
    notifyListeners();
  }

  void _clearOtpController() {
    otpController.clear();
    notifyListeners();
  }

  void _clearNumberController() {
    mobileNumberController.clear();
    notifyListeners();
  }

  void _clearNameController() {
    nameController.clear();
    notifyListeners();
  }

  AuthViewModel() {
    mobileNumberController.addListener(_onMobileNumberChange);
    otpController.addListener(_otpNumberChange);
    nameController.addListener(_nameController);
    referralCodeController.addListener(
      _referralCodeController,
    );
  }

  void _onMobileNumberChange() {
    notifyListeners();
  }

  void _otpNumberChange() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      notifyListeners();
    });
  }

  void _nameController() {
    notifyListeners();
  }

  void _referralCodeController() {
    notifyListeners();
  }

  Future<void> login() async {
    _setState(AuthState.loading);
    try {
      final CommonApiResponse response =
          await _authApiService.login(mobileNumberController.text.trim());
      _message = response.message;
    } catch (e) {
      _message = 'Login failed: $e';
      _setState(AuthState.error);
    }
  }

  Future<void> sendOtp(context) async {
    try {
      final OtpResponse response = await _authApiService.sendOtp(
          mobileNumberController.text.trim(), AppConstants.otpApiTypeLogin);
      _message = response.message;
      _setState(AuthState.success);
      Navigator.pushNamed(context, AppRoutes.verifyOTPScreen);
      Utils.showSuccessMessage(context, _message);
    } catch (e) {
      _message = 'Send OTP failed: $e';
      _setState(AuthState.error);
    }
  }

  Future<void> verifyOtp(context, String userToken) async {
    _setState(AuthState.loading);
    try {
      final VerifyOtpModel response = await _authApiService.verifyOtp(
          mobileNumberController.text.trim(),
          otpController.text.trim(),
          "${AppConstants.verifyOtpApiWithApplyCoupon}${referralCodeController.text.trim()}");
      _message = response.message;
      if (response.status == "200") {
        Provider.of<SharedPrefViewModel>(context, listen: false)
            .setUserToken(response.data["id"].toString());
        Provider.of<SharedPrefViewModel>(context, listen: false)
            .setUserToken(response.data["id"].toString());
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.bottomNavigationScreen,
          (route) => false,
        );
        Utils.showSuccessMessage(context, _message);
        _clearOtpController();
        _clearNumberController();
      } else if (response.status == "300") {
        Utils.showErrorMessage(context, _message);
      } else {
        _clearOtpController();
        Provider.of<SharedPrefViewModel>(context, listen: false)
            .setUserToken(response.data["id"].toString());
        Navigator.pushNamed(context, AppRoutes.userRegistrationScreen);
        Utils.showErrorMessage(context, _message);
      }
      _setState(AuthState.success);
    } catch (e) {
      _message = 'Verify OTP failed: $e';
      _setState(AuthState.error);
    }
    notifyListeners();
  }

  Future<void> register(context) async {
    _setState(AuthState.loading);
    try {
      final CommonApiResponse response = await _authApiService.register(
          nameController.text,
          mobileNumberController.text.trim(),
          referralCodeController.text.trim());
      _message = response.message;
      _setState(AuthState.success);
      if (response.status == "200") {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.bottomNavigationScreen,
              (route) => false,
        );
        Utils.showSuccessMessage(context, _message);
        _clearNumberController();
        _clearNameController();
        _clearOtpController();
      } else {
        Utils.showErrorMessage(context, _message);
      }
    } catch (e) {
      _message = 'register failed: $e';
      _setState(AuthState.error);
    }
  }

  Future<void> checkReferralCoupon(context) async {
    if (referralCodeController.text.length > 4) {
      _setState(AuthState.loading);
      try {
        final response = await _authApiService.checkReferralCoupon(
            referralCodeController.text.trim().toUpperCase());
        _message = response["msg"];
        _setState(AuthState.success);
        if (response["status"] == "200") {
          _couponApplied = true;
          Navigator.pop(context);
          Utils.showSuccessMessage(context, _message);
        } else {
          Utils.showErrorMessage(context, _message);
        }
        notifyListeners();
      } catch (e) {
        _message = 'Invalid code: $e';
        _setState(AuthState.error);
      }
    } else {
      Utils.showErrorMessage(context, "Please enter valid invite code");
    }
  }

  void logout(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SharedPrefViewModel>(context, listen: false)
          .removeUserToken();
      Provider.of<ProfileViewModel>(context, listen: false).clearUserProfile();
      _clearOtpController();
      _clearNumberController();
      _clearNameController();
      notifyListeners();
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.loginScreen,
        (route) => false,
      );
    });
  }
}
