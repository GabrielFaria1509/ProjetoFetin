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
      padding: const EdgeInsets.all(12),
      color: Colors.blue[50],
      child: Row(
        children: [
          const Icon(Icons.schedule, color: Colors.blue, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rotina de ${profile?.name ?? "Criança"}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${profile?.age} anos • Suporte ${profile?.supportLevel}',
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilterChips() {
    final categories = ['manhã', 'educação', 'alimentação', 'lazer', 'bem-estar', 'noite'];
    
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Toggle para mostrar concluídas
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Text('Filtrar por categoria:', 
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    value: showCompleted,
                    onChanged: (value) {
                      showCompleted = value;
                      _applyFilters();
                    },
                  ),
                  const Flexible(
                    child: Text('Concluídas', 
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Chips de categoria
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FilterChip(
                  label: Text('Todas (${allActivities.length})',
                    style: const TextStyle(fontSize: 12),
                  ),
                  selected: selectedCategory == null,
                  onSelected: (_) => _updateCategoryFilter(null),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const SizedBox(width: 8),
                ...categories.map(
                  (category) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(
                        '${_getCategoryDisplayName(category)} (${_getCategoryCount(category)})',
                        style: const TextStyle(fontSize: 12),
                      ),
                      selected: selectedCategory == category,
                      onSelected: (_) => _updateCategoryFilter(category),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ],
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Progresso: $completed/$total',
                  style: const TextStyle(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(tismAqua),
            minHeight: 6,
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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      elevation: activity.isCompleted ? 1 : 3,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: activity.isCompleted ? Colors.green : _getCategoryColor(activity.category),
          child: Text(
            activity.icon,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        title: Text(
          activity.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            decoration: activity.isCompleted ? TextDecoration.lineThrough : null,
            color: activity.isCompleted ? Colors.grey : null,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Flexible(
                  child: Text(
                    '⏰ ${activity.time}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(activity.category),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    activity.category,
                    style: const TextStyle(fontSize: 9, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              activity.description,
              style: TextStyle(
                fontSize: 11,
                color: activity.isCompleted ? Colors.grey : Colors.grey[700],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: SizedBox(
          width: 40,
          child: Checkbox(
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
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
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
  

  
  void _updateCategoryFilter(String? category) {
    selectedCategory = category;
    _applyFilters();
  }
  
  void _clearFilters() {
    selectedCategory = null;
    showCompleted = true;
    _applyFilters();
  }
  
  int _getCategoryCount(String category) {
    return allActivities.where((a) => a.category == category).length;
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
  
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'manhã': return Colors.orange;
      case 'educação': return Colors.blue;
      case 'alimentação': return Colors.green;
      case 'lazer': return Colors.purple;
      case 'bem-estar': return Colors.teal;
      case 'noite': return Colors.indigo;
      default: return Colors.grey;
    }
  }
}