import 'package:flutter/material.dart';

class JournalEntryCard extends StatelessWidget {
  const JournalEntryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'عنوان المذكرة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'هذا هو النص المختصر للمذكرة. يمكنك التوسع هنا قليلاً لإعطاء لمحة عن محتوى المذكرة.',
            ),
          ],
        ),
      ),
    );
  }
}
