import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  String id;
  String title;
  String message;
  DateTime time;
  List<bool> weekdays;

  Reminder({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.weekdays,
  });

  factory Reminder.fromMap(Map<String, dynamic> data) {
    try {
      return Reminder(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        message: data['message'] ?? '',
        time: (data['time'] as Timestamp).toDate(),
        weekdays: List<bool>.from(data['weekdays'] ?? []),
      );
    } catch (e) {
      print("Error parsing reminder from map: $e");
      return Reminder(
        id: '',
        title: '',
        message: '',
        time: DateTime.now(),
        weekdays: [],
      );
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'time': time,
      'weekdays': weekdays,
    };
  }
}
