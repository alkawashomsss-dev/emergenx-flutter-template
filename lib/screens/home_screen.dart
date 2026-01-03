// الكود الكامل هنا 
import 'package:flutter/material.dart';
import '../widgets/task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المهام'),
      ),
      body: const TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add task button pressed
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
