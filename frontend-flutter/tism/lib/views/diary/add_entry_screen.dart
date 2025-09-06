import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'diary_models.dart';
import 'diary_service.dart';

class AddEntryScreen extends StatefulWidget {
  final DiaryEntry? entryToEdit;
  
  const AddEntryScreen({super.key, this.entryToEdit});

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
  
  @override
  void initState() {
    super.initState();
    if (widget.entryToEdit != null) {
      _loadEntryData(widget.entryToEdit!);
    }
  }
  
  void _loadEntryData(DiaryEntry entry) {
    _titleController.text = entry.title;
    _descriptionController.text = entry.description;
    _type = entry.type;
    _intensity = entry.intensity;
    _observer = entry.observer;
    _selectedTriggers.addAll(entry.triggers);
  }

  final List<String> _commonTriggers = [
    'Mudança de rotina', 'Barulho alto', 'Multidão', 'Cansaço',
    'Fome', 'Frustração', 'Transição', 'Ambiente novo',
    'Luz muito forte', 'Textura desagradável', 'Cheiro forte', 'Temperatura',
    'Roupa apertada', 'Sono insuficiente', 'Dor física', 'Medicação',
    'Visita médica', 'Escola nova', 'Professor substituto', 'Prova/avaliação',
    'Festa/evento', 'Viagem', 'Chuva/temporal', 'Separação dos pais',
    'Brinquedo quebrado', 'Não conseguir algo', 'Interrupção atividade', 'Esperar muito tempo'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entryToEdit != null ? 'Editar Observação' : 'Nova Observação'),
        backgroundColor: tismAqua,
        foregroundColor: Colors.white,
        actions: widget.entryToEdit != null ? [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: _deleteEntry,
          ),
        ] : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
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
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: _saveEntry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tismAqua,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Salvar', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
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
          items: [
            'pai', 'mãe', 'avô', 'avó', 'tio', 'tia', 'irmão', 'irmã', 
            'filho', 'filha', 'neto', 'neta', 'sobrinho', 'sobrinha',
            'primo', 'prima', 'amigo', 'amiga', 'parente', 'cuidador',
            'professor', 'terapeuta', 'médico', 'psicólogo'
          ].map((observer) =>
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
      id: widget.entryToEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      date: widget.entryToEdit?.date ?? DateTime.now(),
      type: _type,
      title: _titleController.text,
      description: _descriptionController.text,
      intensity: _intensity,
      triggers: _selectedTriggers.toList(),
      observer: _observer,
    );

    if (widget.entryToEdit != null) {
      DiaryService.updateEntry(entry);
    } else {
      DiaryService.addEntry(entry);
    }
    
    Navigator.pop(context);
  }
  
  void _deleteEntry() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Observação'),
        content: const Text('Tem certeza que deseja excluir esta observação?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              DiaryService.deleteEntry(widget.entryToEdit!.id);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close edit screen
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}