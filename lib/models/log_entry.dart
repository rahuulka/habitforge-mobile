class LogEntry {
  final String id;
  final String habitId;
  final DateTime date;
  final bool completed;

  LogEntry({
    required this.id,
    required this.habitId,
    required this.date,
    required this.completed,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'habitId': habitId,
        'date': date.toIso8601String(),
        'completed': completed ? 1 : 0,
      };
}