import 'package:flutter/material.dart';
import 'view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VPN App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 26, 40, 56),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 26, 40, 56),
          elevation: 0,
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}