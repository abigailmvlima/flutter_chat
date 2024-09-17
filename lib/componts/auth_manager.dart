import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthManager {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> getUser(BuildContext context, User? currentUser, Function(User? user) updateUserState) async {
    if (currentUser != null) return currentUser;

    try {
      print('[AuthManager] Iniciando o fluxo de login com o Google...');

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        print('[AuthManager] Login cancelado pelo usuário.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login cancelado pelo usuário.'),
            backgroundColor: Colors.red,
          ),
        );
        return null;
      }

      print('[AuthManager] Login bem-sucedido, GoogleSignInAccount: ${googleSignInAccount.email}');

      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      if (googleSignInAuthentication.idToken == null || googleSignInAuthentication.accessToken == null) {
        print('[AuthManager] Tokens inválidos.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro na autenticação do Google. Tokens inválidos.'),
            backgroundColor: Colors.red,
          ),
        );
        return null;
      }

      print('[AuthManager] Tokens obtidos com sucesso.');

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        print('[AuthManager] Login realizado com sucesso. Usuário: ${user.displayName}');
        updateUserState(user); // Atualiza o estado do usuário no ChatScreen
        return user;
      } else {
        print('[AuthManager] Erro: Usuário é nulo após login.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Falha ao obter informações do usuário.'),
            backgroundColor: Colors.red,
          ),
        );
        return null;
      }
    } catch (error) {
      print('[AuthManager] Erro ao fazer login: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao fazer login: $error'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }
}
