import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'firebase_options.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  void _sendMessage({String? text, File? imgFile}) async {

    Map<String, dynamic> data = {};

    // Se houver uma imagem, faça o upload
    if (imgFile != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(imgFile);

      // Aguardar o upload ser concluído
      TaskSnapshot snapshot = await task.whenComplete(() => null);


      // Obter a URL do arquivo enviado
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Adicionar a URL da imagem aos dados da mensagem
      data['imgUrl'] = downloadUrl;
    }

    // Se houver um texto, adicione-o aos dados da mensagem
    if (text != null && text.isNotEmpty) {
      data['text'] = text;
    }

    // Enviar os dados para o Firestore
    if (data.isNotEmpty) {
      FirebaseFirestore.instance.collection('messages').add(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Olá'),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: TextComposer(sendMessage: _sendMessage),
    );
  }
}

class TextComposer extends StatefulWidget {
  final Function({String? text, File? imgFile}) sendMessage;

  const TextComposer({super.key, required this.sendMessage});

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final TextEditingController _controller = TextEditingController();
  File? _imgFile;
  bool _isComposing = false;

  void _reset() {
    _controller.clear();
    setState(() {
      _isComposing = false;
      _imgFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              print('aqui');
              final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
              print('aqui666');

              if (pickedFile != null) {
                print('aqui2');
                print(pickedFile.path);

                setState(() {
                  // Convertendo XFile para File
                  _imgFile = File(pickedFile.path);
                });
              }
            },
            icon: const Icon(Icons.photo_camera),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(hintText: 'Enviar uma mensagem'),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty || _imgFile != null;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text: text, imgFile: _imgFile);
                _reset();
              },
            ),
          ),
          IconButton(
            onPressed: _isComposing
                ? () {
              widget.sendMessage(text: _controller.text, imgFile: _imgFile);
              _reset();
            }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
