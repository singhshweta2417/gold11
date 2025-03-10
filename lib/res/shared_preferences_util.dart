import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefViewModel extends ChangeNotifier {
  String _userToken = "";

  String get userToken => _userToken;

  SharedPrefViewModel() {
    _loadUserToken();
  }

  Future<void> _loadUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    _userToken = prefs.getString("userToken") ?? "";
    notifyListeners();
  }

  Future<void> setUserToken(String userToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userToken", userToken);
    _userToken = userToken;
    notifyListeners();
  }

  Future<void> removeUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("userToken");
    _userToken = "";
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    _userToken = prefs.getString("userToken") ?? "";
    return _userToken.isNotEmpty;
  }
}
