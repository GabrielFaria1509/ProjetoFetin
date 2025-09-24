import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/l10n/app_localizations.dart';
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
        title: Text(AppLocalizations.of(context)!.statistics),
        backgroundColor: tismAqua,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSummaryCard(entries, context),
            const SizedBox(height: 16),
            _buildTypeDistribution(entries, context),
            const SizedBox(height: 16),
            _buildTriggerAnalysis(triggerFreq, context),
            const SizedBox(height: 16),
            _buildWeeklyTrend(entries, context),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(List<DiaryEntry> entries, BuildContext context) {
    final progressCount = entries.where((e) => e.type == ObservationType.progresso).length;
    final criseCount = entries.where((e) => e.type == ObservationType.crise).length;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📊 ${AppLocalizations.of(context)!.general_summary}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildStatItem(AppLocalizations.of(context)!.total, entries.length.toString(), Colors.blue),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatItem(AppLocalizations.of(context)!.progress_plural, progressCount.toString(), Colors.green),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatItem(AppLocalizations.of(context)!.crisis_plural, criseCount.toString(), Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildTypeDistribution(List<DiaryEntry> entries, BuildContext context) {
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
            Text('📈 ${AppLocalizations.of(context)!.type_distribution}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...distribution.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Builder(
                      builder: (context) => Text(_getTypeDisplayName(context, entry.key)),
                    ),
                  ),
                  Text('${entry.value}', style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTriggerAnalysis(Map<String, int> triggerFreq, BuildContext context) {
    final sortedTriggers = triggerFreq.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('⚠️ ${AppLocalizations.of(context)!.most_frequent_triggers}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

  Widget _buildWeeklyTrend(List<DiaryEntry> entries, BuildContext context) {
    final lastWeek = DateTime.now().subtract(const Duration(days: 7));
    final recentEntries = entries.where((e) => e.date.isAfter(lastWeek)).length;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📅 ${AppLocalizations.of(context)!.weekly_trend}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(AppLocalizations.of(context)!.observations_last_7_days_count(recentEntries)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: recentEntries / (entries.isNotEmpty ? entries.length : 1),
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(tismAqua),
            ),
          ],
        ),
      ),
    );
  }

  String _getTypeDisplayName(BuildContext context, ObservationType type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case ObservationType.progresso:
        return l10n.progress;
      case ObservationType.comportamento:
        return l10n.behavior;
      case ObservationType.crise:
        return l10n.crisis;
      case ObservationType.dificuldade:
        return l10n.difficulty;
    }
  }
}