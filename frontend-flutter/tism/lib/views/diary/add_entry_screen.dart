import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'diary_models.dart';
import 'diary_service.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  ObservationType _type = ObservationType.progresso;
  int _intensity = 3;
  String _observer = 'pai';
  final Set<String> _selectedTriggers = {};

  final List<String> _commonTriggers = [
    'Mudança de rotina', 'Barulho alto', 'Multidão', 'Cansaço',
    'Fome', 'Frustração', 'Transição', 'Ambiente novo'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Observação'),
        backgroundColor: tismAqua,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildTypeSelector(),
                  const SizedBox(height: 16),
                  _buildTitleField(),
                  const SizedBox(height: 16),
                  _buildDescriptionField(),
                  const SizedBox(height: 16),
                  _buildIntensitySlider(),
                  const SizedBox(height: 16),
                  _buildObserverSelector(),
                  const SizedBox(height: 16),
                  _buildTriggersSelector(),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveEntry,
                style: ElevatedButton.styleFrom(backgroundColor: tismAqua),
                child: const Text('Salvar', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tipo:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          children: ObservationType.values.map((type) {
            final icons = {'progresso': '📈', 'comportamento': '👤', 'crise': '⚠️', 'dificuldade': '❌'};
            return ChoiceChip(
              label: Text('${icons[type.name]} ${type.name.toUpperCase()}'),
              selected: _type == type,
              onSelected: (selected) => setState(() => _type = type),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTitleField() {
    return TextField(
      controller: _titleController,
      decoration: const InputDecoration(
        labelText: 'Título',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      controller: _descriptionController,
      maxLines: 3,
      decoration: const InputDecoration(
        labelText: 'Descrição detalhada',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildIntensitySlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Intensidade: $_intensity', style: const TextStyle(fontWeight: FontWeight.bold)),
        Slider(
          value: _intensity.toDouble(),
          min: 1,
          max: 5,
          divisions: 4,
          onChanged: (value) => setState(() => _intensity = value.round()),
        ),
      ],
    );
  }

  Widget _buildObserverSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Observador:', style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<String>(
          value: _observer,
          items: ['pai', 'mãe', 'professor', 'terapeuta'].map((observer) =>
            DropdownMenuItem(value: observer, child: Text(observer.toUpperCase()))
          ).toList(),
          onChanged: (value) => setState(() => _observer = value!),
        ),
      ],
    );
  }

  Widget _buildTriggersSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Possíveis gatilhos:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          children: _commonTriggers.map((trigger) => FilterChip(
            label: Text(trigger),
            selected: _selectedTriggers.contains(trigger),
            onSelected: (selected) {
              setState(() {
                selected ? _selectedTriggers.add(trigger) : _selectedTriggers.remove(trigger);
              });
            },
          )).toList(),
        ),
      ],
    );
  }

  void _saveEntry() {
    if (_titleController.text.isEmpty) return;

    final entry = DiaryEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      type: _type,
      title: _titleController.text,
      description: _descriptionController.text,
      intensity: _intensity,
      triggers: _selectedTriggers.toList(),
      observer: _observer,
    );

    DiaryService.addEntry(entry);
    Navigator.pop(context);
  }
}