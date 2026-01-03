// الكود الكامل هنا 
import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Sample data count
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('مهمة $index'),
            subtitle: const Text('وصف المهمة'),
          ),
        );
      },
    );
  }
}
