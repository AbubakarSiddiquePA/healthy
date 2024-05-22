import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy/challenges/selflovee.dart/selflove.dart';

Widget buildChallengeCard(
    BuildContext context, String imageAsset, String title, Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(width: 1, color: Colors.orange),
            color: Colors.white),
        child: Column(
          children: [
            Image.asset(
              "images/angry.png",
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

Widget challengeItems(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('groups').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      final groups = snapshot.data!.docs;
      return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 1.2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        children: groups.map((group) {
          return buildChallengeCard(
            context,
            "images/images.jpeg",
            group['name'],
            () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (ctx) => GroupDetailPage(groupId: group.id),
              //   ),
              // );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => Group(groupId: group.id),
                ),
              );
            },
          );
        }).toList(),
      );
    },
  );
}
