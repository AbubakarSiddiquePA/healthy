import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  String name;
  String motivation;
  int daysPerWeek;
  DateTime startDate;

  Habit({
    required this.name,
    required this.motivation,
    required this.daysPerWeek,
    required this.startDate,
  });
  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      name: map["name"] ?? "",
      motivation: map["motivation"] ?? "",
      daysPerWeek: map["daysPerWeek"] ?? 0,
      startDate: (map["startDate"] as Timestamp).toDate(),
    );
  }
}
