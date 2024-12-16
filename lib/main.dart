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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glowing Ink - University Shop',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        primaryColor: Colors.blue[900], // Blueish theme
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
      home: HomePage(),
      routes: {
        '/catalog': (context) => CatalogPage(),
        '/profile': (context) => ProfilePage(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/register': (context) => SignupScreen(),
        '/cart': (context) => CartPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
      },
    );
  }
}
