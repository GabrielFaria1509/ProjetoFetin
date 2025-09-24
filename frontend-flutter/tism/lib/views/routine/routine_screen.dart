import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/l10n/app_localizations.dart';
import 'routine_models.dart';
import 'routine_service.dart';
import 'profile_setup.dart';
import 'add_routine_screen.dart';
import '../../services/child_profile_service.dart';
import '../../services/secure_storage_service.dart';
import 'dart:convert';

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

  void _loadDefaultProfile() async {
    final savedProfile = await ChildProfileService.getActiveProfile();
    
    if (savedProfile != null) {
      profile = savedProfile;
      _generateAndFilterActivities();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showFirstTimeSetup();
      });
    }
  }
  
  void _generateAndFilterActivities() async {
    final savedActivities = await _loadSavedActivities();
    
    if (savedActivities.isNotEmpty) {
      allActivities = savedActivities;
    } else {
      allActivities = RoutineService.generateRoutine(profile!);
    }
    
    _sortActivitiesByTime();
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
        title: Text(AppLocalizations.of(context)!.custom_routine),
        backgroundColor: tismAqua,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: _addNewActivity,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.person, color: Colors.white),
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  _showProfileSetup();
                  break;
                case 'switch':
                  _showProfileSelector();
                  break;
                case 'new':
                  _showNewProfileSetup();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    const Icon(Icons.edit),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.edit_profile_menu),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'switch',
                child: Row(
                  children: [
                    const Icon(Icons.swap_horiz),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.switch_child),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'new',
                child: Row(
                  children: [
                    const Icon(Icons.person_add),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.new_child),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
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
      ),
    );
  }
  
  Widget _buildHeader() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(12),
      color: isDark ? const Color(0xFF2A2A2A) : Colors.blue[50],
      child: Row(
        children: [
          Icon(
            Icons.schedule, 
            color: isDark ? tismAqua : Colors.blue, 
            size: 20
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.routine_of(profile?.name ?? 'Child'),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${profile?.ageDisplay ?? "5 years"} • ${AppLocalizations.of(context)!.support_level(_translateSupportLevel(profile?.supportLevel ?? ''))}',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(AppLocalizations.of(context)!.filter_category, 
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                  Flexible(
                    child: Text(AppLocalizations.of(context)!.completed, 
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FilterChip(
                  label: Text('${AppLocalizations.of(context)!.all} (${allActivities.length})',
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
                  AppLocalizations.of(context)!.progress_count(completed, total),
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
            valueColor: const AlwaysStoppedAnimation<Color>(tismAqua),
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
          Icon(
            Icons.search_off, 
            size: 64, 
            color: Theme.of(context).brightness == Brightness.dark 
              ? Colors.grey[400] 
              : Colors.grey
          ),
          const SizedBox(height: 16),
          Text(AppLocalizations.of(context)!.no_activities),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _clearFilters,
            child: Text(AppLocalizations.of(context)!.clear_filters),
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
          backgroundColor: activity.isCompleted ? Colors.green : Color(activity.color),
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
                    color: Color(activity.color),
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
                  _saveActivities();
                }
              });
            },
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        onTap: () => _editActivity(activity),
      ),
    );
  }

  void _showFirstTimeSetup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('👶 ${AppLocalizations.of(context)!.welcome}!'),
        content: Text(AppLocalizations.of(context)!.profile_setup_desc),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showNewProfileSetup();
            },
            child: Text(AppLocalizations.of(context)!.create_profile),
          ),
        ],
      ),
    );
  }
  
  void _showProfileSetup() {
    if (profile == null) {
      _showNewProfileSetup();
      return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileSetup(
          existingProfile: profile,
          onProfileCreated: (newProfile) async {
            await ChildProfileService.saveProfile(newProfile);
            await ChildProfileService.setActiveProfile(newProfile.name);
            setState(() {
              profile = newProfile;
              _generateAndFilterActivities();
            });
          },
        ),
      ),
    );
  }
  
  void _showNewProfileSetup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileSetup(
          onProfileCreated: (newProfile) async {
            await ChildProfileService.saveProfile(newProfile);
            await ChildProfileService.setActiveProfile(newProfile.name);
            setState(() {
              profile = newProfile;
              _generateAndFilterActivities();
            });
          },
        ),
      ),
    );
  }
  
  void _showProfileSelector() async {
    final profiles = await ChildProfileService.getProfiles();
    
    if (profiles.isEmpty) {
      _showNewProfileSetup();
      return;
    }
    
    if (!mounted) return;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.select_child),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final childProfile = profiles[index];
              final isActive = profile?.name == childProfile.name;
              
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: isActive ? tismAqua : Colors.grey,
                  child: Text(
                    childProfile.name[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(childProfile.name),
                subtitle: Text('${childProfile.ageDisplay} • ${childProfile.supportLevel}'),
                trailing: isActive ? const Icon(Icons.check, color: Colors.green) : null,
                onTap: () async {
                  final navigator = Navigator.of(context);
                  await ChildProfileService.setActiveProfile(childProfile.name);
                  if (mounted) {
                    setState(() {
                      profile = childProfile;
                      _generateAndFilterActivities();
                    });
                    navigator.pop();
                  }
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
        ],
      ),
    );
  }
  
  void _addNewActivity() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRoutineScreen(
          onActivitySaved: (activity) {
            setState(() {
              allActivities.add(activity);
              _sortActivitiesByTime();
              _applyFilters();
              _saveActivities();
            });
          },
        ),
      ),
    );
  }
  
  void _editActivity(RoutineActivity activity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRoutineScreen(
          activityToEdit: activity,
          onActivitySaved: (updatedActivity) {
            setState(() {
              final index = allActivities.indexWhere((a) => a.id == activity.id);
              if (index != -1) {
                allActivities[index] = updatedActivity;
                _sortActivitiesByTime();
                _applyFilters();
                _saveActivities();
              }
            });
          },
          onActivityDeleted: () {
            setState(() {
              allActivities.removeWhere((a) => a.id == activity.id);
              _applyFilters();
              _saveActivities();
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
    final l10n = AppLocalizations.of(context)!;
    
    switch (category) {
      case 'manhã':
        return l10n.morning;
      case 'educação':
        return l10n.education;
      case 'alimentação':
        return l10n.food;
      case 'lazer':
        return l10n.leisure;
      case 'bem-estar':
        return l10n.wellness;
      case 'noite':
        return l10n.night;
      default:
        return category;
    }
  }
  
  String _translateSupportLevel(String level) {
    // Placeholder - should use proper localization
    return level;
  }
  
  Future<void> _saveActivities() async {
    if (profile == null) return;
    
    final activitiesJson = allActivities.map((a) => a.toJson()).toList();
    final key = 'routine_activities_${profile!.name}';
    await SecureStorageService.setSecureString(key, json.encode(activitiesJson));
  }
  
  Future<List<RoutineActivity>> _loadSavedActivities() async {
    if (profile == null) return [];
    
    try {
      final key = 'routine_activities_${profile!.name}';
      final savedData = await SecureStorageService.getSecureString(key);
      
      if (savedData != null) {
        final List<dynamic> activitiesJson = json.decode(savedData);
        return activitiesJson.map((json) => RoutineActivity.fromJson(json)).toList();
      }
    } catch (e) {
      // Return empty list to generate default routine
    }
    
    return [];
  }
  
  void _sortActivitiesByTime() {
    allActivities.sort((a, b) {
      final timeA = _parseTime(a.time);
      final timeB = _parseTime(b.time);
      return timeA.compareTo(timeB);
    });
  }
  
  int _parseTime(String time) {
    try {
      final parts = time.split(':');
      if (parts.length == 2) {
        final hours = int.parse(parts[0]);
        final minutes = int.parse(parts[1]);
        return hours * 60 + minutes;
      }
    } catch (e) {
      // Return high value to sort at end
    }
    return 9999;
  }

  @override
  void dispose() {
    _saveActivities();
    super.dispose();
  }
}