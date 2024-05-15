// import 'package:cloud_firestore/cloud_firestore.dart';

// class Habit {
//     String id;

//   String name;
//   String motivation;
//   int daysPerWeek;
//   DateTime startDate;

//   Habit({
//     required this.id,
//     required this.name,
//     required this.motivation,
//     required this.daysPerWeek,
//     required this.startDate,
//   });
//   factory Habit.fromMap(Map<String, dynamic> map) {
//     return Habit(
//       id: id,
//       name: map["name"] ?? "",
//       motivation: map["motivation"] ?? "",
//       daysPerWeek: map["daysPerWeek"] ?? 0,
//       startDate: (map["startDate"] as Timestamp).toDate(),
//     );
//   }
//   Map<String, dynamic> toMap() {
//     return {
//       "name": name,
//       "mptivation": motivation,
//       "daysPerWeek": daysPerWeek,
//       "startDate": startDate,
//     };
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  String id;
  String name;
  String motivation;
  int daysPerWeek;
  DateTime startDate;

  Habit({
    required this.id,
    required this.name,
    required this.motivation,
    required this.daysPerWeek,
    required this.startDate,
  });

  factory Habit.fromMap(String id, Map<String, dynamic> map) {
    return Habit(
      id: id,
      name: map["name"] ?? "",
      motivation: map["motivation"] ?? "",
      daysPerWeek: map["daysPerWeek"] ?? 0,
      startDate: (map["startDate"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "motivation": motivation,
      "daysPerWeek": daysPerWeek,
      "startDate": startDate,
    };
  }
}
