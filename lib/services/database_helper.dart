import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/habit.dart';
import '../models/log_entry.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('habitforge.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE habits (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        targetFrequency INTEGER,
        color TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE logs (
        id TEXT PRIMARY KEY,
        habitId TEXT,
        date TEXT,
        completed INTEGER
      )
    ''');
  }

  Future<void> insertHabit(Habit habit) async =>
      await (await database).insert('habits', habit.toMap());

  Future<List<Habit>> getHabits() async {
    final maps = await (await database).query('habits');
    return maps.map((e) => Habit.fromMap(e)).toList();
  }

  Future<void> updateHabit(Habit habit) async =>
      await (await database).update('habits', habit.toMap(), where: 'id = ?', whereArgs: [habit.id]);

  Future<void> deleteHabit(String id) async =>
      await (await database).delete('habits', where: 'id = ?', whereArgs: [id]);

  // FIXED: toggleCompletion method (this was missing)
  Future<void> toggleCompletion(String habitId, DateTime date, bool completed) async {
    final db = await database;
    final String id = '${habitId}_${date.toIso8601String().split('T')[0]}';
    await db.insert('logs', {
      'id': id,
      'habitId': habitId,
      'date': date.toIso8601String(),
      'completed': completed ? 1 : 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}