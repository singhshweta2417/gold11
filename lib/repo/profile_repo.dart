import 'package:gold11/model/common_api_response.dart';
import 'package:gold11/model/user_profile_model.dart';

import '../helper/network/network_api_services.dart';
import '../model/otp_response_model.dart';
import '../res/app_url_const.dart';

class ProfileApiService{
  final NetworkApiServices _apiServices = NetworkApiServices();
  Future<UserProfileModel> fetchUserProfile(String userToken) async {
    try {
      final response = await _apiServices.getGetApiResponse("${AppApiUrls.userProfileApiEndPoint}$userToken");
      return UserProfileModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse> updateUserBasicProfileDetail(String name, String gender, String dob, String age, String userToken) async {
    final data = {
      "userid":userToken,
      "name":name,
      "gender":gender,
      "dob":dob,
      "age":age
    };
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.userBasicProfileDetailUpdateApiEndPoint, data);
      return CommonApiResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


  Future<OtpResponse> updateProfileContactDetail(String updateData, String updateFor,String userToken) async {

    final mobileUpdate ={
      "userid":userToken,
      "type":"1",
      "mobile":updateData
    };

    final emailUpdate ={
      "userid":userToken,
      "type":"2",
      "email":updateData
    };

    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.userContactDetailUpdateApiEndPoint, updateFor.toLowerCase()=="email"?emailUpdate:mobileUpdate);
      return OtpResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse> updateProfileImage(String base64Image,String userToken) async {
    final data = {
      "userid":userToken,
      "image":base64Image,
    };
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.userProfileImageUpdateApiEndPoint, data);
      return CommonApiResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}