import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'routine_models.dart';

class AddRoutineScreen extends StatefulWidget {
  final RoutineActivity? activityToEdit;
  final Function(RoutineActivity) onActivitySaved;
  final VoidCallback? onActivityDeleted;
  
  const AddRoutineScreen({
    super.key, 
    required this.onActivitySaved,
    this.activityToEdit,
    this.onActivityDeleted,
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
        actions: widget.activityToEdit != null ? [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: _deleteActivity,
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
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Horário (00:00 - 23:59)',
        border: OutlineInputBorder(),
        hintText: '08:00',
      ),
      onChanged: (value) {
        // Auto-format time input
        if (value.length == 2 && !value.contains(':')) {
          _timeController.text = '$value:';
          _timeController.selection = TextSelection.fromPosition(
            TextPosition(offset: _timeController.text.length),
          );
        }
      },
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
    // Validar se título não é apenas whitespace ou caracteres invisíveis
    final title = _titleController.text.trim();
    if (title.isEmpty || title.replaceAll(RegExp(r'\s+'), '').isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O título da rotina não pode estar vazio'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validar horário
    final time = _timeController.text.trim();
    if (!_isValidTime(time)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Horário inválido. Use formato 24h (00:00 - 23:59)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final activity = RoutineActivity(
      id: widget.activityToEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      icon: _selectedIcon,
      time: time,
      description: _descriptionController.text,
      category: _selectedCategory,
      color: _selectedColor,
      isCompleted: widget.activityToEdit?.isCompleted ?? false,
    );

    widget.onActivitySaved(activity);
    Navigator.pop(context);
  }

  bool _isValidTime(String time) {
    if (time.isEmpty) return false;
    
    final regex = RegExp(r'^([01]?[0-9]|2[0-3]):([0-5][0-9])$');
    return regex.hasMatch(time);
  }
  
  void _deleteActivity() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deletar Rotina'),
        content: const Text('Tem certeza que deseja deletar esta rotina?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close edit screen
              widget.onActivityDeleted?.call();
            },
            child: const Text('Deletar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}