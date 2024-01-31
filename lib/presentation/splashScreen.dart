import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/presentation/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "images/splash_screen.jpg",
            fit: BoxFit.cover,
            width: width * 1,
            height: height * 0.74,
          ),
          SizedBox(
            height: height * 0.08,
          ),
          Text(
            "TOP MEADLINES",
            style: GoogleFonts.anton(
                letterSpacing: 0.06, color: Colors.green.shade700),
          ),
          SizedBox(
            height: height * 0.08,
          ),
          SpinKitChasingDots(
            color: Colors.blue,
            size: 40,
          )
        ]),
      )),
    );
  }
}
