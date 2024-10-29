import 'package:app3/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgotEmailController = TextEditingController();
  bool isLoading = false;

  forgotpassword() {
    try {
      if (forgotEmailController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please Enter Email"),
          ),
        );
      } else {
        setState(() {
          isLoading = true;
        });
        String userEmail = forgotEmailController.text;
        FirebaseServices().resetPassword(userEmail);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Forgot Password"),
            TextField(
              controller: forgotEmailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 8,
                shape: const RoundedRectangleBorder(),
              ),
              onPressed: () {
                forgotpassword();
              },
              child: isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text('Send Email'),
            )
          ],
        ),
      ),
    );
  }
}
