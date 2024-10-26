import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../services/firebase_services.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController loginemailController = TextEditingController();
  final TextEditingController loginpasswordController = TextEditingController();

  Future loginuser() async {
    var userEmail = loginemailController.text;
    var userPassword = loginpasswordController.text;

    try {
      await FirebaseServices().login(userEmail, userPassword);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User Logged in Successfully")));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
      ),
      body: Center(
          child: AnimatedContainer(
        padding: const EdgeInsets.all(8.0),
        width: 400,
        height: 300,
        duration: const Duration(seconds: 1),
        child: Column(
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: loginemailController,
              decoration: const InputDecoration(
                  label: Text("Email"),
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
                obscureText: true,
                controller: loginpasswordController,
                decoration: const InputDecoration(
                  label: Text("Password"),
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(),
                )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  loginuser();
                },
                child: const Text(
                  "login",
                  style: TextStyle(fontSize: 22),
                )),
            const SizedBox(
              height: 10,
            ),
            Text.rich(TextSpan(text: "don't have an account? ", children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ));
                  },
                text: "Register",
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
              )
            ]))
          ],
        ),
      )),
    );
  }
}