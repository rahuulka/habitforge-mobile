import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HabitProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HabitForge'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 20),
            Text(
              'Welcome, ${provider.userName}!',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Current Streak: 7 days 🔥',
              style: TextStyle(fontSize: 22, color: Colors.orange),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                provider.updateName("Rahul the Habit King");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Name updated with Provider!')),
                );
              },
              icon: const Icon(Icons.celebration),
              label: const Text('Mark Today Complete (Demo)'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Habits'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Stats'),
        ],
      ),
    );
  }
}