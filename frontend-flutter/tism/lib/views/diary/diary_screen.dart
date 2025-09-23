import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/services/language_service.dart';
import 'diary_models.dart';
import 'diary_service.dart';
import 'add_entry_screen.dart';
import 'statistics_screen.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  List<DiaryEntry> entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() {
    setState(() {
      entries = DiaryService.getEntries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('diary_observations'.tr),
        backgroundColor: tismAqua,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StatisticsScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: _exportReport,
          ),
        ],
      ),
      body: SafeArea(
        child: entries.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book, 
                      size: 64, 
                      color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.grey[400] 
                        : Colors.grey
                    ),
                    const SizedBox(height: 16),
                    Text('no_observations'.tr),
                    Text('tap_plus_start'.tr),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: entries.length,
                itemBuilder: (context, index) => _buildEntryCard(entries[index]),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEntryScreen()),
          );
          _loadEntries();
        },
        backgroundColor: tismAqua,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEntryCard(DiaryEntry entry) {
    final typeColors = {
      ObservationType.progresso: Colors.green,
      ObservationType.comportamento: Colors.blue,
      ObservationType.crise: Colors.red,
      ObservationType.dificuldade: Colors.orange,
    };

    final typeIcons = {
      ObservationType.progresso: '📈',
      ObservationType.comportamento: '👤',
      ObservationType.crise: '⚠️',
      ObservationType.dificuldade: '❌',
    };

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: typeColors[entry.type],
          child: Text(typeIcons[entry.type]!, style: const TextStyle(fontSize: 20)),
        ),
        title: Text(entry.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${entry.date.day}/${entry.date.month} - ${entry.observer.toUpperCase()}'),
            Text(entry.description, maxLines: 2, overflow: TextOverflow.ellipsis),
            if (entry.triggers.isNotEmpty)
              Text('${'triggers'.tr}: ${entry.triggers.join(", ")}', 
                   style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: typeColors[entry.type],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text('${entry.intensity}', 
                     style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        onTap: () => _editEntry(entry),
        onLongPress: () => _showEntryOptions(entry),
      ),
    );
  }



  void _editEntry(DiaryEntry entry) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEntryScreen(entryToEdit: entry),
      ),
    );
    _loadEntries();
  }

  void _showEntryOptions(DiaryEntry entry) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar observação'),
              onTap: () {
                Navigator.pop(context);
                _editEntry(entry);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Deletar observação', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _deleteEntry(entry);
              },
            ),
          ],
        ),
      ),
    );
  }
  
  void _deleteEntry(DiaryEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deletar Observação'),
        content: const Text('Tem certeza que deseja deletar esta observação?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              DiaryService.deleteEntry(entry.id);
              Navigator.pop(context);
              _loadEntries();
            },
            child: const Text('Deletar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _exportReport() {
    final report = DiaryService.generateReport();
    Clipboard.setData(ClipboardData(text: report));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Relatório copiado! Cole em email ou WhatsApp')),
    );
  }
}