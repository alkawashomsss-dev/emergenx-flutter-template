import 'package:flutter/material.dart';
import '../widgets/journal_entry_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مذكراتي اليومية'),
      ),
      body: ListView.builder(
        itemCount: 10, // Dummy count for entries
        itemBuilder: (context, index) {
          return const JournalEntryCard();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle new entry
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
