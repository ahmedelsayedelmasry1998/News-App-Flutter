import 'package:flutter/material.dart';
import 'package:newsapplication/data/datasource/remote/apiService.dart';
import 'package:newsapplication/presentation/home.dart';
import 'package:newsapplication/presentation/splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hello World',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
