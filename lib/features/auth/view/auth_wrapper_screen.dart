import 'package:flutter/material.dart';
import 'package:notes_app_xgen/features/notes/view/notes_screen.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'login_screen.dart'; // Import your login screen

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderr>(context);

    // if (authProvider.isLoading) {
    //   return const Scaffold(
    //     body: Center(
    //         child:
    //             CircularProgressIndicator()), // Show loading while checking auth state
    //   );
    // } else
    if (authProvider.user != null) {
      return const NotesScreen(); // If logged in, show HomeScreen
    } else {
      return const LoginScreen(); // If not logged in, show LoginScreen
    }
  }
}
