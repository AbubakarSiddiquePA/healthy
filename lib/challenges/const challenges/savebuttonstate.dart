// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ChallengeState extends ChangeNotifier {
//   final Map<String, List<bool>> _challengeValuesMap = {};

//   List<bool> getChallengeValues(String screenId) {
//     if (_challengeValuesMap.containsKey(screenId)) {
//       return List.unmodifiable(_challengeValuesMap[screenId]!);
//     }
//     // If the screen ID doesn't exist, create a new entry for it with default values.
//     _challengeValuesMap[screenId] = List<bool>.generate(20, (index) => false);
//     return List.unmodifiable(_challengeValuesMap[screenId]!);
//   }

//   void updateChallengeValue(String screenId, int index, bool value) {
//     if (!_challengeValuesMap.containsKey(screenId)) {
//       _challengeValuesMap[screenId] = List<bool>.generate(20, (index) => false);
//     }
//     _challengeValuesMap[screenId]![index] = value;
//     _saveChallengeValues(screenId);
//     notifyListeners();
//   }

//   Future<void> _saveChallengeValues(String screenId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<bool> values = _challengeValuesMap[screenId]!;
//     List<String> stringValues =
//         values.map((value) => value.toString()).toList();
//     prefs.setStringList(screenId, stringValues);
//   }

//   Future<void> loadSavedChallengeValues(String screenId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? savedValues = prefs.getStringList(screenId);
//     if (savedValues != null && savedValues.length == 20) {
//       List<bool> values = savedValues.map((value) => value == 'true').toList();
//       _challengeValuesMap[screenId] = values;
//       notifyListeners();
//     }
//   }
// }
