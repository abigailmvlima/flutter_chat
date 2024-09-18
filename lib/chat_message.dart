import 'dart:math';

import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(this.data, this.mine, {super.key});

  final Map<String, dynamic> data;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          !mine ?
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
            backgroundImage: data['senderPhotoUrl'] != null
            ? NetworkImage(data['senderPhotoUrl'] as String) // Converte a string da URL em um NetworkImage
                  : const NetworkImage('https://via.placeholder.com/150'), // Placeholder simples
          ),
          ) : Container(),
          Expanded(
              child: Column(
                crossAxisAlignment: mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  data['imgUrl'] != null
                      ? Image.network(data['imgUrl'] as String, width: 250,)
                      : Text(
                        data['text'] ?? '', // Se 'text' for nulo, mostra uma string vazia,
                        textAlign: mine ? TextAlign.end : TextAlign.start,
                        style: const TextStyle(
                          fontSize: 18
                        ),
                      ),
                  Text(
                    data['senderName'] ?? '', // Se 'senderName' for nulo, mostra uma string vazia,
                      style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              )
          ),
          mine ?
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: data['senderPhotoUrl'] != null
                  ? NetworkImage(data['senderPhotoUrl'] as String) // Converte a string da URL em um NetworkImage
                  : const NetworkImage('https://via.placeholder.com/150'), // Placeholder simples
            ),
          ) : Container(),
        ],
      ),
    );
  }
}
