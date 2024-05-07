import 'package:flutter/material.dart';

import 'package:healthy/challenges/const%20challenges/savebuttonstate.dart';
import 'package:healthy/challenges/const%20challenges/showdialogue.dart';
import 'package:provider/provider.dart';
import 'package:healthy/challenges/const%20challenges/const.dart';

class confidenceChallange extends StatefulWidget {
  confidenceChallange({Key? key}) : super(key: key);

  @override
  _confidenceChallangeState createState() => _confidenceChallangeState();
}

class _confidenceChallangeState extends State<confidenceChallange> {
  final List<String> challenges = [
    "Each day, write down one thing you appreciate about yourself.",
    "Challenge negative self-talk by replacing it with positive affirmations.",
    "Set a goal to step out of your comfort zone at least once a week.",
    "Practice good posture and body language to convey confidence.",
    "Reflect on your achievements and past successes to boost your self-esteem.",
    "Try a new skill or hobby to expand your abilities and build self-assurance.",
    "Compliment others sincerely and notice how it lifts your own confidence.",
    "Dress in a way that makes you feel confident and empowered.",
    "Eliminate 'should' and 'must' from your self-talk to foster self-acceptance.",
    "Visualize yourself succeeding in a challenging situation to boost your confidence.",
    "Speak up and share your thoughts in group discussions or meetings.",
    "Accept compliments graciously instead of downplaying your achievements.",
    "Practice positive self-affirmations in front of the mirror each morning.",
    "Reflect on past obstacles you've overcome and how they've made you stronger.",
    "Surround yourself with supportive and positive people who uplift your confidence.",
  ];

  List<bool> challengeValues = List<bool>.generate(15, (index) => false);
  @override
  void initState() {
    super.initState();
    // Load the saved checkbox states when the screen is initialized.
    _loadSavedChallengeValues();
  }

  Future<void> _loadSavedChallengeValues() async {
    await context
        .read<ChallengeState>()
        .loadSavedChallengeValues('confidenceChallange');
    // Set the loaded checkbox values to the local variable.
    setState(() {
      challengeValues = context
          .read<ChallengeState>()
          .getChallengeValues('confidenceChallange');
    });
  }

  @override
  Widget build(BuildContext context) {
    List<bool> challengeValues = context
        .watch<ChallengeState>()
        .getChallengeValues('confidenceChallange');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Confidence",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [Showdialoguee(challengeValues: challengeValues)],
      ),
      body: Column(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Mark the completed challenges",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: kredcolor),
            ),
          ),
          kheight20,
          Expanded(
            child: ListView.builder(
              itemCount: challenges.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: korangecolor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: kwhite,
                          checkColor: kredcolor,
                          side: BorderSide(color: kredcolor, width: 2),
                          value: challengeValues[index],
                          onChanged: (newValue) {
                            context.read<ChallengeState>().updateChallengeValue(
                                'confidenceChallange',
                                index,
                                newValue ?? false);
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              challenges[index],
                              style: TextStyle(fontSize: 16, color: kblack),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
