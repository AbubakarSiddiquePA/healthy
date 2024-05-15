import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy/habitmodelclass/habit_model.dart';

class AddHabitProvider extends ChangeNotifier {
  String habitName = '';
  String motivation = '';
  int daysPerWeek = 1;
  DateTime startDate = DateTime.now();
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

  void setDaysPerWeek(int days) {
    daysPerWeek = days;
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    startDate = date;
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
    );
    // Save to Firestore or any other storage mechanism
    FirebaseFirestore.instance
        .collection("habitsCollection")
        .add(newHabit.toMap());
    notifyListeners();
    Navigator.pop(context, newHabit);
  }
}
