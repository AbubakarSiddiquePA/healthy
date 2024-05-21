import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy/models/reminder_model.dart';

class ReminderProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController reminderController = TextEditingController();
  DateTime? selectedTime;
  List<bool> selectedWeekdays = List.filled(7, false);

  List<Reminder> reminders = [];
  bool isLoading = false;

  void setSelectedTime(DateTime time) {
    selectedTime = time;
    notifyListeners();
  }

  void toggleWeekday(int index, bool value) {
    selectedWeekdays[index] = value;
    notifyListeners();
  }

  bool validateTime() {
    return selectedTime != null;
  }

  bool validateWeekdays() {
    return selectedWeekdays.contains(true);
  }

  String getFormattedTime() {
    if (selectedTime != null) {
      return "${selectedTime!.hour}:${selectedTime!.minute}";
    } else {
      return "No time selected";
    }
  }

  Future<void> fetchReminders() async {
    isLoading = true;
    notifyListeners();

    final QuerySnapshot snapshot =
        await _firestore.collection('reminders').get();
    reminders = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Reminder(
        id: doc.id,
        title: data['title'],
        message: data['message'],
        time: (data['time'] as Timestamp).toDate(),
        weekdays: List<bool>.from(data['weekdays']),
      );
    }).toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addReminder(Reminder reminder) async {
    final docRef = await _firestore.collection('reminders').add({
      'title': reminder.title,
      'message': reminder.message,
      'time': reminder.time,
      'weekdays': reminder.weekdays,
    });

    reminders.add(Reminder(
      title: reminder.title,
      message: reminder.message,
      time: reminder.time,
      weekdays: reminder.weekdays,
      id: docRef.id,
    ));

    notifyListeners();
  }

  Future<void> deleteReminder(String id) async {
    await _firestore.collection('reminders').doc(id).delete();
    reminders.removeWhere((reminder) => reminder.id == id);
    notifyListeners();
  }

  void reset() {
    titleController.clear();
    reminderController.clear();
    selectedTime = null;
    selectedWeekdays = List.filled(7, false);
    notifyListeners();
  }
}
