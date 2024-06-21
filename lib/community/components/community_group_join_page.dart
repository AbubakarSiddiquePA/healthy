import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthy/community/components/community_chat_page.dart';

class Group extends StatefulWidget {
  final String groupId;

  const Group({super.key, required this.groupId});

  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  bool _isRequestSent = false;
  bool _isRequestApproved = false;
  String _groupName = '';

  @override
  void initState() {
    super.initState();
    checkJoinRequestStatus();
  }

  Future<void> checkJoinRequestStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final requestSnapshot = await FirebaseFirestore.instance
          .collection('joinRequests')
          .where('email', isEqualTo: user.email)
          .where('groupId', isEqualTo: widget.groupId)
          .get();

      if (requestSnapshot.docs.isNotEmpty) {
        final request = requestSnapshot.docs.first;
        final status = request['status'] == 'approved';
        if (mounted) {
          setState(() {
            _isRequestSent = true;
            _isRequestApproved = status;
          });
        }
      }
    }
  }

  Future<void> sendJoinRequest() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection("joinRequests").add({
          "email": user.email,
          "groupId": widget.groupId,
          "status": "pending",
          "timestamp": FieldValue.serverTimestamp(),
        });
        if (mounted) {
          setState(() {
            _isRequestSent = true;
          });
        }
      } catch (e) {
        print("Failed to send join request: $e");
      }
    } else {
      print("No user is signed in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('groups')
              .doc(widget.groupId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text('Group not found');
            }
            final group = snapshot.data!;
            _groupName = group['name'];
            return Text(
              "Community: $_groupName",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            );
          },
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('groups')
            .doc(widget.groupId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading group details'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Group not found'));
          }
          final group = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 500,
                  height: 150,
                  child: Center(
                      child: CircleAvatar(
                          backgroundColor: Colors.limeAccent[400],
                          child: const FaIcon(FontAwesomeIcons.message))),
                ),
                Text(
                  "Group Description: ${group['description']}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              // foregroundColor:
                              //     const Color.fromARGB(255, 202, 85, 85),
                              backgroundColor: _isRequestSent
                                  ? Colors.grey
                                  : Colors.white, // Text color
                            ),
                            onPressed: _isRequestSent ? null : sendJoinRequest,
                            icon: Icon(
                              _isRequestSent ? Icons.check : Icons.add,
                              color: Colors.black,
                            ),
                            label: Text(
                              _isRequestSent ? 'Request Sent' : 'Join Group',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              _isRequestApproved
                                  ? "Approved"
                                  : _isRequestSent
                                      ? "Waiting for approval"
                                      : "Send request to join-${group['name']} group",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Please check chat box and tap on the chat icon to ensure whether you're in the group or not \n Tap on Join group if chat box not found",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (_isRequestSent)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _isRequestApproved
                              ? """You are in our '$_groupName' community. Enjoy chatting!"""
                              : "Request sent, waiting for approval.",
                          style: TextStyle(
                            color:
                                _isRequestApproved ? Colors.blue : Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 225, 222, 222),
                          child: IconButton(
                            onPressed: _isRequestApproved
                                ? () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => GroupChat(
                                          communityId: widget.groupId,
                                        ),
                                      ),
                                    );
                                  }
                                : () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content:
                                            Text('Request not approved yet.'),
                                      ),
                                    );
                                  },
                            icon: const Icon(Icons.chat),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
