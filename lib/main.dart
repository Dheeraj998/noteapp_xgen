import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app_xgen/core/utils/app_routes.dart';
import 'package:notes_app_xgen/core/utils/theme_provider.dart';
import 'package:notes_app_xgen/features/auth/provider/auth_provider.dart';
import 'package:notes_app_xgen/features/notes/provider/notes_provider.dart';
import 'package:notes_app_xgen/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProviderr()),
      ChangeNotifierProvider(create: (_) => NotesProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    builder: (context, state) {
      return MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Xgen Notes',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: themeProvider.themeData, // Apply Dynamic Theme

      // home: LoginScreen(),
    );
  }
}
