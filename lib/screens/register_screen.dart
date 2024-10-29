import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../services/firebase_services.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future registeruser() async {
    setState(() {
      _isLoading = true;
    });
    var userEmail = emailController.text;
    var userPassword = passwordController.text;

    try {
      await FirebaseServices().register(userEmail, userPassword);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User Created Successfully")));

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register Screen'),
          centerTitle: true,
        ),
        body: Center(
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: 400,
            height: 300,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Register',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: emailController,
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
                  controller: passwordController,
                  decoration: const InputDecoration(
                      label: Text("Password"),
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      registeruser();
                    },
                    style: ElevatedButton.styleFrom(elevation: 8),
                    child: _isLoading
                        ? const CircularProgressIndicator.adaptive()
                        : const Text(
                            "Register",
                            style: TextStyle(fontSize: 22),
                          )),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(
                    TextSpan(text: "Already have an account? ", children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                      },
                    text: "Login",
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  )
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
