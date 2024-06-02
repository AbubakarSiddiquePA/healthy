import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy/challenges/groups_chat/group_join_page.dart';

Widget buildChallengeCard(
    BuildContext context, String imageUrl, String title, Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(width: 1, color: Colors.orange),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Image.asset(
              imageUrl,
              width: 130,
              height: 90,
              fit: BoxFit.cover,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
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
          final data = group.data() as Map<String, dynamic>;

          // Check if 'coverImage' exists and is not null, otherwise use a default image
          String coverImageUrl =
              data.containsKey('coverImage') && data['coverImage'].isNotEmpty
                  ? data['coverImage']
                  : 'images/alarm.jpeg'; // default image URL

          return buildChallengeCard(
            context,
            coverImageUrl,
            data['name'],
            () {
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
