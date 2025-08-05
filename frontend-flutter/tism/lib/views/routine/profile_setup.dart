import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'routine_models.dart';

class ProfileSetup extends StatefulWidget {
  final Function(ChildProfile) onProfileCreated;
  
  const ProfileSetup({super.key, required this.onProfileCreated});

  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  final _nameController = TextEditingController();
  int _age = 3;
  String _supportLevel = 'leve';
  final Set<String> _sensoryPreferences = {};
  final Set<String> _interests = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurar Perfil'),
        backgroundColor: tismAqua,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildNameField(),
                  const SizedBox(height: 16),
                  _buildAgeSelector(),
                  const SizedBox(height: 16),
                  _buildSupportLevelSelector(),
                  const SizedBox(height: 16),
                  _buildSensoryPreferences(),
                  const SizedBox(height: 16),
                  _buildInterests(),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _createProfile,
                style: ElevatedButton.styleFrom(backgroundColor: tismAqua),
                child: const Text('Criar Rotina', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Nome da criança',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildAgeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Idade: ', style: TextStyle(fontWeight: FontWeight.bold)),
        Slider(
          value: _age.toDouble(),
          min: 1,
          max: 12,
          divisions: 11,
          label: '$_age anos',
          onChanged: (value) => setState(() => _age = value.round()),
        ),
      ],
    );
  }

  Widget _buildSupportLevelSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Nível de suporte:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...['leve', 'moderado', 'severo'].map((level) => RadioListTile<String>(
          title: Text(level.toUpperCase()),
          value: level,
          groupValue: _supportLevel,
          onChanged: (value) => setState(() => _supportLevel = value!),
        )),
      ],
    );
  }

  Widget _buildSensoryPreferences() {
    final options = ['visual', 'auditivo', 'tátil', 'movimento'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Preferências sensoriais:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          children: options.map((option) => FilterChip(
            label: Text(option),
            selected: _sensoryPreferences.contains(option),
            onSelected: (selected) {
              setState(() {
                selected ? _sensoryPreferences.add(option) : _sensoryPreferences.remove(option);
              });
            },
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildInterests() {
    final options = ['música', 'desenho', 'números', 'animais', 'carros'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Interesses:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          children: options.map((option) => FilterChip(
            label: Text(option),
            selected: _interests.contains(option),
            onSelected: (selected) {
              setState(() {
                selected ? _interests.add(option) : _interests.remove(option);
              });
            },
          )).toList(),
        ),
      ],
    );
  }

  void _createProfile() {
    final profile = ChildProfile(
      name: _nameController.text.isEmpty ? 'Criança' : _nameController.text,
      age: _age,
      supportLevel: _supportLevel,
      sensoryPreferences: _sensoryPreferences.toList(),
      interests: _interests.toList(),
    );
    widget.onProfileCreated(profile);
    Navigator.pop(context);
  }
}