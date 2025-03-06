import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app_xgen/core/services/firebase_auth_service.dart';

class AuthRepository {
  final FirebaseAuthService _authService = FirebaseAuthService();

  Future<User?> signUp(String email, String password) {
    return _authService.signUp(email, password);
  }

  Future<User?> signIn(String email, String password) {
    return _authService.signIn(email, password);
  }

  Future<void> signOut() {
    return _authService.signOut();
  }
}
