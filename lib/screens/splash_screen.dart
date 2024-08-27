import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:assignment/screens/home_screen.dart';
import 'package:assignment/utils/color.dart';
import 'package:assignment/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: Lottie.asset('assets/animation/splash.json'),
            ),
            SizedBox(height: 10),
            FadeInUp(
              duration: Duration(milliseconds: 800),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Polar",
                      style: GoogleFonts.inclusiveSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: "tern",
                      style: GoogleFonts.inclusiveSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
