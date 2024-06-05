import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderModel {
  Timestamp? timestamp;
  ReminderModel({this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      "time": timestamp,
    };
  }

  factory ReminderModel.fromMap(map) {
    return ReminderModel(
      timestamp: map["time"],
    );
  }
}
