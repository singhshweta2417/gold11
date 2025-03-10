
import 'package:gold11/model/verify_otp_model.dart';
import 'package:gold11/res/app_url_const.dart';

import '../helper/network/network_api_services.dart';
import '../model/common_api_response.dart';
import '../model/otp_response_model.dart';


class AuthApiService {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<CommonApiResponse> login(String mobile) async {
    final data = {'mobile': mobile};
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.loginApiEndPoint, data);
      return CommonApiResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<OtpResponse> sendOtp(String mobile, String type) async {
    try {
      final response = await _apiServices.getGetApiResponse("${AppApiUrls.sendOtpApiEndPoint}$mobile/$type");
      return OtpResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<VerifyOtpModel> verifyOtp(String mobile, String otp, String type) async {
    try {
      final response = await _apiServices.getGetApiResponse("${AppApiUrls.verifyOtpApiEndPoint}$mobile/$otp/$type");
      return VerifyOtpModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse> register(String name,String mobile,String referralCode) async {
    final data = {'name': name,'mobile':mobile,'cupon':referralCode};
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.registerApiEndPoint, data);
      return CommonApiResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> checkReferralCoupon(String referralCode) async {
    final data = {'cupon':referralCode};
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.checkReferralApiEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
