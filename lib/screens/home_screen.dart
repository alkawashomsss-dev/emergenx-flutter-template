import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'add_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _navigateToAddEditScreen([Task? task, int? index]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditScreen(task: task),
      ),
    );
    if (result != null && result is Map<String, dynamic>) {
      if (index == null) {
        _addTask(result['task']);
      } else if (result['action'] == 'edit') {
        setState(() {
          tasks[index] = result['task'];
        });
      } else if (result['action'] == 'delete') {
        _deleteTask(index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة المهام'),
        centerTitle: true,
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('لا توجد مهام'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.dueDate.toLocal().toString().split(' ')[0]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _navigateToAddEditScreen(task, index),
                    ),
                    onTap: () => _navigateToAddEditScreen(task, index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEditScreen(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
