// import 'package:flutter/material.dart';

// class Showdialoguee extends StatelessWidget {
//   const Showdialoguee({
//     super.key,
//     required this.challengeValues,
//   });

//   final List<bool> challengeValues;

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         bool allChallengesCompleted = challengeValues.every((value) => value);
//         if (allChallengesCompleted) {
//           showDialog<String>(
//             context: context,
//             builder: (BuildContext context) => AlertDialog(
//               content: const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   "If you have completed all the challenges, you can share your achievements.",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () => Navigator.pop(context, 'Cancel'),
//                   child: const Text('Cancel'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // Implement your share functionality here
//                     // ...
//                     Navigator.pop(context); // Close the dialog after sharing
//                   },
//                   child: const Text('Share'),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           showDialog<String>(
//             context: context,
//             builder: (BuildContext context) => AlertDialog(
//               content: const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'Make sure to tick all challenges before you share.',
//                   style: TextStyle(fontSize: 20),
//                 ),
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () => Navigator.pop(context, 'Cancel'),
//                   child: const Text('OK'),
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//       icon: const Icon(Icons.info),
//     );
//   }
// }
