import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../chat_message.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('messages').orderBy('timestamp', descending: false).snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              List<DocumentSnapshot> documents = snapshot.data!.docs.toList();
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> documentData = documents[index].data() as Map<String, dynamic>;
                  return ChatMessage(
                      documentData, true);
                },
              );
          }
        },
      ),
    );
  }
}
