import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../home.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          return const HomePage();
        }

        return const LoginScreen();
      },
    );
  }
}
