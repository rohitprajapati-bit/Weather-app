import 'package:flutter/material.dart';
import 'package:weather/home_Page/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home_page(),
      debugShowCheckedModeBanner: false,
    );
  }
}
