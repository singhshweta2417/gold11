import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static Future<void> launchReferralCode({
    required String invitationCode,
    required String domainUrl,
  }) async {
    final String message =
        "Join our gaming platform to win exciting prizes. Here is my Referral Code: *$invitationCode*\n\n$domainUrl";

    final String url = "whatsapp://send?text=${Uri.encodeComponent(message)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
