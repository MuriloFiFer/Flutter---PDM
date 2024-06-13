import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Atributo para gerenciamento de autenticação
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método para fazer login do usuário
  Future<User?> loginUsuario(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Método para registrar um novo usuário
  Future<void> registerUsuario(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  // Método para fazer logout do usuário
  Future<void> logoutUsuario() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
