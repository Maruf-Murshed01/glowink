import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'catalog.dart';
import 'profile.dart';
import 'login.dart';
import 'register.dart';
import 'cart.dart';
import 'admin_panel.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'firebase_options.dart';
import 'firebase_config.dart';
import 'widgets/auth_wrapper.dart';
import 'widgets/auth_guard.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: FirebaseConfig.platformOptions,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glowing Ink - University Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        colorScheme: ColorScheme.light(
          primary: Colors.blue[900]!,
          secondary: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Arial',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[900],
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const AuthWrapper(),
      routes: {
        '/catalog': (context) => AuthGuard(child: CatalogPage()),
        '/profile': (context) => AuthGuard(child: ProfilePage()),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/register': (context) => const SignupScreen(),
        '/cart': (context) => AuthGuard(child: CartPage()),
      },
    );
  }
}
