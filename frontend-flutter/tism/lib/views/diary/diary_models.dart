enum ObservationType { progresso, comportamento, crise, dificuldade }

class DiaryEntry {
  final String id;
  final DateTime date;
  final ObservationType type;
  final String title;
  final String description;
  final int intensity; // 1-5
  final List<String> triggers;
  final String observer; // pai, mãe, professor

  DiaryEntry({
    required this.id,
    required this.date,
    required this.type,
    required this.title,
    required this.description,
    required this.intensity,
    required this.triggers,
    required this.observer,
  });
}

class ProgressData {
  final DateTime date;
  final double value;
  final ObservationType type;

  ProgressData({required this.date, required this.value, required this.type});
}