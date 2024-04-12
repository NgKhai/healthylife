import 'package:cloud_firestore/cloud_firestore.dart';

class UserHealthy {
  final String UserID;
  final String UserEmail;
  final String UserPassword;
  final String UserName;
  final String UserAvatar;
  final DateTime UserBirthday;


  UserHealthy(this.UserID, this.UserEmail, this.UserPassword, this.UserName,
      this.UserAvatar, this.UserBirthday);

  toJson() {
    return {
      "UserID": UserID,
      "UserEmail": UserEmail,
      "UserPassword": UserPassword,
      "UserName": UserName,
      "UserAvatar": UserAvatar,
      "UserBirthday": UserBirthday,
    };
  }

  factory UserHealthy.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    return UserHealthy(
      data?['UserID'] ?? '', // Set value thành mặc định nếu 'UserID' null
      data?['UserEmail'] ?? '', // Set value thành mặc định nếu 'UserEmail' null
      data?['UserPassword'] ?? '', // Set value thành mặc định nếu 'UserPassword' null
      data?['UserName'] ?? '', // Set value thành mặc định nếu 'UserName' null
      data?['UserAvatar'] ?? '', // Set value thành mặc định nếu 'UserAvatar' null
      data?['UserBirthday'] ?? '', // Set value thành mặc định nếu 'UserBirthday' null
    );
  }
}