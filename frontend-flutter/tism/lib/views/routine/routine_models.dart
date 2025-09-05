class RoutineActivity {
  final String id;
  final String title;
  final String icon;
  final String time;
  final String description;
  final bool isCompleted;
  final String category;
  final int color;

  RoutineActivity({
    required this.id,
    required this.title,
    required this.icon,
    required this.time,
    required this.description,
    this.isCompleted = false,
    required this.category,
    this.color = 0xFF2196F3,
  });

  RoutineActivity copyWith({
    bool? isCompleted,
    String? title,
    String? icon,
    String? time,
    String? description,
    String? category,
    int? color,
  }) {
    return RoutineActivity(
      id: id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      time: time ?? this.time,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
      color: color ?? this.color,
    );
  }
}

class ChildProfile {
  final String name;
  final String ageDisplay;
  final int ageInMonths;
  final String supportLevel;
  final List<String> sensoryPreferences;
  final List<String> interests;

  ChildProfile({
    required this.name,
    required this.ageDisplay,
    required this.ageInMonths,
    required this.supportLevel,
    required this.sensoryPreferences,
    required this.interests,
  });
  
  // Compatibilidade com código antigo
  int get age => (ageInMonths / 12).floor();
}