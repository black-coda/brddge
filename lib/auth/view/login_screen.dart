import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static String path = '/login';
  static String name = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.black,
            ],
            stops: [0.4, 0.8],
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Login'),
          ),
        ),
      ),
    );
  }
}
