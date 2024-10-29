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
  bool _isLoading = false;

  forgotpassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (forgotEmailController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter a Email"),
          ),
        );
      } else {
        String userEmail = forgotEmailController.text;
        await FirebaseServices().resetPassword(userEmail);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Email Sent Successfully"),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      }
    } finally {
      setState(() {
        _isLoading = false;
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
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          padding: const EdgeInsets.all(8.0),
          width: 400,
          height: 350,
          child: Column(
            children: [
              const Text("Forgot Password"),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: forgotEmailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () {
                  forgotpassword();
                },
                child: _isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : const Text('Send Email'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
