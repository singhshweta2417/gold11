import 'package:flutter/foundation.dart';
import 'package:gold11/model/notification_model.dart';
import 'package:gold11/repo/notification_repo.dart';

enum NotificationViewState { idle, loading, success, error }

class NotificationViewModel with ChangeNotifier {
  final NotificationApiService _notificationApiService = NotificationApiService();
  NotificationModel? _notificationData;
  String? _userToken;
  NotificationViewState _viewState = NotificationViewState.idle;

  // Expose _notificationData safely
  NotificationModel? get notificationData => _notificationData;
  NotificationViewState get viewState => _viewState;

  void updateToken(String token) {
    if (_userToken != token) {
      _userToken = token;
    }
  }

  void _setViewState(NotificationViewState state) {
    _viewState = state;
    notifyListeners();
  }

  Future<void> fetchNotification(String notificationType, {String? userToken}) async {
    _setViewState(NotificationViewState.loading);
    try {
      final fetchedData = await _notificationApiService.fetchNotification(
        userToken ?? _userToken!,
        notificationType,
      );
      _notificationData = fetchedData;
      _setViewState(NotificationViewState.success);
    } catch (e) {
      _setViewState(NotificationViewState.error);
      if (kDebugMode) {
        print("Error fetching notifications: $e");
      }
    }
  }

  Future<void> viewNotification(String notificationId, String notificationType) async {
    try {
      final responseData = await _notificationApiService.viewNotification(
        _userToken!,
        notificationId,
      );

      if (responseData["status"] == "200") {
        await fetchNotification(notificationType);
      } else {
        if (kDebugMode) {
          print("Failed to mark notification as viewed (Status: 400)");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error viewing notification: $e");
      }
    }
  }

  void viewNewNotifications(String userToken, String notificationType) {
    if (_notificationData?.data != null && _notificationData!.data!.isNotEmpty) {
      for (var notificationItem in _notificationData!.data!) {
        if (notificationItem.isViewed == "0") {
          viewNotification(notificationItem.id.toString(), notificationType);
        } else {
          if (kDebugMode) {
            print("This notification has already been viewed.");
          }
        }
      }
    } else {
      if (kDebugMode) {
        print("Notification data is empty or null.");
      }
    }
  }
}
