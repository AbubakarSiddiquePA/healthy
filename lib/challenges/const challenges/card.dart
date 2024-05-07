import 'package:flutter/material.dart';
import 'package:healthy/challenges/confidence.dart/confidence.dart';
import 'package:healthy/challenges/const%20challenges/const.dart';
import 'package:healthy/challenges/familytime.dart/familytime.dart';
import 'package:healthy/challenges/fixsleep.dart/fixsleep.dart';
import 'package:healthy/challenges/happines.dart/happines.dart';
import 'package:healthy/challenges/homeworkout.dart/homeworkout.dart';
import 'package:healthy/challenges/language.dart/language.dart';
import 'package:healthy/challenges/morningroutine.dart/morngroutine.dart';

import 'package:healthy/challenges/socialmedia.dart/socialmedia.dart';
import 'package:healthy/challenges/study/study.dart';
import 'package:healthy/challenges/walking.dart/walking.dart';

import '../../challenges/selflovee.dart/selflove.dart';

Widget buildChallengeCard(
    BuildContext context, String imageAsset, String title, Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(width: 1, color: korangecolor),
            color: kwhite),
        child: Column(
          children: [
            Image.asset(
              imageAsset,
              width: 130,
              height: 90,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ),
  );
}

GridView challengeitemss(BuildContext context) {
  return GridView.count(
    crossAxisCount: 2,
    crossAxisSpacing: 10.0,
    mainAxisSpacing: 10.0,
    childAspectRatio: 1.2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(20.0),
    children: [
      buildChallengeCard(context, "images/loveeee.jpeg", "Self love", () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const SelfLove()));
      }),
      buildChallengeCard(context, "images/walking.png", "Walking", () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const Walking()));
      }),
      buildChallengeCard(context, "images/nophone.png", "Digital Detox", () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const SocialMedia()));
      }),
      buildChallengeCard(context, "images/slp.jpeg", "Better Sleep", () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const FixSleep()));
      }),
      buildChallengeCard(context, "images/morning.jpeg", "Morning Routine", () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const MorningRoutine()));
      }),
      buildChallengeCard(context, "images/confident2.jpeg", "Confidence", () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const confidence()));
      }),
      buildChallengeCard(context, "images/language2.jpg", "Language", () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const Language()));
      }),
      buildChallengeCard(context, "images/happy jump2.jpeg", "Happiness", () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const Happiness()));
      }),
      buildChallengeCard(context, "images/family.jpeg", "Family Time", () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const FamilyTime()));
      }),
      buildChallengeCard(context, "images/workout.jpeg", "Home Workout", () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const HomeWorkout()));
      }),
      buildChallengeCard(context, "images/study.png", "Study", () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const Study()));
      }),
    ],
  );
}
