import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import '../data/auth_repository.dart';

class AuthProviderr with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoading = true; // Initial loading state
  bool get isLoading => _isLoading;
  User? get user => _user;

  AuthProviderr() {
    _checkUserStatus(); // Check user on app start
  }

  // Check authentication state
  void _checkUserStatus() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<bool> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    var user = await _authRepository.signUp(email, password);
    _isLoading = false;
    notifyListeners();
    return user != null;
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    var user = await _authRepository.signIn(email, password);
    _isLoading = false;
    notifyListeners();
    return user != null;
  }

  // Future<bool> signInWithGoogle() async {
  //   try {
  //     _isLoading = true;
  //     notifyListeners();

  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) {
  //       _isLoading = false;
  //       notifyListeners();
  //       return false;
  //     }

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //     final OAuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     await _auth.signInWithCredential(credential);

  //     _isLoading = false;
  //     notifyListeners();
  //     return true;
  //   } catch (error) {
  //     debugPrint("Google Sign-In error: $error");
  //     _isLoading = false;
  //     notifyListeners();
  //     return false;
  //   }
  // }

  Future<void> signOut() async {
    await _authRepository.signOut();
    notifyListeners();
  }
}
