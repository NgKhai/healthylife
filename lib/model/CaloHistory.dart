import 'package:cloud_firestore/cloud_firestore.dart';

class CaloHistory {
  final String CaloHistoryID;
  final String UserID;
  final String DateHistory;
  final List<String> FoodID;


  CaloHistory(
      this.CaloHistoryID, this.UserID, this.DateHistory, this.FoodID);

  toJson() {
    return {
      "CaloHistoryID": CaloHistoryID,
      "UserID": UserID,
      "DateHistory": DateHistory,
      'FoodID': FoodID,
    };
  }

  factory CaloHistory.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    return CaloHistory(
      data?['CaloHistoryID'] ?? '', // Set value thành mặc định nếu 'CaloHistoryID' null
      data?['FoodID'] ?? '', // Set value thành mặc định nếu 'FoodID' null
      data?['UserID'] ?? '', // Set value thành mặc định nếu 'UserID' null
      data?['DateHistory'] ?? '', // Set value thành mặc định nếu 'DateHistory' null
    );
  }
}

class FoodHistory {
  final String FoodID;

  FoodHistory(this.FoodID);

  toJson() {
    return {
      "FoodID": FoodID,
    };
  }

  factory FoodHistory.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    return FoodHistory(
      data?['FoodID'] ?? '', // Set value thành mặc định nếu 'FoodID' null
    );
  }
}