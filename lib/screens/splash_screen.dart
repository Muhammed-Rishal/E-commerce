import 'dart:async';

import 'package:ecommerce/screens/auth/login_screen.dart';
import 'package:ecommerce/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState(){
    super.initState();

    Timer(const Duration(seconds: 3), (){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen() ,));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/splash_logo.json'),
          ],
        ),
      ),
    );
  }
}
