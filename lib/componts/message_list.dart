import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('messages').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              List<DocumentSnapshot> documents = snapshot.data!.docs.reversed.toList();
              return ListView.builder(
                itemCount: documents.length,
                reverse: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      (documents[index].data() as Map<String, dynamic>?)?['text'] ?? '',
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
