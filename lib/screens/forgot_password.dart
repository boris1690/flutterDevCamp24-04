import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_devcamp_ui/utils/validation.dart';
import 'package:flutter_devcamp_ui/widgets/custom_button.dart';
import 'package:flutter_devcamp_ui/widgets/custom_text_form_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.sendPasswordResetEmail(
          email: _emailController.text,
        );

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Reset Email Sent")));
      } on FirebaseAuthException {
        rethrow;
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed to Login")));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 24,
                ),
                Image.asset('assets/gifs/firebase_flutter.gif'),
                const SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                  controller: _emailController,
                  label: 'Email',
                  validator: (val) => Validators.emailValidation(val),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomButton(onPressed: _login, buttonText: 'Send Reset Email'),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
