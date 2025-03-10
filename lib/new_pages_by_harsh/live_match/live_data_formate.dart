String getBatsmanData(Map<String, dynamic> socketData, String field,String data) {
  try {
    final List<dynamic>? balls = socketData['balls'] as List<dynamic>?;
    if (balls != null && balls.isNotEmpty) {
      final Map<String, dynamic>? lastBall = balls.last as Map<String, dynamic>?;
      if (lastBall != null && lastBall.containsKey(data)) {
        final Map<String, dynamic>? batsmanData = lastBall[data];
        if (batsmanData != null && batsmanData.containsKey(field)) {
          return batsmanData[field] ?? "Unknown";
        } else {
        }
      } else {
      }
    } else {
    }
    return "";
  } catch (e) {
    return "Error in data";
  }
}
