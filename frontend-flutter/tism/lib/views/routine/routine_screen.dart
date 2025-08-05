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
  List<RoutineActivity> activities = [];
  ChildProfile? profile;

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
    activities = RoutineService.generateRoutine(profile!);
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
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Row(
              children: [
                const Icon(Icons.schedule, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Rotina de ${profile?.name ?? "Criança"}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return _buildActivityCard(activity, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(RoutineActivity activity, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: activity.isCompleted ? Colors.green : tismAqua,
          child: Text(
            activity.icon,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        title: Text(
          activity.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: activity.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('⏰ ${activity.time}'),
            Text(activity.description, style: const TextStyle(fontSize: 12)),
          ],
        ),
        trailing: Checkbox(
          value: activity.isCompleted,
          onChanged: (value) {
            setState(() {
              activities[index] = activity.copyWith(isCompleted: value);
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
              activities = RoutineService.generateRoutine(profile!);
            });
          },
        ),
      ),
    );
  }
}