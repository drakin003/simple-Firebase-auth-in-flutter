import 'package:flutter/material.dart';

import '../services/firebase_services.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future logoutuser() async {
    try {
      await FirebaseServices().logout();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User Logout Successfully"),
          ),
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
          centerTitle: true,
        ),
        body: Center(
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            padding: const EdgeInsets.all(8.0),
            width: 400,
            height: 300,
            child: Column(
              children: [
                const Text(
                  "Home Screen",
                  style: TextStyle(fontSize: 32),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    logoutuser();
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                )
              ],
            ),
          ),
        ));
  }
}
