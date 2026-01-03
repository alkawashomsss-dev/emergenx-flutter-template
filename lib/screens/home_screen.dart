import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تتبع المصاريف'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'مرحبًا بك في تطبيق تتبع المصاريف',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('قم بإضافة مصاريفك اليومية لتتبعها بسهولة.'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              child: const Text('إضافة مصاريف'),
            ),
          ],
        ),
      ),
    );
  }
}
