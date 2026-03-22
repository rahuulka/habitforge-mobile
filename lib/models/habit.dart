class Habit {
  final String id;
  final String name;
  final String description;
  final int targetFrequency;
  final String color;

  Habit({
    required this.id,
    required this.name,
    required this.description,
    this.targetFrequency = 7,
    this.color = '#4CAF50',
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'targetFrequency': targetFrequency,
        'color': color,
      };

  factory Habit.fromMap(Map<String, dynamic> map) => Habit(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        targetFrequency: map['targetFrequency'],
        color: map['color'],
      );
}
