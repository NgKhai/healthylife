import 'package:cloud_firestore/cloud_firestore.dart';

class WaterHistory {
  final String WaterHistoryID;
  final String UserID;
  final String DateHistory;
  final List<WaterDetailHistory> waterDetailHistory;

  WaterHistory(
      this.WaterHistoryID, this.UserID, this.DateHistory, this.waterDetailHistory);

  toJson() {
    return {
      "WaterHistoryID": WaterHistoryID,
      "UserID": UserID,
      "DateHistory": DateHistory,
      "WaterDetailHistory": waterDetailHistory.map((detail) => detail.toJson()).toList(),
    };
  }

  factory WaterHistory.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    List<WaterDetailHistory> waterDetailHistoryList = [];
    if (data?['WaterDetailHistory'] != null) {
      var list = data?['WaterDetailHistory'] as List;
      waterDetailHistoryList = list.map((item) => WaterDetailHistory.fromFirestore(item)).toList();
    }

    return WaterHistory(
      data?['WaterHistoryID'] ?? '',
      data?['UserID'] ?? '',
      data?['DateHistory'] ?? '',
      waterDetailHistoryList,
    );
  }
}

class WaterDetailHistory {
  final num capacity;

  WaterDetailHistory(this.capacity);

  toJson() {
    return {
      "Capacity": capacity,
    };
  }

  factory WaterDetailHistory.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    return WaterDetailHistory(
      data?['Capacity'] ?? 0,
    );
  }
}
