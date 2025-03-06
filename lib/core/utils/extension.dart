import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_xgen/features/auth/provider/auth_provider.dart';
import 'package:notes_app_xgen/features/notes/provider/notes_provider.dart';
import 'package:provider/provider.dart';

extension ProviderExtension on BuildContext {
  AuthProviderr get authProvider =>
      Provider.of<AuthProviderr>(this, listen: false);
  NotesProvider get noteProvider =>
      Provider.of<NotesProvider>(this, listen: false);
}
