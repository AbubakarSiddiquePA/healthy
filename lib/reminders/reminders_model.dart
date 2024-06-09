import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderModel {
  Timestamp? timestamp;
  String? message;
  ReminderModel({this.timestamp, this.message});

  Map<String, dynamic> toMap() {
    return {
      "time": timestamp,
      "message": message,
    };
  }

  factory ReminderModel.fromMap(map) {
    return ReminderModel(
      timestamp: map["time"],
      message: map["message"],
    );
  }
}
