import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'diary_models.dart';
import 'diary_service.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = DiaryService.getEntries();
    final triggerFreq = DiaryService.getTriggerFrequency();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estatísticas'),
        backgroundColor: tismAqua,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSummaryCard(entries),
            const SizedBox(height: 16),
            _buildTypeDistribution(entries),
            const SizedBox(height: 16),
            _buildTriggerAnalysis(triggerFreq),
            const SizedBox(height: 16),
            _buildWeeklyTrend(entries),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(List<DiaryEntry> entries) {
    final progressCount = entries.where((e) => e.type == ObservationType.progresso).length;
    final criseCount = entries.where((e) => e.type == ObservationType.crise).length;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('📊 Resumo Geral', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Total', entries.length.toString(), Colors.blue),
                _buildStatItem('Progressos', progressCount.toString(), Colors.green),
                _buildStatItem('Crises', criseCount.toString(), Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildTypeDistribution(List<DiaryEntry> entries) {
    final distribution = <ObservationType, int>{};
    for (final entry in entries) {
      distribution[entry.type] = (distribution[entry.type] ?? 0) + 1;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('📈 Distribuição por Tipo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...distribution.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(child: Text(entry.key.name.toUpperCase())),
                  Text('${entry.value}', style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTriggerAnalysis(Map<String, int> triggerFreq) {
    final sortedTriggers = triggerFreq.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('⚠️ Gatilhos Mais Frequentes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...sortedTriggers.take(5).map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(child: Text(entry.key)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('${entry.value}x', style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyTrend(List<DiaryEntry> entries) {
    final lastWeek = DateTime.now().subtract(const Duration(days: 7));
    final recentEntries = entries.where((e) => e.date.isAfter(lastWeek)).length;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('📅 Tendência Semanal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('Observações nos últimos 7 dias: $recentEntries'),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: recentEntries / (entries.isNotEmpty ? entries.length : 1),
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(tismAqua),
            ),
          ],
        ),
      ),
    );
  }
}