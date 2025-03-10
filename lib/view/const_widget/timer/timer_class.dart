// live_time.dart
import 'package:intl/intl.dart';

class LiveTime {
  // Stream that emits the current time every second
  Stream<String> getTimeStream() {
    return Stream<String>.periodic(const Duration(seconds: 1), (_) {
      DateTime now = DateTime.now();
      String formattedTime = DateFormat('hh:mm:ss a').format(now);
      return formattedTime;
    });
  }
}
