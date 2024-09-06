# chat

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Credentials Firebase

    import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
    
    class DefaultFirebaseOptions {
        static FirebaseOptions get currentPlatform {
            return const FirebaseOptions(
                apiKey: '******',  // Chave de API da Web
                appId: '*****',  // Número do projeto (pode ser o App ID se necessário)
                messagingSenderId: '*******',  // Número do projeto (use o mesmo valor como Messaging Sender ID)
                projectId: '******',  // Código do projeto
            );
        }
    }

