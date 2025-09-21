import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
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
  String _ageDisplay = '3 anos';
  int _ageInMonths = 36;
  String _supportLevel = 'leve';
  final Set<String> _sensoryPreferences = {};
  final Set<String> _interests = {};
  
  @override
  void initState() {
    super.initState();
    if (widget.existingProfile != null) {
      _loadExistingProfile();
    }
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
        title: Text(widget.existingProfile != null ? 'Editar Perfil' : 'Configurar Perfil'),
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
                  child: const Text('Criar Rotina', style: TextStyle(color: Colors.white)),
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
      decoration: const InputDecoration(
        labelText: 'Nome da criança',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildAgeSelector() {
    final ageOptions = [
      '1 mês', '2 meses', '3 meses', '4 meses', '5 meses', '6 meses',
      '7 meses', '8 meses', '9 meses', '10 meses', '11 meses',
      '1 ano', '2 anos', '3 anos', '4 anos', '5 anos', '6 anos',
      '7 anos', '8 anos', '9 anos', '10 anos', '11 anos', '12 anos',
      '13 anos', '14 anos', '15 anos', '16 anos', '17 anos', '18 anos'
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Idade: $_ageDisplay', style: const TextStyle(fontWeight: FontWeight.bold)),
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
  
  int _getAgeInMonths(String ageDisplay) {
    if (ageDisplay.contains('mês') || ageDisplay.contains('meses')) {
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
    final options = [
      'Visual', 'Auditivo', 'Tátil', 'Movimento', 'Olfativo', 'Gustativo',
      'Proprioceptivo', 'Vestibular', 'Pressão Profunda', 'Texturas Suaves',
      'Texturas Ásperas', 'Sons Baixos', 'Sons Altos', 'Luzes Suaves',
      'Luzes Brilhantes', 'Temperaturas Quentes', 'Temperaturas Frias'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Preferências sensoriais:', style: TextStyle(fontWeight: FontWeight.bold)),
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
    final options = [
      'Música', 'Desenho', 'Números', 'Animais', 'Carros', 'Livros', 'Jogos',
      'Computador', 'Tablet', 'Brinquedos', 'Esportes', 'Dança', 'Culinária',
      'Jardinagem', 'Ciência', 'Matemática', 'Arte', 'Fotografia', 'Vídeos',
      'Filmes', 'Séries', 'Quebra-cabeças', 'Lego', 'Bonecas', 'Super-heróis'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Interesses:', style: TextStyle(fontWeight: FontWeight.bold)),
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

  void _createProfile() {
    final name = _nameController.text.trim();
    
    // Validar se nome não é apenas whitespace ou caracteres invisíveis
    if (name.isEmpty || name.replaceAll(RegExp(r'\s+'), '').isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O nome da criança não pode estar vazio'),
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