import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gold11/model/common_api_response.dart';
import 'package:gold11/utils/utils.dart';

import '../model/otp_response_model.dart';
import '../model/user_profile_model.dart';
import '../model/verify_otp_model.dart';
import '../repo/auth_repo.dart';
import '../repo/profile_repo.dart';
import '../res/app_const.dart';
import '../utils/route/app_routes.dart';

enum ProfileState { idle, loading, success, error }

enum Gender { male, female, others }

class ProfileViewModel extends ChangeNotifier {
  final ProfileApiService _profileApiService = ProfileApiService();
  final AuthApiService _authApiService = AuthApiService();
  UserProfileModel? _userProfile;
  ProfileState _state = ProfileState.idle;
  String _message = '';
  File? _selectedImage;
  String _userToken = '';


  UserProfileModel? get userProfile => _userProfile;
  ProfileState get state => _state;
  String get message => _message;
  File? get selectedImage => _selectedImage;

  ProfileViewModel();

  void updateToken(String token) {
    if (_userToken != token) {
      _userToken = token;
      fetchUserProfile();
    }
  }

  void _setState(ProfileState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> fetchUserProfile() async {
    _setState(ProfileState.loading);
    try {
      _userProfile = await _profileApiService.fetchUserProfile(_userToken);
      _message = _userProfile?.msg ?? 'Success';
      if (_userProfile != null) {
        nameController.text = _userProfile!.data?.name ?? '';
        emailController.text = _userProfile!.data?.email ?? '';
        mobileController.text = _userProfile!.data?.mobile ?? '';
        _selectedGender =
            _mapGenderFromNumeric(_userProfile!.data!.gender.toString());
        dobController.text = _userProfile!.data!.age ?? '';
      }

      _setState(ProfileState.success);
      notifyListeners();
    } catch (e) {
      _message = 'Failed to fetch profile: $e';
      _setState(ProfileState.error);
    }
    notifyListeners();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  Gender? _selectedGender;
  Gender? get selectedGender => _selectedGender;

  Future<void> updateUserProfile(context) async {
    _setState(ProfileState.loading);
    final selectedGender = _mapGenderToNumeric(_selectedGender);
    final age = calculateAge(dobController.text);
    try {
      final updateProfileRes =
          await _profileApiService.updateUserBasicProfileDetail(
              nameController.text, selectedGender, dobController.text, age, _userToken);
      _userProfile = await _profileApiService.fetchUserProfile(_userToken);
      _message = updateProfileRes.message;
      if (updateProfileRes.status == "200") {
        Utils.showSuccessMessage(context, _message);
      } else {
        Utils.showErrorMessage(context, _message);
      }
      _setState(ProfileState.success);
      notifyListeners();
    } catch (e) {
      _message = 'Failed to update profile: $e';
      _setState(ProfileState.error);
    }
  }

  void setSelectedGender(Gender? gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  Gender _mapGenderFromNumeric(String? gender) {
    switch (gender) {
      case "1":
        return Gender.male;
      case "2":
        return Gender.female;
      case "3":
        return Gender.others;
      default:
        return Gender.male;
    }
  }

  String _mapGenderToNumeric(Gender? gender) {
    switch (gender) {
      case Gender.male:
        return "1";
      case Gender.female:
        return "2";
      case Gender.others:
        return "3";
      default:
        return "1";
    }
  }

  String calculateAge(String dob) {
    try {
      final birthDate = DateTime.parse(dob);
      final today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age.toString();
    } catch (e) {
      if (kDebugMode) {
        print('Error calculating age: $e');
      }
      return '';
    }
  }

  final TextEditingController updateContentCon = TextEditingController();
  final TextEditingController updateDataOtpCon = TextEditingController();

  Future<void> updateProfileContactDetail(context, arguments) async {
    try {
      final OtpResponse response =
          await _profileApiService.updateProfileContactDetail(
              updateContentCon.text, arguments["updateType"], _userToken);
      _message = response.message;
      _setState(ProfileState.success);
      Navigator.pushNamed(context, AppRoutes.verifyOtpForUpdateMobileOrEmail,
          arguments: arguments);
      Utils.showSuccessMessage(context, _message);
    } catch (e) {
      _message = 'Send OTP failed: $e';
      _setState(ProfileState.error);
    }
  }

  Future<void> verifyOtp(context, arguments) async {
    _setState(ProfileState.loading);
    try {
      final VerifyOtpModel response = await _authApiService.verifyOtp(
          updateContentCon.text,
          updateDataOtpCon.text,
          "${AppConstants.verifyOtpApiTypeUpdateProfile}$_userToken");
      _message = response.message;
      if (response.status == "200") {
        _userProfile = await _profileApiService.fetchUserProfile(_userToken);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.myProfileInfo,
            ModalRoute.withName(AppRoutes.myProfileInfo),
            arguments: arguments,
          );
          Utils.showSuccessMessage(context, _message);
        });
      } else if (response.status == "300") {
        Utils.showErrorMessage(context, _message);
      } else {
        Navigator.pushNamed(context, AppRoutes.userRegistrationScreen);
        Utils.showErrorMessage(context, _message);
      }
      _setState(ProfileState.success);
    } catch (e) {
      _message = 'Verify OTP failed: $e';
      _setState(ProfileState.error);
    }
  }

  Future<void> pickImage(context,ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      File? croppedFile = await _cropImage(File(pickedFile.path));
      if (croppedFile != null) {
        _selectedImage = croppedFile;
       final base64Image = await _convertImageToBase64(_selectedImage!);
       updateProfileImage(context,base64Image);
        notifyListeners();
      }
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: const AndroidUiSettings(
        backgroundColor: Colors.black87,
        toolbarTitle: 'Edit Image',
        toolbarColor: Colors.black87,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );

    if (croppedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = path.basename(croppedFile.path);
      final savedImage =
          await File(croppedFile.path).copy('${directory.path}/$fileName');
      return savedImage;
    }
    return null;
  }

  Future<void> updateProfileImage(context, base64Image) async {
    try {
      final CommonApiResponse response =
      await _profileApiService.updateProfileImage(base64Image,_userToken);
      _message = response.message;
      _userProfile = await _profileApiService.fetchUserProfile(_userToken);
      Utils.showSuccessMessage(context, _message);
      notifyListeners();
    } catch (e) {
      _message = 'Send OTP failed: $e';
      _setState(ProfileState.error);
    }
  }

  Future<String> _convertImageToBase64(File image) async {
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }

  void clearUserProfile() {
    _userProfile = null;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    dobController.dispose();
    updateContentCon.dispose();
    updateDataOtpCon.dispose();
    super.dispose();
  }
}
