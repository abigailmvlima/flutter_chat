import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(this.data, {super.key});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
            backgroundImage: data['senderPhotoUrl'] != null
            ? NetworkImage(data['senderPhotoUrl'] as String) // Converte a string da URL em um NetworkImage
                  : const NetworkImage('https://via.placeholder.com/150'), // Placeholder simples
          ),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  data['imgUrl'] != null
                      ? Image.network(data['imgUrl'] as String)
                      : Text(
                        data['text'] ?? '', // Se 'text' for nulo, mostra uma string vazia,
                        style: const TextStyle(
                          fontSize: 16
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
        ],
      ),
    );
  }
}
