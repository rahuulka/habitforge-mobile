import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../models/habit.dart';

class HabitDetailScreen extends StatelessWidget {
  final Habit habit;
  const HabitDetailScreen({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HabitProvider>(context);
    final aiSuggestion = provider.getAIBuddySuggestion(habit.id);

    return Scaffold(
      appBar: AppBar(title: Text(habit.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text("🔥 Current Streak", style: TextStyle(fontSize: 18)),
                    Text("7 days", style: Theme.of(context).textTheme.headlineMedium),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("📅 History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Expanded(child: Center(child: Text("7-day streak calendar would go here"))),
            Card(
              color: Colors.deepPurple.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text("🤖 AI Habit Buddy", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(aiSuggestion, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}