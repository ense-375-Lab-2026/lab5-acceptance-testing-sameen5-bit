import 'package:flutter/material.dart';
import 'bmi.dart';

/// Dur e Sameen Bukhari
/// 200542362
/// This file defines a simple `MaterialApp` that displays the [BMI] widget
/// as its home page. The BMI app itself is defined in `bmi.dart`.
void main() {
  runApp(const MyApp());
}

/// [MyApp] sets up some basic theming and displays the [BMI] widget as
/// the application home screen.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BMI(),
    );
  }
}