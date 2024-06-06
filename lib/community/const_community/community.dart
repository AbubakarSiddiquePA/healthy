import 'package:flutter/material.dart';
import 'package:healthy/community/const_community/community_card.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

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
              Expanded(
                  child: SingleChildScrollView(child: communityItems(context))),
            ],
          )),
    );
  }
}
