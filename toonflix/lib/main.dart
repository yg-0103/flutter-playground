import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';
import 'package:toonflix/services/api_service.dart';

void main() {
  ApiService().getTodaysToons();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          backgroundColor: const Color(0xFFE7626C),
          textTheme: const TextTheme(
            headline1: TextStyle(color: Color(0XFF232B55)),
          ),
          cardColor: const Color(0xFFF4EDDB)),
      home: const HomeScreen(),
    );
  }
}
