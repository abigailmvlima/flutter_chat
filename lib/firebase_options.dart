import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'AlzaSyAL-GR7oMASdPGShWxy-YpTxNwxuFknVGk',  // Chave de API da Web
      appId: '942403201097',  // Número do projeto (pode ser o App ID se necessário)
      messagingSenderId: '942403201097',  // Número do projeto (use o mesmo valor como Messaging Sender ID)
      projectId: 'chatflutter-37469',  // Código do projeto
    );
  }
}
