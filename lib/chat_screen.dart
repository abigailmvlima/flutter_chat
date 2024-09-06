import 'package:chat/text_composer.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Olá'),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: const TextComposer(),
    );
  }
}
