import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../models/habit.dart';
import 'habit_detail_screen.dart';  // <-- added this line

class HabitsListScreen extends StatelessWidget {
  const HabitsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HabitProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Habits')),
      body: ListView.builder(
        itemCount: provider.habits.length,
        itemBuilder: (context, index) {
          final habit = provider.habits[index];
          return Dismissible(
            key: Key(habit.id),
            background: Container(color: Colors.red, child: const Icon(Icons.delete, color: Colors.white)),
            onDismissed: (_) => provider.deleteHabit(habit.id),
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Color(int.parse(habit.color.replaceFirst('#', '0xff')))),
              title: Text(habit.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(habit.description),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HabitDetailScreen(habit: habit)),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}