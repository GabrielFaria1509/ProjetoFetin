import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'routine_models.dart';

class AddRoutineScreen extends StatefulWidget {
  final RoutineActivity? activityToEdit;
  final Function(RoutineActivity) onActivitySaved;
  
  const AddRoutineScreen({
    super.key, 
    required this.onActivitySaved,
    this.activityToEdit,
  });

  @override
  State<AddRoutineScreen> createState() => _AddRoutineScreenState();
}

class _AddRoutineScreenState extends State<AddRoutineScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();
  String _selectedIcon = '⏰';
  int _selectedColor = 0xFF2196F3;
  String _selectedCategory = 'manhã';
  
  final List<String> _categories = [
    'manhã', 'educação', 'alimentação', 'lazer', 'bem-estar', 'noite'
  ];
  
  final List<int> _colors = [
    0xFF2196F3, 0xFF4CAF50, 0xFFFF9800, 0xFF9C27B0,
    0xFFF44336, 0xFF00BCD4, 0xFF795548, 0xFF607D8B,
    0xFFE91E63, 0xFF3F51B5, 0xFF8BC34A, 0xFFFF5722,
  ];
  
  final List<String> _commonEmojis = [
    '⏰', '🌅', '🍽️', '🎮', '📚', '🛁', '😴', '🎵',
    '🏃', '🧸', '🎨', '📱', '🚗', '🐕', '🌟', '❤️',
    '🎯', '🏠', '👨‍👩‍👧‍👦', '🎪', '🎭', '🎲', '🧩', '🎈',
    '🌈', '⭐', '🎊', '🎁', '🍎', '🥛', '🍪', '🧴',
    '👕', '👟', '🧸', '📖', '✏️', '🖍️', '🎒', '🚌',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.activityToEdit != null) {
      _loadActivityData();
    }
  }
  
  void _loadActivityData() {
    final activity = widget.activityToEdit!;
    _titleController.text = activity.title;
    _descriptionController.text = activity.description;
    _timeController.text = activity.time;
    _selectedIcon = activity.icon;
    _selectedColor = activity.color;
    _selectedCategory = activity.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activityToEdit != null ? 'Editar Rotina' : 'Nova Rotina'),
        backgroundColor: tismAqua,
        foregroundColor: Colors.white,
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
                      _buildTitleField(),
                      const SizedBox(height: 16),
                      _buildTimeField(),
                      const SizedBox(height: 16),
                      _buildDescriptionField(),
                      const SizedBox(height: 16),
                      _buildCategorySelector(),
                      const SizedBox(height: 16),
                      _buildIconPicker(),
                      const SizedBox(height: 16),
                      _buildColorPicker(),
                      const SizedBox(height: 80), // Espaço para o botão
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: _saveActivity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tismAqua,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    widget.activityToEdit != null ? 'Salvar Alterações' : 'Criar Rotina',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextField(
      controller: _titleController,
      decoration: const InputDecoration(
        labelText: 'Título da atividade',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildTimeField() {
    return TextField(
      controller: _timeController,
      decoration: const InputDecoration(
        labelText: 'Horário (ex: 08:00)',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      controller: _descriptionController,
      maxLines: 3,
      decoration: const InputDecoration(
        labelText: 'Descrição da atividade',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Categoria:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _categories.map((category) => ChoiceChip(
            label: Text(category.toUpperCase()),
            selected: _selectedCategory == category,
            onSelected: (selected) {
              if (selected) {
                setState(() => _selectedCategory = category);
              }
            },
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildIconPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Ícone:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(_selectedColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _selectedIcon,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              childAspectRatio: 1,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: _commonEmojis.length,
            itemBuilder: (context, index) {
              final emoji = _commonEmojis[index];
              return GestureDetector(
                onTap: () => setState(() => _selectedIcon = emoji),
                child: Container(
                  decoration: BoxDecoration(
                    color: _selectedIcon == emoji ? Colors.blue[100] : null,
                    borderRadius: BorderRadius.circular(4),
                    border: _selectedIcon == emoji 
                      ? Border.all(color: Colors.blue, width: 2)
                      : null,
                  ),
                  child: Center(
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildColorPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Cor:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _colors.map((color) => GestureDetector(
            onTap: () => setState(() => _selectedColor = color),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(color),
                borderRadius: BorderRadius.circular(20),
                border: _selectedColor == color 
                  ? Border.all(color: Colors.black, width: 3)
                  : Border.all(color: Colors.grey, width: 1),
              ),
              child: _selectedColor == color 
                ? const Icon(Icons.check, color: Colors.white)
                : null,
            ),
          )).toList(),
        ),
      ],
    );
  }

  void _saveActivity() {
    if (_titleController.text.isEmpty) return;

    final activity = RoutineActivity(
      id: widget.activityToEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      icon: _selectedIcon,
      time: _timeController.text,
      description: _descriptionController.text,
      category: _selectedCategory,
      color: _selectedColor,
      isCompleted: widget.activityToEdit?.isCompleted ?? false,
    );

    widget.onActivitySaved(activity);
    Navigator.pop(context);
  }
}