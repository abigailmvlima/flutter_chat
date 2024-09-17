import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'componts/auth_manager.dart';
import 'componts/message_list.dart';
import 'componts/text_composer.dart';

import 'firebase_options.dart'; // Certifique-se de que o arquivo firebase_options.dart está sendo importado corretamente

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AuthManager _authManager = AuthManager();
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _checkFirebaseInitialization();
  }

  void _checkFirebaseInitialization() {
    if (Firebase.apps.isNotEmpty) {
      print("[ChatScreen] Firebase está inicializado, ouvindo authStateChanges.");
      // FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //   print("[ChatScreen] authStateChanges recebido. Usuário: ${user?.displayName ?? 'Nenhum usuário logado'}");
      //   setState(() {
      //     _currentUser = user;
      //   });
      // });
    } else {
      print("[ChatScreen] Firebase não está inicializado.");
    }
  }

  void _sendMessage({String? text, File? imgFile}) async {
    // final User? user = await _authManager.getUser(context, _currentUser, (User? user) {
    //   setState(() {
    //     _currentUser = user;
    //   });
    // });
    //
    // if (user == null) {
    //   print('[ChatScreen] Não foi possível enviar a mensagem, o usuário não está logado.');
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Não foi possível fazer o login. Tente novamente'),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    //   return;
    // }

    print('[ChatScreen] Enviando mensagem...');

    // Map<String, dynamic> data = {
    //   'uid': user.uid,
    //   'displayName': user.displayName,
    //   'photoURL': user.photoURL,
    //   'timestamp': Timestamp.now(),
    // };



    Map<String, dynamic> data = {
      'uid': 'jhjuuhhhh',
      'senderName': 'Abigail',
      'senderPhotoUrl': 'photo',
      'timestamp': Timestamp.now(),
    };

    if (imgFile != null) {
      try {
        print('[ChatScreen] Upload de imagem em andamento...');
        UploadTask task = FirebaseStorage.instance
            .ref()
            .child(DateTime.now().millisecondsSinceEpoch.toString())
            .putFile(imgFile);

        TaskSnapshot snapshot = await task.whenComplete(() => null);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        data['imgUrl'] = downloadUrl;
        print('[ChatScreen] Imagem enviada com sucesso. URL: $downloadUrl');
      } catch (e) {
        print("[ChatScreen] Erro ao fazer upload da imagem: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao enviar a imagem.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (text != null && text.isNotEmpty) {
      data['text'] = text;
    }

    if (data.isNotEmpty) {
      print('[ChatScreen] Enviando dados da mensagem para o Firestore...');
      FirebaseFirestore.instance.collection('messages').add(data);
      print('[ChatScreen] Mensagem enviada com sucesso.');
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
          const MessageList(),
          TextComposer(sendMessage: _sendMessage),
        ],
      ),
    );
  }
}
