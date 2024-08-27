import 'package:assignment/screens/splash_screen.dart';
import 'package:assignment/utils/color.dart';
import 'package:assignment/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.secondaryTextColor),
        ),
      ),
      onGenerateRoute: Routes.generateRoute,
      home: const SplashScreen(),
    );
  }
}
