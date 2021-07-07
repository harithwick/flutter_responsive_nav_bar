import 'package:flutter/material.dart';
import 'package:flutter_responsive_nav_bar/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Nav Bar',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
