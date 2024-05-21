import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy/habitmodelclass/habit_model.dart';
import 'package:healthy/models/reminder_model.dart';

class AddHabitProvider extends ChangeNotifier {
  String habitName = '';
  String motivation = '';
  List<int> daysPerWeek = [];
  DateTime startDate = DateTime.now();
  List<Reminder> reminders = [];
  List<Habit> habits = [];
  TextEditingController habitNameController = TextEditingController();
  TextEditingController motivationNameController = TextEditingController();

  void setHabitName(String name) {
    habitName = name;
    notifyListeners();
  }

  void setMotivation(String motivationText) {
    motivation = motivationText;
    notifyListeners();
  }

  void setDaysPerWeek(List<int> days) {
    daysPerWeek = days;
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
  }

  void addReminder(Reminder reminder) {
    reminders.add(reminder);
    notifyListeners();
  }

  void saveHabit(BuildContext context) {
    if (habitName.isEmpty || motivation.isEmpty) return;

    Habit newHabit = Habit(
      id: "",
      name: habitName,
      motivation: motivation,
      daysPerWeek: daysPerWeek,
      startDate: startDate,
      reminders: reminders,
    );

    FirebaseFirestore.instance
        .collection("habitsCollection")
        .add(newHabit.toMap())
        .then((docRef) {
      newHabit.id =
          docRef.id; // Update the habit id with the generated id from Firestore
      habits.add(newHabit); // Add the new habit to the local list
      notifyListeners(); // Notify listeners to update the UI
    });

    habitNameController.clear();
    motivationNameController.clear();
    habitName = '';
    motivation = '';
    daysPerWeek = [];
    startDate = DateTime.now();
    reminders = [];

    notifyListeners();
    Navigator.pop(context, newHabit);
  }

  // Future<void> loadHabits() async {
  //   try {
  //     QuerySnapshot snapshot =
  //         await FirebaseFirestore.instance.collection("habitsCollection").get();
  //     habits = snapshot.docs
  //         .map((doc) =>
  //             Habit.fromMap(doc.data() as Map<String, dynamic>, doc.id))
  //         .toList();
  //     notifyListeners();
  //   } catch (e) {
  //     print("Error loading habits: $e");
  //   }
  // }
}
