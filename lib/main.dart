import 'dart:async';

import 'package:chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      print("[MAIN] Iniciando a inicialização do Firebase...");

      // Verifique e remova qualquer instância anterior do Firebase
      if (Firebase.apps.isNotEmpty) {
        await Firebase.app().delete();  // Remove a instância do Firebase se existir
        print("[MAIN] Instância anterior do Firebase removida.");
      }

      // Inicialize o Firebase com firebase_options.dart
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print("[MAIN] Firebase inicializado com sucesso.");

      runApp(const MyApp());
      print("[MAIN] Aplicativo iniciado com sucesso.");
    } catch (e) {
      print("[MAIN] Erro na inicialização do Firebase: $e");
    }
  }, (error, stackTrace) {
    print("[MAIN] Erro capturado no runZonedGuarded: $error");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("[MAIN] Construindo o widget MyApp...");
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
