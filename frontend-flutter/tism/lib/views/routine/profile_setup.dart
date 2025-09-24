import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/l10n/app_localizations.dart';
import 'routine_models.dart';

class ProfileSetup extends StatefulWidget {
  final Function(ChildProfile) onProfileCreated;
  final ChildProfile? existingProfile;
  
  const ProfileSetup({super.key, required this.onProfileCreated, this.existingProfile});

  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  final _nameController = TextEditingController();
  String _ageDisplay = '';
  int _ageInMonths = 36;
  String _supportLevel = 'leve';
  final Set<String> _sensoryPreferences = {};
  final Set<String> _interests = {};
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.existingProfile != null) {
        _loadExistingProfile();
      } else {
        final l10n = AppLocalizations.of(context)!;
        setState(() {
          _ageDisplay = '3 ${l10n.years}';
        });
      }
    });
  }
  
  void _loadExistingProfile() {
    final profile = widget.existingProfile!;
    _nameController.text = profile.name;
    _ageDisplay = profile.ageDisplay;
    _ageInMonths = profile.ageInMonths;
    _supportLevel = profile.supportLevel;
    _sensoryPreferences.addAll(profile.sensoryPreferences);
    _interests.addAll(profile.interests);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingProfile != null ? AppLocalizations.of(context)!.edit_profile : AppLocalizations.of(context)!.configure_profile),
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
                      _buildNameField(),
                      const SizedBox(height: 16),
                      _buildAgeSelector(),
                      const SizedBox(height: 16),
                      _buildSupportLevelSelector(),
                      const SizedBox(height: 16),
                      _buildSensoryPreferences(),
                      const SizedBox(height: 16),
                      _buildInterests(),
                      const SizedBox(height: 80), // Espaço para o botão
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: _createProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tismAqua,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(AppLocalizations.of(context)!.create_routine, style: const TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.child_name,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildAgeSelector() {
    final l10n = AppLocalizations.of(context)!;
    final ageOptions = _getAgeOptions(l10n);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppLocalizations.of(context)!.age}: $_ageDisplay', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButton<String>(
          value: _ageDisplay,
          isExpanded: true,
          items: ageOptions.map((age) => DropdownMenuItem(
            value: age,
            child: Text(age),
          )).toList(),
          onChanged: (value) {
            setState(() {
              _ageDisplay = value!;
              _ageInMonths = _getAgeInMonths(value);
            });
          },
        ),
      ],
    );
  }
  
  List<String> _getAgeOptions(AppLocalizations l10n) {
    return [
      '1 ${l10n.month}', '2 ${l10n.months}', '3 ${l10n.months}', '4 ${l10n.months}', '5 ${l10n.months}', '6 ${l10n.months}',
      '7 ${l10n.months}', '8 ${l10n.months}', '9 ${l10n.months}', '10 ${l10n.months}', '11 ${l10n.months}',
      '1 ${l10n.year}', '2 ${l10n.years}', '3 ${l10n.years}', '4 ${l10n.years}', '5 ${l10n.years}', '6 ${l10n.years}',
      '7 ${l10n.years}', '8 ${l10n.years}', '9 ${l10n.years}', '10 ${l10n.years}', '11 ${l10n.years}', '12 ${l10n.years}',
      '13 ${l10n.years}', '14 ${l10n.years}', '15 ${l10n.years}', '16 ${l10n.years}', '17 ${l10n.years}', '18 ${l10n.years}'
    ];
  }

  int _getAgeInMonths(String ageDisplay) {
    final l10n = AppLocalizations.of(context)!;
    if (ageDisplay.contains(l10n.month) || ageDisplay.contains(l10n.months)) {
      return int.parse(ageDisplay.split(' ')[0]);
    } else {
      final years = int.parse(ageDisplay.split(' ')[0]);
      return years * 12;
    }
  }

  Widget _buildSupportLevelSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppLocalizations.of(context)!.support_level_label}:', style: const TextStyle(fontWeight: FontWeight.bold)),
        ..._getSupportLevels().map((level) => RadioListTile<String>(
          title: Text(level['display']!),
          value: level['value']!,
          groupValue: _supportLevel,
          onChanged: (value) => setState(() => _supportLevel = value!),
        )),
      ],
    );
  }

  Widget _buildSensoryPreferences() {
    final options = _getSensoryPreferences();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppLocalizations.of(context)!.sensory_preferences}:', style: const TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8,
          runSpacing: 4,
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
    final options = _getInterests();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppLocalizations.of(context)!.interests}:', style: const TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8,
          runSpacing: 4,
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

  String _capitalizeName(String name) {
    return name.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  List<Map<String, String>> _getSupportLevels() {
    final l10n = AppLocalizations.of(context)!;
    return [
      {'value': 'leve', 'display': l10n.support_level_mild.toUpperCase()},
      {'value': 'moderado', 'display': l10n.support_level_moderate.toUpperCase()},
      {'value': 'severo', 'display': l10n.support_level_severe.toUpperCase()},
    ];
  }

  List<String> _getSensoryPreferences() {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.sensory_visual, l10n.sensory_auditory, l10n.sensory_tactile, l10n.sensory_movement,
      l10n.sensory_olfactory, l10n.sensory_gustatory, l10n.sensory_proprioceptive, l10n.sensory_vestibular,
      l10n.sensory_deep_pressure, l10n.sensory_soft_textures, l10n.sensory_rough_textures,
      l10n.sensory_low_sounds, l10n.sensory_high_sounds, l10n.sensory_soft_lights,
      l10n.sensory_bright_lights, l10n.sensory_hot_temperatures, l10n.sensory_cold_temperatures
    ];
  }

  List<String> _getInterests() {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.interest_music, l10n.interest_drawing, l10n.interest_numbers, l10n.interest_animals,
      l10n.interest_cars, l10n.interest_books, l10n.interest_games, l10n.interest_computer,
      l10n.interest_tablet, l10n.interest_toys, l10n.interest_sports, l10n.interest_dance,
      l10n.interest_cooking, l10n.interest_gardening, l10n.interest_science, l10n.interest_math,
      l10n.interest_art, l10n.interest_photography, l10n.interest_videos, l10n.interest_movies,
      l10n.interest_series, l10n.interest_puzzles, l10n.interest_lego, l10n.interest_dolls,
      l10n.interest_superheroes
    ];
  }

  void _createProfile() {
    final name = _nameController.text.trim();
    
    // Validar se nome não é apenas whitespace ou caracteres invisíveis
    if (name.isEmpty || name.replaceAll(RegExp(r'\s+'), '').isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.child_name_empty),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    final profile = ChildProfile(
      name: _capitalizeName(name),
      ageDisplay: _ageDisplay,
      ageInMonths: _ageInMonths,
      supportLevel: _supportLevel,
      sensoryPreferences: _sensoryPreferences.toList(),
      interests: _interests.toList(),
    );
    widget.onProfileCreated(profile);
    Navigator.pop(context);
  }
}