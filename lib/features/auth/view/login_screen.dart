import 'package:flutter/material.dart';
import 'package:notes_app_xgen/widgets/custom_textfield.dart';

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
        padding: const EdgeInsets.all(16.0),
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
                  if (value == null || value.length < 6)
                    return 'Password must be at least 6 characters';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // CustomButton(
              //         text: 'Login',
              //         onPressed: () async {
              //           if (_formKey.currentState!.validate()) {
              //             bool success = await authProvider.signIn(
              //                 emailController.text, passwordController.text);
              //             if (success) {
              //               Navigator.pushReplacementNamed(
              //                   context, AppRoutes.notes);
              //             } else {
              //               ScaffoldMessenger.of(context).showSnackBar(
              //                   const SnackBar(content: Text('Login Failed')));
              //             }
              //           }
              //         },
              //       ),
              const SizedBox(height: 16),
              // TextButton(
              //   onPressed: () => Navigator.pushNamed(context, AppRoutes.signup),
              //   child: const Text('Don\'t have an account? Sign Up'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
