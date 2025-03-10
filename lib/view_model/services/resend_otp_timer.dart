import 'dart:async';
import 'package:flutter/foundation.dart';

class ResendOtpTimerCountdownController with ChangeNotifier {
  int _remainingTime = 30;
  Timer? _timer;

  int get remainingTime => _remainingTime;

  void startTimer() {
    _remainingTime = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        _timer?.cancel();
      }
    });
  }

  void resetTimer() {
    _remainingTime = 30;
    startTimer();
  }

  void disposeTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    disposeTimer();
    super.dispose();
  }
}
