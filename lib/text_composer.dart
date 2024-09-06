import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
  const TextComposer({super.key});

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.photo_camera),
          ),
          Expanded(
              child: TextField(
                decoration: const InputDecoration.collapsed(hintText: 'Enviar uma Mensagem'),
                onChanged: (text){
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: (text){},
              ),
          ),
          IconButton(
              onPressed: _isComposing ? (){}: null,
              icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
