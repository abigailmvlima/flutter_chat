import 'package:chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';  // Importar Firestore

import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

  // await FirebaseFirestore.instance.collection("col").doc("doc").set({
  //   "texto": "daniel2",
  // });


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Flutter',
       debugShowCheckedModeBanner: false,
       theme: ThemeData(
           iconTheme: const IconThemeData(color: Colors.blue),
       ),
       home: const ChatScreen(),
    );
  }
}


