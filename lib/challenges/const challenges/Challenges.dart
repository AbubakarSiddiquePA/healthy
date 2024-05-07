import 'package:flutter/material.dart';
import 'package:healthy/challenges/const%20challenges/card.dart';
import 'package:healthy/challenges/const%20challenges/const.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            centerTitle: true,
            title: RichText(
                text: const TextSpan(
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                  TextSpan(
                    text: "  Connect with our Community",
                  ),
                ])),
            // title: Text("Your habits will \ndetermine your future"),
          ),
          body: Column(
            children: [
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: 10),
              //   child: Text(
              //     "",
              //     style: TextStyle( ),
              //   ),
              // ),
              kheight10,
              Expanded(
                  child:
                      SingleChildScrollView(child: challengeitemss(context))),
            ],
          )),
    );
  }
}
