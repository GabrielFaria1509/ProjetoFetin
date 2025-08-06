class RoutineActivity {
  final String id;
  final String title;
  final String icon;
  final String time;
  final String description;
  final bool isCompleted;
  final String category;
  final String difficulty;

  RoutineActivity({
    required this.id,
    required this.title,
    required this.icon,
    required this.time,
    required this.description,
    this.isCompleted = false,
    required this.category,
    this.difficulty = 'média',
  });

  RoutineActivity copyWith({bool? isCompleted}) {
    return RoutineActivity(
      id: id,
      title: title,
      icon: icon,
      time: time,
      description: description,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category,
      difficulty: difficulty,
    );
  }
}

class ChildProfile {
  final String name;
  final int age;
  final String supportLevel; // 'leve', 'moderado', 'severo'
  final List<String> sensoryPreferences;
  final List<String> interests;

  ChildProfile({
    required this.name,
    required this.age,
    required this.supportLevel,
    required this.sensoryPreferences,
    required this.interests,
  });
}