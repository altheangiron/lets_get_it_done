import 'package:flutter/material.dart';
import 'package:lets_get_it_done/screens/intro_screen.dart';
import 'package:lets_get_it_done/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'lets get it done',
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}
