import 'package:flutter/material.dart';
import '../models/task_model.dart';

class AddEditScreen extends StatefulWidget {
  final Task? task;
  const AddEditScreen({super.key, this.task});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final TextEditingController _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _selectedDate = widget.task!.dueDate;
    }
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveTask() {
    if (_titleController.text.isNotEmpty) {
      final task = Task(title: _titleController.text, dueDate: _selectedDate);
      Navigator.pop(context, {'action': 'edit', 'task': task});
    }
  }

  void _deleteTask() {
    Navigator.pop(context, {'action': 'delete'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'إضافة مهمة' : 'تعديل المهمة'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'عنوان المهمة'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('تاريخ الاستحقاق: '),
                TextButton(
                  onPressed: _selectDate,
                  child: Text(_selectedDate.toLocal().toString().split(' ')[0]),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveTask,
                child: const Text('حفظ المهمة'),
              ),
            ),
            if (widget.task != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _deleteTask,
                  child: const Text('حذف المهمة'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
