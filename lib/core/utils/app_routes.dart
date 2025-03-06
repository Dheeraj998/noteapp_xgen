import 'package:flutter/material.dart';
import 'package:notes_app_xgen/features/auth/view/auth_wrapper_screen.dart';
import 'package:notes_app_xgen/features/auth/view/login_screen.dart';
import 'package:notes_app_xgen/features/auth/view/signup_screen.dart';
import 'package:notes_app_xgen/features/notes/view/add_note_screen.dart';
import 'package:notes_app_xgen/features/notes/view/notes_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String notes = '/notes';
  static const String addNote = '/addNote';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const AuthWrapper()); // Auth state check
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case addNote:
        return MaterialPageRoute(builder: (_) => const AddNoteScreen());
      case notes:
        return MaterialPageRoute(builder: (_) => const NotesScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page Not Found')),
          ),
        );
    }
  }
}
