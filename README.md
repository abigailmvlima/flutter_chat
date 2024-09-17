# Chat

# Para obter a chave SHA1.

Windows
keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

Linux/Mac
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android

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

