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
        title: const Text('Chat'),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('messages').snapshots(),
                  builder: (context, snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        List<DocumentSnapshot> documents =
                            snapshot.data!.docs.reversed.toList();

                        return ListView.builder(
                          itemCount: documents.length,
                          reverse: true,
                          itemBuilder: (context, index){
                            return ListTile(
                              title: Text((documents[index].data() as Map<String, dynamic>?)?['text'] ?? ''),
                            );
                          }
                        );
                    }
                  }
              )
          ),
          TextComposer(sendMessage: _sendMessage),
        ],
      )
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
              final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

              if (pickedFile != null) {
                setState(() {
                  // Convertendo XFile para File
                  _imgFile = File(pickedFile.path);
                });
              // Enviar automaticamente a imagem sem precisar pressionar o botão "send"
              widget.sendMessage(imgFile: _imgFile);
              _reset(); // Resetar depois de enviar
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
                  // Habilitar o botão de envio se houver texto
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                // Enviar apenas texto
                widget.sendMessage(text: text);
                _reset();
              },
            ),
          ),
          IconButton(
            onPressed: _isComposing
                ? () {
              // Enviar somente o texto
              widget.sendMessage(text: _controller.text);
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