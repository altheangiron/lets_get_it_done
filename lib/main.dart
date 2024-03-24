import 'package:flutter/material.dart';
import 'package:lets_get_it_done/screens/home_screen.dart';
import 'package:lets_get_it_done/screens/intro_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lets get it done',
      debugShowCheckedModeBanner: false,
      // routing 
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroScreen(),
        /* HomeScreen() includes Add Task + Delete Task Alert Dialogs (two other "screens") */
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
