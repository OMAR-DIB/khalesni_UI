import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:gradution_project/routes/app_route.dart';
import 'package:gradution_project/view/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the LoginScreen after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, AppRoute.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color
      body: Center(
        child: Icon(Icons.ac_unit_rounded,size: 200,)
      ),
    );
  }
}
