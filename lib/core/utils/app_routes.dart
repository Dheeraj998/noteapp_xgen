import 'package:flutter/material.dart';
import 'package:notes_app_xgen/features/auth/view/login_screen.dart';
import 'package:notes_app_xgen/features/auth/view/signup_screen.dart';
import 'package:notes_app_xgen/features/notes/view/notes_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String signup = '/signup';
  static const String notes = '/notes';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
    notes: (context) => const NotesScreen(),
  };
}
