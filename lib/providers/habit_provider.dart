import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../models/log_entry.dart';
import '../services/database_helper.dart';

class HabitProvider extends ChangeNotifier {
  List<Habit> habits = [];
  final DatabaseHelper _db = DatabaseHelper.instance;

  Future<void> init() async {
    habits = await _db.getHabits();
    notifyListeners();
  }

  Future<void> addHabit(Habit habit) async {
    await _db.insertHabit(habit);
    habits = await _db.getHabits();
    notifyListeners();
  }

  Future<void> updateHabit(Habit habit) async {
    await _db.updateHabit(habit);
    habits = await _db.getHabits();
    notifyListeners();
  }

  Future<void> deleteHabit(String id) async {
    await _db.deleteHabit(id);
    habits = await _db.getHabits();
    notifyListeners();
  }

  Future<void> toggleHabitToday(String habitId) async {
    final today = DateTime.now();
    await _db.toggleCompletion(habitId, today, true);
    notifyListeners();
  }

  String getAIBuddySuggestion(String habitId) {
    return "Based on your last 3 days, try completing this habit before 8 AM tomorrow!";
  }

  Future<void> addDemoHabits() async {
    if (habits.isEmpty) {
      await addHabit(Habit(id: DateTime.now().toString(), name: "Morning Run", description: "Run 2km before class"));
      await addHabit(Habit(id: DateTime.now().millisecondsSinceEpoch.toString(), name: "Study 1 Hour", description: "Focus time without phone"));
    }
  }
}