import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الطقس الحالي'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wb_sunny,
              size: 100,
              color: Colors.orange,
            ),
            const SizedBox(height: 20),
            const Text(
              '27°C',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'مشمس',
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
