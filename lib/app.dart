import 'package:flutter/material.dart';
import 'screens/menu_screen.dart';

class MyGame extends StatelessWidget {
  const MyGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'لعبة التطابق',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MenuScreen(),
    );
  }
}