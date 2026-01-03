import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('آخر الأخبار'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('عنوان الخبر رقم ${index + 1}'),
              subtitle: const Text('تفاصيل الخبر بشكل مبسط وموجز.'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // عند الضغط على الخبر
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(index: index),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final int index;

  const DetailScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('خبر رقم ${index + 1}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'تفاصيل كاملة عن الخبر رقم ${index + 1}. يمكن أن يحتوي على الكثير من النصوص والمعلومات لكي يقرأها المستخدم بشكل مريح.',
        ),
      ),
    );
  }
}
