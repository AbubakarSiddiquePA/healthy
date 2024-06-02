import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  String id;
  String name;
  String motivation;
  List<dynamic> daysPerWeek;
  DateTime startDate;
  // List<Reminder> reminders;

  Habit({
    required this.id,
    required this.name,
    required this.motivation,
    required this.daysPerWeek,
    required this.startDate,
    // required this.reminders,
  });

  factory Habit.fromMap(Map<String, dynamic> data, String id) {
    try {
      return Habit(
        id: id,
        name: data['name'] ?? '',
        motivation: data['motivation'] ?? '',
        daysPerWeek: List<dynamic>.from(data['daysPerWeek'] ?? []),
        startDate: (data['startDate'] as Timestamp).toDate(),
        // reminders: (data['reminders'] as List<dynamic>)
        //     .map((reminderData) =>
        //         Reminder.fromMap(reminderData as Map<String, dynamic>))
        //     .toList(),
      );
    } catch (e) {
      print("Error parsing habit from map: $e");
      return Habit(
        id: '',
        name: '',
        motivation: '',
        daysPerWeek: [],
        startDate: DateTime.now(),
        // reminders: [],
      );
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'motivation': motivation,
      'daysPerWeek': daysPerWeek,
      'startDate': Timestamp.fromDate(startDate),
      // 'reminders': reminders.map((reminder) => reminder.toMap()).toList(),
    };
  }
}
