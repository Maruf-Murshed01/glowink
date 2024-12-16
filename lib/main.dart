import 'package:flutter/material.dart';
import 'home.dart';
import 'catalog.dart';
import 'profile.dart';
import 'login.dart';
import 'register.dart';
import 'cart.dart';
import 'admin_panel.dart';

void main() {
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
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/cart': (context) => CartPage(),
      },
    );
  }
}
