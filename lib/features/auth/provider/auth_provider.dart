import 'package:flutter/material.dart';
import '../data/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  bool isLoading = false;

  Future<bool> signUp(String email, String password) async {
    isLoading = true;
    notifyListeners();
    var user = await _authRepository.signUp(email, password);
    isLoading = false;
    notifyListeners();
    return user != null;
  }

  Future<bool> signIn(String email, String password) async {
    isLoading = true;
    notifyListeners();
    var user = await _authRepository.signIn(email, password);
    isLoading = false;
    notifyListeners();
    return user != null;
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    notifyListeners();
  }
}
