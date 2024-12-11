import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:betlecare/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 5 seconds, then navigate to the MainPage
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              "https://lottie.host/08fd21f4-4d0f-4ddd-a7a6-9434caa397b6/lykm1jOaUY.json",
              fit: BoxFit.cover,
              width: 300,
              height: 250,
            ),
          ],
        ),
      ),
    );
  }
}
