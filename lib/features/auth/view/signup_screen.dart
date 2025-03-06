import 'package:flutter/material.dart';
import 'package:notes_app_xgen/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../../../core/utils/app_routes.dart';
import '../../../widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
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
              const SizedBox(height: 16),
              CustomTextField(
                controller: confirmPasswordController,
                labelText: 'Confirm Password',
                obscureText: true,
                validator: (value) {
                  if (value != passwordController.text)
                    return 'Passwords do not match';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // authProvider.isLoading
              //     ? const CircularProgressIndicator()
              //     : CustomButton(
              //         text: 'Sign Up',
              //         onPressed: () async {
              //           if (_formKey.currentState!.validate()) {
              //             bool success = await authProvider.signUp(emailController.text, passwordController.text);
              //             if (success) {
              //               Navigator.pushReplacementNamed(context, AppRoutes.notes);
              //             } else {
              //               ScaffoldMessenger.of(context).showSnackBar(
              //                 const SnackBar(content: Text('Signup Failed')),
              //               );
              //             }
              //           }
              //         },
              //       ),

              Consumer<AuthProvider>(builder: (context, auth, _) {
                return CommonButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        bool success = await auth.signUp(
                            emailController.text, passwordController.text);
                        if (success) {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.notes);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login Failed')));
                        }
                      }
                    },
                    buttonText: "Login");
              }),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
