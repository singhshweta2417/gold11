import 'package:flutter/foundation.dart';

class Contest {
  final String title;
  final int prizePool;
  final int entryFee;
  final int spotsLeft;
  final int totalSpots;
  final String prizeDetails;
  final String type;

  Contest({
    required this.title,
    required this.prizePool,
    required this.entryFee,
    required this.spotsLeft,
    required this.totalSpots,
    required this.prizeDetails,
    required this.type,
  });
}

class FilterModel with ChangeNotifier {
  final List<Contest> _contests = [
    Contest(
      title: "Mega Contest",
      prizePool: 2100000,
      entryFee: 49,
      spotsLeft: 16579,
      totalSpots: 59523,
      prizeDetails: "₹1.2 Lakhs 62% M Upto 20",
      type: "Guaranteed",
    ),
    Contest(
      title: "Specially For You",
      prizePool: 66,
      entryFee: 19,
      spotsLeft: 2,
      totalSpots: 4,
      prizeDetails: "₹66 25% Single",
      type: "",
    ),
    Contest(
      title: "Max Prize Pool",
      prizePool: 25200,
      entryFee: 20,
      spotsLeft: 538,
      totalSpots: 1500,
      prizeDetails: "₹80 21% Upto 11",
      type: "Flexible",
    ),
    Contest(
      title: "Special Contest",
      prizePool: 90,
      entryFee: 35,
      spotsLeft: 1,
      totalSpots: 3,
      prizeDetails: "₹90 33% Single",
      type: "",
    ),
    Contest(
      title: "Mini Contest",
      prizePool: 68,
      entryFee: 19,
      spotsLeft: 1,
      totalSpots: 3,
      prizeDetails: "₹68 33% Single",
      type: "",
    ),
    Contest(
      title: "Mega Contest",
      prizePool: 2100000,
      entryFee: 49,
      spotsLeft: 16579,
      totalSpots: 59523,
      prizeDetails: "₹1.2 Lakhs 62% M Upto 20",
      type: "Guaranteed",
    ),
    Contest(
      title: "Specially For You",
      prizePool: 66,
      entryFee: 19,
      spotsLeft: 2,
      totalSpots: 4,
      prizeDetails: "₹66 25% Single",
      type: "",
    ),
    Contest(
      title: "Max Prize Pool",
      prizePool: 25200,
      entryFee: 20,
      spotsLeft: 538,
      totalSpots: 1500,
      prizeDetails: "₹80 21% Upto 11",
      type: "Flexible",
    ),
    Contest(
      title: "Special Contest",
      prizePool: 90,
      entryFee: 35,
      spotsLeft: 1,
      totalSpots: 3,
      prizeDetails: "₹90 33% Single",
      type: "",
    ),
    Contest(
      title: "Mini Contest",
      prizePool: 68,
      entryFee: 19,
      spotsLeft: 1,
      totalSpots: 3,
      prizeDetails: "₹68 33% Single",
      type: "",
    ),
  ];

  List<Map<String, dynamic>> _filters = [];

  List<Contest> get contests => _contests
      .where((contest) => applyFilter(contest))
      .toList();

  List<Map<String, dynamic>> get filters => _filters;

  void setFilters(List<Map<String, dynamic>> newFilters) {
    _filters = newFilters;
    notifyListeners();
  }

  bool applyFilter(Contest contest) {
    if (_filters.isNotEmpty) {
      for (var filter in _filters) {
        if (filter['type'] == 'prizePool' && contest.prizePool < filter['value']) {
          return false;
        }
        // Add more filter conditions here
      }
    }
    return true;
  }
}
