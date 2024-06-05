import 'package:flutter/material.dart';
import 'package:healthy/challenges/const%20challenges/card_community.dart';
import 'package:healthy/challenges/const%20challenges/const.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: RichText(
                text: const TextSpan(
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                  TextSpan(
                    text: "  Connect with  our Community",
                  ),
                ])),
          ),
          body: Column(
            children: [
              kheight10,
              Expanded(
                  child: SingleChildScrollView(child: challengeItems(context))),
            ],
          )),
    );
  }
}
