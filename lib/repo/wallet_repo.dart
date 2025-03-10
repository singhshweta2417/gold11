import 'package:gold11/model/common_api_response.dart';
import 'package:gold11/model/transaction_type_model.dart';
import 'package:gold11/model/user_transaction_model.dart';

import '../helper/network/network_api_services.dart';
import '../model/bank_account_model.dart';
import '../res/app_url_const.dart';

class WalletApiService{
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<dynamic> addAmount(String userToken, String amount) async {
    final data = {
      "userid":userToken,
      "amount":amount,
    };
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.addAmountApiEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<TransactionType> getTransactionType() async {
    try {
      final response = await _apiServices.getGetApiResponse(AppApiUrls.transactionTypeApiEndPoint);
      return TransactionType.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserTransactions> getUserTransactions(String userToken) async {
    try {
      final response = await _apiServices.getGetApiResponse("${AppApiUrls.userTransactionsApiEndPoint}$userToken");
      return UserTransactions.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse> withdrawAmount(String userToken, String amount, String bankId) async {
    final data = {
      "userid":userToken,
      "amount":amount,
      "bank_id":bankId
    };
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.userWithdrawalApiEndPoint, data);
      return CommonApiResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addAccount(String userToken,  String bankName, String accNo, String ifscCode, String accHolderName) async {
    final data ={
      "userid":userToken,
      "bank_name":bankName,
      "account_no":accNo,
      "ifsc_code":ifscCode,
      "account_holder_name":accHolderName
    };
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.addAccountApiEndPoint, data);
      return CommonApiResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<BankAccountModel> getAccounts(String userToken) async {
    final data ={
      "userid":userToken
    };
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.getAccountsApiEndPoint, data);
      return BankAccountModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addAndVerifyDocs(dynamic data) async {
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.uploadDocsApiEndPoint, data);
      return CommonApiResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}