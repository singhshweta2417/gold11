import 'package:flutter/material.dart';

class Notification {
  final String title;
  final String subtitle;

  Notification({required this.title, required this.subtitle});
}

class NotificationProvider with ChangeNotifier {
  final List<Notification> _notifications = [
    Notification(
      title: "You won 20 Dream Coins!",
      subtitle: "In the last week! 🎉 Redeem your favourite rewards NOW 🎁",
    ),
    Notification(
      title: "Your order has been shipped.",
      subtitle: "Track your order to see the delivery status.",
    ),
    Notification(
      title: "You have a new message.",
      subtitle: "Check your inbox to read the new message.",
    ),
    Notification(
      title: "Your password has been changed.",
      subtitle: "If you did not make this change, contact support immediately.",
    ),
    Notification(
      title: "New event: Flutter Workshop",
      subtitle: "Join us for an exciting Flutter development workshop.",
    ),
    Notification(
      title: "Congratulations! You've been promoted.",
      subtitle: "Celebrate your success with your team.",
    ),
    Notification(
      title: "Reminder: Meeting at 10 AM",
      subtitle: "Don't forget about your meeting scheduled for 10 AM.",
    ),
    Notification(
      title: "Your subscription is expiring soon.",
      subtitle: "Renew your subscription to continue enjoying our services.",
    ),
    Notification(
      title: "New comment on your post.",
      subtitle: "Someone has commented on your post. Check it out!",
    ),
    Notification(
      title: "You have a new friend request.",
      subtitle: "Approve or deny the friend request in your notifications.",
    ),
  ];
  int _notificationCount = 10;

  List<Notification> get notifications => _notifications;
  int get notificationCount => _notificationCount;

  void clearNotifications() {
    _notificationCount = 0;
    notifyListeners();
  }
}
