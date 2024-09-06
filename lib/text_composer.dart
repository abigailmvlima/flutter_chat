import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {

  final Function(String) sendMessage;

  const TextComposer({super.key, required this.sendMessage});


  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();

  bool _isComposing = false;

  void _reset(){
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

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
                controller: _controller,
                decoration: const InputDecoration.collapsed(hintText: 'Enviar uma Mensagem'),
                onChanged: (text){
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: (text){
                  widget.sendMessage(text);
                  _reset();
                },
              ),
          ),
          IconButton(
              onPressed: _isComposing ? (){
                widget.sendMessage(_controller.text);
              }: null,
              icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
