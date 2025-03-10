import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:gold11/repo/wallet_repo.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view_model/profile_view_model.dart';

import '../model/bank_account_model.dart';
import '../model/common_api_response.dart';
import '../model/transaction_type_model.dart';
import '../model/user_transaction_model.dart';
import '../utils/route/app_routes.dart';

enum WalletState { idle, loading, success, error }

class WalletViewModel with ChangeNotifier {
  final WalletApiService _walletApiService = WalletApiService();

  final List<String> _docTypeList = [
    "Upload Aadhaar",
    // "Aadhaar Number",
    "Upload Driving License",
    "Upload Voter ID",
  ];

  final List<double> amountSelectionOptions = [500, 1000];

  List<String> get docTypeList => _docTypeList;

  String _initialDocType = "Aadhaar Number";
  String _idNumberType = "Enter Aadhaar Number";
  String _message = '';
  File? _selectedImage;
  File? _selectedImageBack;
  File? _selectedPdf;
  ImageSource _selectedImageSource = ImageSource.camera;
  String _userToken = '';
  bool _isCurrentTileExpanded = false;
  bool _isInfoTileExpanded = false;
  double _amount = 150;
  String _deductionAmount = "0";
  WalletState _walletState = WalletState.idle;
  TransactionType? _transactionType;
  UserTransactions? _userTransactions;
  bool _isButtonTapped = false;
  BankAccountModel? _bankAccounts;
  int _selectedBankAccId = 0;
  final idNumber = TextEditingController();

  // o -> init state || 1 -> amount greater || 2 -> minimum req
  String _amountWithdrawStatus = "0";

  String get message => _message;
  String get initialDocType => _initialDocType;
  String get idNumberType => _idNumberType;
  File? get selectedImage => _selectedImage;
  File? get selectedImageBack => _selectedImageBack;
  File? get selectedPdf => _selectedPdf;
  ImageSource get selectedImageSource => _selectedImageSource;
  bool get isCurrentTileExpanded => _isCurrentTileExpanded;
  bool get isInfoTileExpanded => _isInfoTileExpanded;
  double get amount => _amount;
  String get deductionAmount => _deductionAmount;
  WalletState get walletState => _walletState;
  TransactionType? get transactionType => _transactionType;
  UserTransactions? get userTransactions => _userTransactions;
  bool get isButtonTapped => _isButtonTapped;
  String get amountWithdrawStatus => _amountWithdrawStatus;
  BankAccountModel get bankAccounts => _bankAccounts!;
  int get selectedBankAccId => _selectedBankAccId;

  final TextEditingController amountCon = TextEditingController(text: "150");
  final TextEditingController withdrawAmountCon = TextEditingController();

  List<File> _savedImageList = [];
  List<File> get savedImageList => _savedImageList;

  WalletViewModel() {
    amountCon.addListener(_onAmountChange);
    // chooseDocType(_docTypeList[0]);
  }

  void _onAmountChange() {
    _updateAmount();
    notifyListeners();
  }

  void setLoading(bool state) {
    _isButtonTapped = state;
    notifyListeners();
  }

  void isCurrentTileChangeNotify(bool value) {
    if (_isCurrentTileExpanded != value) {
      _isCurrentTileExpanded = value;
      notifyListeners();
    }
  }

  void isInfoTileChangeNotify(bool value) {
    if (_isInfoTileExpanded != value) {
      _isInfoTileExpanded = value;
      notifyListeners();
    }
  }

  void chooseDocType(String type) {
    if (_initialDocType != type) {
      _initialDocType = type;
      switch (type) {
        case "Upload Aadhaar" || "Aadhaar Number":
          _selectedImage=null;
          _selectedImageBack=null;
          _idNumberType = "Enter Aadhaar Number";
        case "Upload Driving License":
          _selectedImage=null;
          _selectedImageBack=null;
          _idNumberType = "Enter Driving License Number";
        case "Upload Voter ID":
          _selectedImage=null;
          _selectedImageBack=null;
          _idNumberType = "Enter Voter ID Number";
      }
      notifyListeners();
    }
  }

  void selectAmountFromOptions(double value) {
    if (_amount != value) {
      _amount = value;
      amountCon.text = value.toString();
      _updateDeductionAmount();
      notifyListeners();
    }
  }

  void selectAmountFromTextField() {
    final parsedAmount = double.tryParse(amountCon.text);
    if (parsedAmount != null && _amount != parsedAmount) {
      _amount = parsedAmount;
      _updateDeductionAmount();
      notifyListeners();
    }
  }

  void _updateDeductionAmount() {
    _deductionAmount = (_amount * 21.8 / 100).toStringAsFixed(2);
  }

  void _updateAmount() {
    selectAmountFromTextField();
  }

  void updateToken(String token) {
    if (_userToken != token) {
      _userToken = token;
    }
  }

  void clearAmountController() {
    amountCon.clear();
    notifyListeners();
  }

  Future<void> pickImage(context, ImageSource source) async {
    _selectedImageSource = source;
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final File? croppedFile = await _cropImage(File(pickedFile.path));
      if (croppedFile != null) {
        if (_selectedImage == null) {
          _selectedImage = croppedFile;
        } else {
          _selectedImageBack = croppedFile;
        }
        if (_selectedImage != null) {
          Navigator.pushNamed(
            context,
            AppRoutes.walletViewSelectedImage,
          );
        } else {
        }

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
        CropAspectRatioPreset.ratio16x9,
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

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      _selectedPdf = File(result.files.single.path!);
      notifyListeners();
    }
  }

  void addImage(File imageFile) {
    _savedImageList.add(imageFile);
    notifyListeners();
  }

  void removeImage(File imageFile) {
    _savedImageList.remove(imageFile);
    notifyListeners();
  }

  void clearSavedImageList() {
    _savedImageList.clear();
    notifyListeners();
  }
  Future<void> addAmount(context, String userToken) async {
    _setWalletState(WalletState.loading);
    try {
      final response = await _walletApiService.addAmount(
          userToken, _amount.toStringAsFixed(0));

      if (response["status"] == "200") {
        Utils.launchUrl(response['data']['payment_link']);
      } else {
        _message = response["msg"] ?? "Something went wrong"; // Ensure _message is not null
        Utils.showErrorMessage(context, _message);
      }

      _setWalletState(WalletState.success);
    } catch (e) {
      _message = 'Failed: $e';
      Utils.showErrorMessage(context, _message);  // Show error message properly
      _setWalletState(WalletState.error);
    }
  }
   

  // Future<void> addAmount(context, String userToken) async {
  //   _setWalletState(WalletState.loading);
  //   try {
  //     final response = await _walletApiService.addAmount(
  //         userToken, _amount.toStringAsFixed(0));
  //     if (response["status"] == "200") {
  //       Utils.launchUrl(response['data']['payment_link']);
  //     } else {
  //       Utils.showErrorMessage(context, _message);
  //     }
  //     _setWalletState(WalletState.success);
  //   } catch (e) {
  //     _message = 'failed: $e';
  //     _setWalletState(WalletState.error);
  //   }
  // }

  void _setWalletState(WalletState state) {
    _walletState = state;
    notifyListeners();
  }

  Future<void> getTransactionType(context) async {
    _setWalletState(WalletState.loading);

    try {
      _transactionType = await _walletApiService.getTransactionType();
      _message = _transactionType!.msg.toString();
      Utils.showSuccessMessage(context, _message);
      _setWalletState(WalletState.success);
    } catch (e) {
      _message = 'failed: $e';
      _setWalletState(WalletState.error);
    }
  }

  Future<void> getUserTransactions(context, String userToken) async {
    _setWalletState(WalletState.loading);
    try {
      _userTransactions =
          await _walletApiService.getUserTransactions(userToken);
      _message = _transactionType!.msg.toString();
      Utils.showSuccessMessage(context, _message);
      _setWalletState(WalletState.success);
    } catch (e) {
      _message = ' failed: $e';
      _setWalletState(WalletState.error);
    }
  }

  void checkEnteredAmountValidation(context, String conValue) {
    final profileP = Provider.of<ProfileViewModel>(context, listen: false);
    if (conValue.isNotEmpty && conValue != "") {
      if (double.parse(profileP.userProfile!.data!.winningWallet??0) < double.parse(conValue)) {
        _amountWithdrawStatus = "1";
      } else if (int.parse(conValue) < 60) {
        _amountWithdrawStatus = "2";
      } else {
        _amountWithdrawStatus = "3";
      }
    } else {
      _amountWithdrawStatus = "0";
      if (kDebugMode) {
        print("field is empty");
      }
    }
    notifyListeners();
  }

  Future<void> withdrawAmount(context, String userToken) async {
    _setWalletState(WalletState.loading);
    try {
      final CommonApiResponse response = await _walletApiService.withdrawAmount(
          userToken,
          withdrawAmountCon.text.trim(),
          selectedBankAccId.toString());
      _message = response.message;
      if (response.status == "200") {
        Utils.showSuccessMessage(context, _message);
        Provider.of<ProfileViewModel>(context, listen: false)
            .fetchUserProfile();
      } else {
        Utils.showErrorMessage(context, _message);
      }
      _setWalletState(WalletState.success);
    } catch (e) {
      _message = 'failed: $e';
      _setWalletState(WalletState.error);
    }
  }

  Future<void> addAccount(context, String userToken, String bankName,
      String accNo, String ifscCode, String accHolderName) async {
    _setWalletState(WalletState.loading);
    try {
      final CommonApiResponse response = await _walletApiService.addAccount(
          userToken, bankName, accNo, ifscCode, accHolderName);
      _message = response.message;
      if (response.status == "200") {
        Navigator.pop(context);
        Utils.showSuccessMessage(context, _message);
        gatAccounts(context, userToken);
      } else {
        Utils.showErrorMessage(context, _message);
      }
      _setWalletState(WalletState.success);
    } catch (e) {
      _message = 'failed: $e';
      _setWalletState(WalletState.error);
    }
  }

  Future<void> gatAccounts(context, String userToken) async {
    _setWalletState(WalletState.loading);
    try {
      _bankAccounts = await _walletApiService.getAccounts(userToken);
      _message = _transactionType!.msg.toString();
      Utils.showSuccessMessage(context, _message);
      if (_bankAccounts!.data!.isNotEmpty) {
        selectBankAcc(_bankAccounts!.data!.first.id ?? 0);
      } else {
        if (kDebugMode) {
          print("no any accounts are there");
        }
      }
      _setWalletState(WalletState.success);
    } catch (e) {
      _message = ' failed: $e';
      _setWalletState(WalletState.error);
    }
    notifyListeners();
  }

  void selectBankAcc(int accId) {
    _selectedBankAccId = accId;
    notifyListeners();
  }

  void resetWithdrawData() {
    _amountWithdrawStatus = "0";
    notifyListeners();
  }

  dynamic updateDocData;

  Future<String> _convertImageToBase64(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(bytes);
    return base64Image;
  }

  void makeDataAsPerDocTypeAndHiTApi(context, String userToken) async {
    switch (_initialDocType) {
      case "Upload Aadhaar":
        final image = await _convertImageToBase64(_selectedImage!);
        // final backImage = await _convertImageToBase64(_selectedImageBack!);
        updateDocData = {
          "userid": userToken,
          "type": "1",
          "doc_number": idNumber.text,
          "front_image": image,
          "back_image": image,
        };
        addAndVerifyDocs(context, updateDocData);
      // case "Aadhaar Number":
      //   updateDocData={
      //     "userid":userToken,
      //     "type":"",
      //     "doc_number":"",
      //     "dl_image":"",
      //   };
      case "Upload Driving License":
        final image = await _convertImageToBase64(_selectedImage!);
        updateDocData = {
          "userid": userToken,
          "type": "2",
          "doc_number": idNumber.text,
          "dl_image": image,
        };
        addAndVerifyDocs(context, updateDocData);
      case "Upload Voter ID":
        final image = await _convertImageToBase64(_selectedImage!);
        updateDocData = {
          "userid": userToken,
          "type": "3",
          "doc_number": idNumber.text,
          "voter_image": image,
        };
        addAndVerifyDocs(context, updateDocData);
    }
  }

  Future<void> addAndVerifyDocs(context, dynamic data) async {
    _setWalletState(WalletState.loading);
    try {
      final CommonApiResponse response =
          await _walletApiService.addAndVerifyDocs(data);
      _message = response.message;
      if (response.status == "200") {
        Provider.of<ProfileViewModel>(context, listen: false).fetchUserProfile();
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Utils.showSuccessMessage(context, _message);
        // gatAccounts(context, userToken);
      } else {
        Utils.showErrorMessage(context, _message);
      }
      _setWalletState(WalletState.success);
    } catch (e) {
      _message = 'failed: $e';
      _setWalletState(WalletState.error);
    }
  }

  void clearFields() {
    _selectedImage = null;
    _selectedImageBack = null;
    _initialDocType = _docTypeList[0];
    _savedImageList=[];
    idNumber.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    amountCon.dispose();
    super.dispose();
  }
}
