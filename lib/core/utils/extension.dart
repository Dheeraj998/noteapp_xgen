import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ProviderExtension on BuildContext {
  AuthProvider get authProvider =>
      Provider.of<AuthProvider>(this, listen: false);
}
