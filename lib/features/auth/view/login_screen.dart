// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_xgen/core/utils/app_colors.dart';
import 'package:notes_app_xgen/core/utils/app_routes.dart';
import 'package:notes_app_xgen/core/utils/custom_log.dart';
import 'package:notes_app_xgen/features/auth/provider/auth_provider.dart';
import 'package:notes_app_xgen/widgets/custom_button.dart';
import 'package:notes_app_xgen/widgets/custom_text.dart';
import 'package:notes_app_xgen/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter email';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: passwordController,
                labelText: 'Password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Consumer<AuthProviderr>(builder: (context, auth, _) {
                return CommonButton(
                    onLoading: auth.isLoading,
                    buttonHeight: 50,
                    borderRadius: 5,
                    buttonWidth: double.maxFinite,
                    buttonColor: AppColors.secondary,
                    buttonStyle: const TextStyle(color: AppColors.white),
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        bool success = await auth.signIn(
                            emailController.text, passwordController.text);
                        if (success) {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.notes);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Welcome back')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login Failed')));
                        }
                      }
                    },
                    buttonText: "Login");
              }),
              const SizedBox(height: 30),

              // Google Sign-In Button
              Consumer<AuthProviderr>(builder: (context, auth, _) {
                return CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(.1),
                  child: Image.asset(
                    'assets/images/google.png', // Ensure you have a Google icon in assets
                    height: 20,
                  ),
                );
                // ElevatedButton.icon(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: AppColors.white,
                //     // padding:
                //     //     const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(100),
                //     ),
                //     elevation: 2,
                //   ),
                //   onPressed: () async {
                //     // bool success = await auth.signInWithGoogle();
                //     // if (success) {
                //     //   Navigator.pushReplacementNamed(context, AppRoutes.notes);
                //     //   ScaffoldMessenger.of(context).showSnackBar(
                //     //     const SnackBar(content: Text('Google Sign-In Success')),
                //     //   );
                //     // } else {
                //     //   ScaffoldMessenger.of(context).showSnackBar(
                //     //     const SnackBar(content: Text('Google Sign-In Failed')),
                //     //   );
                //     // }
                //   },
                //   icon: ,
                //   label: const Text(
                //     "",
                //     style: TextStyle(color: Colors.black),
                //   ),
                // );
              }),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.signup),
                child:
                    const CommonText(text: 'Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
