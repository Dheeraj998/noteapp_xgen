import 'package:flutter/material.dart';
import 'package:notes_app_xgen/core/utils/app_colors.dart';
import 'package:notes_app_xgen/widgets/custom_text.dart';
import 'package:notes_app_xgen/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../../../core/utils/app_routes.dart';
import '../../../widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
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
              const SizedBox(height: 16),
              CustomTextField(
                controller: confirmPasswordController,
                labelText: 'Confirm Password',
                obscureText: true,
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
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
                    buttonColor: AppColors.secondary,
                    buttonWidth: double.maxFinite,
                    buttonStyle: const TextStyle(color: AppColors.white),
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        bool success = await auth.signUp(
                            emailController.text, passwordController.text);
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Account created successfully')));
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.login);
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
                child:
                    const CommonText(text: 'Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
