import 'diary_models.dart';

class DiaryService {
  static final List<DiaryEntry> _entries = [];

  static List<DiaryEntry> getEntries() => List.from(_entries);

  static void addEntry(DiaryEntry entry) {
    _entries.add(entry);
    _entries.sort((a, b) => b.date.compareTo(a.date));
  }

  static List<ProgressData> getProgressData() {
    final data = <ProgressData>[];
    for (final entry in _entries) {
      data.add(ProgressData(
        date: entry.date,
        value: entry.intensity.toDouble(),
        type: entry.type,
      ));
    }
    return data;
  }

  static Map<String, int> getTriggerFrequency() {
    final frequency = <String, int>{};
    for (final entry in _entries) {
      for (final trigger in entry.triggers) {
        frequency[trigger] = (frequency[trigger] ?? 0) + 1;
      }
    }
    return frequency;
  }

  static String generateReport() {
    final total = _entries.length;
    final progressCount = _entries.where((e) => e.type == ObservationType.progresso).length;
    final criseCount = _entries.where((e) => e.type == ObservationType.crise).length;
    final comportamentoCount = _entries.where((e) => e.type == ObservationType.comportamento).length;
    final dificuldadeCount = _entries.where((e) => e.type == ObservationType.dificuldade).length;
    
    final now = DateTime.now();
    final lastWeek = now.subtract(const Duration(days: 7));
    final recentEntries = _entries.where((e) => e.date.isAfter(lastWeek)).length;
    
    return '''📋 RELATÓRIO DE OBSERVAÇÕES TEA
Data: ${now.day}/${now.month}/${now.year}

📊 RESUMO GERAL:
• Total de observações: $total
• Progressos: $progressCount
• Crises: $criseCount
• Comportamentos: $comportamentoCount
• Dificuldades: $dificuldadeCount
• Observações na última semana: $recentEntries

⚠️ GATILHOS MAIS FREQUENTES:
${getTriggerFrequency().entries.take(5).map((e) => '• ${e.key}: ${e.value} ocorrências').join('\n')}

📝 ÚLTIMAS OBSERVAÇÕES:
${_entries.take(10).map((e) => '${e.date.day}/${e.date.month} - ${e.type.name.toUpperCase()}: ${e.title}\n   Intensidade: ${e.intensity}/5 | Observador: ${e.observer}').join('\n\n')}

💡 RECOMENDAÇÕES:
• Monitore os gatilhos mais frequentes
• Continue registrando progressos
• Compartilhe com terapeutas

---
Relatório gerado pelo app TISM''';
  }
}