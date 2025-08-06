import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'routine_models.dart';
import 'routine_service.dart';
import 'profile_setup.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  List<RoutineActivity> allActivities = [];
  List<RoutineActivity> filteredActivities = [];
  ChildProfile? profile;
  String? selectedCategory;
  String? selectedDifficulty;
  bool showCompleted = true;

  @override
  void initState() {
    super.initState();
    _loadDefaultProfile();
  }

  void _loadDefaultProfile() {
    profile = ChildProfile(
      name: 'Criança',
      age: 5,
      supportLevel: 'leve',
      sensoryPreferences: ['visual', 'auditivo'],
      interests: ['música', 'desenho'],
    );
    _generateAndFilterActivities();
  }
  
  void _generateAndFilterActivities() {
    allActivities = RoutineService.generateRoutine(profile!);
    _applyFilters();
  }
  
  void _applyFilters() {
    setState(() {
      filteredActivities = allActivities;
      
      if (selectedCategory != null) {
        filteredActivities = RoutineService.filterByCategory(filteredActivities, selectedCategory);
      }
      
      if (selectedDifficulty != null) {
        filteredActivities = RoutineService.filterByDifficulty(filteredActivities, selectedDifficulty);
      }
      
      if (!showCompleted) {
        filteredActivities = filteredActivities.where((a) => !a.isCompleted).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rotina Personalizada'),
        backgroundColor: tismAqua,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: _showProfileSetup,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          _buildFilterChips(),
          _buildProgressIndicator(),
          Expanded(
            child: filteredActivities.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: filteredActivities.length,
                    itemBuilder: (context, index) {
                      final activity = filteredActivities[index];
                      return _buildActivityCard(activity, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue[50],
      child: Row(
        children: [
          const Icon(Icons.schedule, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rotina de ${profile?.name ?? "Criança"}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${profile?.age} anos • Suporte ${profile?.supportLevel}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilterChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          FilterChip(
            label: Text('Todas (${allActivities.length})'),
            selected: selectedCategory == null,
            onSelected: (_) => _updateCategoryFilter(null),
          ),
          const SizedBox(width: 8),
          ...['manhã', 'educação', 'lazer', 'bem-estar', 'noite'].map(
            (category) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(_getCategoryDisplayName(category)),
                selected: selectedCategory == category,
                onSelected: (_) => _updateCategoryFilter(category),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProgressIndicator() {
    final completed = allActivities.where((a) => a.isCompleted).length;
    final total = allActivities.length;
    final progress = total > 0 ? completed / total : 0.0;
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Progresso do dia: $completed/$total'),
              Text('${(progress * 100).toInt()}%'),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(tismAqua),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('Nenhuma atividade encontrada'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _clearFilters,
            child: const Text('Limpar filtros'),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(RoutineActivity activity, int index) {
    final difficultyColor = _getDifficultyColor(activity.difficulty);
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      elevation: activity.isCompleted ? 1 : 3,
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundColor: activity.isCompleted ? Colors.green : tismAqua,
              child: Text(
                activity.icon,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: difficultyColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          activity.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: activity.isCompleted ? TextDecoration.lineThrough : null,
            color: activity.isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('⏰ ${activity.time}'),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(activity.category),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    activity.category,
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              activity.description,
              style: TextStyle(
                fontSize: 12,
                color: activity.isCompleted ? Colors.grey : Colors.grey[700],
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: activity.isCompleted,
          onChanged: (value) {
            setState(() {
              final activityIndex = allActivities.indexWhere((a) => a.id == activity.id);
              if (activityIndex != -1) {
                allActivities[activityIndex] = activity.copyWith(isCompleted: value);
                _applyFilters();
              }
            });
          },
        ),
      ),
    );
  }

  void _showProfileSetup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileSetup(
          onProfileCreated: (newProfile) {
            setState(() {
              profile = newProfile;
              _generateAndFilterActivities();
            });
          },
        ),
      ),
    );
  }
  
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtros'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedDifficulty,
              decoration: const InputDecoration(labelText: 'Dificuldade'),
              items: const [
                DropdownMenuItem(value: null, child: Text('Todas')),
                DropdownMenuItem(value: 'baixa', child: Text('Baixa')),
                DropdownMenuItem(value: 'média', child: Text('Média')),
                DropdownMenuItem(value: 'alta', child: Text('Alta')),
              ],
              onChanged: (value) => selectedDifficulty = value,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Mostrar concluídas'),
              value: showCompleted,
              onChanged: (value) => showCompleted = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _applyFilters();
            },
            child: const Text('Aplicar'),
          ),
        ],
      ),
    );
  }
  
  void _updateCategoryFilter(String? category) {
    selectedCategory = category;
    _applyFilters();
  }
  
  void _clearFilters() {
    selectedCategory = null;
    selectedDifficulty = null;
    showCompleted = true;
    _applyFilters();
  }
  
  String _getCategoryDisplayName(String category) {
    switch (category) {
      case 'manhã': return 'Manhã';
      case 'educação': return 'Educação';
      case 'lazer': return 'Lazer';
      case 'bem-estar': return 'Bem-estar';
      case 'noite': return 'Noite';
      default: return category;
    }
  }
  
  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'baixa': return Colors.green;
      case 'média': return Colors.orange;
      case 'alta': return Colors.red;
      default: return Colors.grey;
    }
  }
  
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'manhã': return Colors.orange;
      case 'educação': return Colors.blue;
      case 'lazer': return Colors.purple;
      case 'bem-estar': return Colors.green;
      case 'noite': return Colors.indigo;
      default: return Colors.grey;
    }
  }
}