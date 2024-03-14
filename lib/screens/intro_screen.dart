import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lets_get_it_done/screens/home_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});
  
  @override
  State<IntroScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<IntroScreen> 
    with SingleTickerProviderStateMixin{

  // runs the splash screen immediately
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ));
    });
  }

  // helps with coming back to the home screen
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, 
      overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('let\'s get it done',
              style: TextStyle(
                fontSize: 50,
                color: Color(0xffcebb9c),
                fontFamily: 'cursive',
              ),
            ),
          ]
        ),
      ),
    );
  }
}