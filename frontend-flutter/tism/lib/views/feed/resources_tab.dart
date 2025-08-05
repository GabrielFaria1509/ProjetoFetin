import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesTab extends StatefulWidget {
  const ResourcesTab({super.key});

  @override
  State<ResourcesTab> createState() => _ResourcesTabState();
}

class _ResourcesTabState extends State<ResourcesTab> {
  String selectedType = 'Todos';
  final List<String> resourceTypes = ['Todos', 'Guias', 'Checklists', 'Artigos', 'Manuais'];

  final List<Map<String, dynamic>> mockResources = [
    {
      'title': 'Cartilha dos Direitos da Pessoa com Autismo',
      'description': 'Direitos fundamentais e legislação',
      'type': 'Guias',
      'url': 'https://drive.google.com/drive/folders/1WAolw5u1-G3S08tMFuwGZJXBRPM7qgoB',
      'icon': Icons.gavel
    },
    {
      'title': 'Protocolo de Identificação Precoce',
      'description': 'Sinais de alerta e diagnóstico',
      'type': 'Checklists',
      'url': 'https://drive.google.com/drive/folders/1WAolw5u1-G3S08tMFuwGZJXBRPM7qgoB',
      'icon': Icons.checklist_rtl
    },
    {
      'title': 'Estratégias de Intervenção',
      'description': 'Técnicas terapêuticas e educacionais',
      'type': 'Manuais',
      'url': 'https://drive.google.com/drive/folders/1WAolw5u1-G3S08tMFuwGZJXBRPM7qgoB',
      'icon': Icons.psychology
    },
    {
      'title': 'Pesquisas e Estudos Científicos',
      'description': 'Artigos acadêmicos atualizados',
      'type': 'Artigos',
      'url': 'https://drive.google.com/drive/folders/1WAolw5u1-G3S08tMFuwGZJXBRPM7qgoB',
      'icon': Icons.science
    },
    {
      'title': 'Orientações para Famílias',
      'description': 'Suporte e acompanhamento familiar',
      'type': 'Guias',
      'url': 'https://drive.google.com/drive/folders/1WAolw5u1-G3S08tMFuwGZJXBRPM7qgoB',
      'icon': Icons.family_restroom
    },
    {
      'title': 'Inclusão Escolar e Social',
      'description': 'Práticas inclusivas e adaptações',
      'type': 'Manuais',
      'url': 'https://drive.google.com/drive/folders/1WAolw5u1-G3S08tMFuwGZJXBRPM7qgoB',
      'icon': Icons.school
    },
  ];

  List<Map<String, dynamic>> get filteredResources {
    if (selectedType == 'Todos') return mockResources;
    return mockResources.where((resource) => resource['type'] == selectedType).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: resourceTypes.length,
            itemBuilder: (context, index) {
              final type = resourceTypes[index];
              final isSelected = type == selectedType;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() => selectedType = type);
                  },
                  backgroundColor: Colors.grey[200],
                  selectedColor: tismAqua,
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredResources.length,
            itemBuilder: (context, index) {
              final resource = filteredResources[index];
              return _buildResourceCard(
                resource['title'],
                resource['description'],
                resource['icon'],
                () => _openPDF(resource['url']),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResourceCard(String title, String description, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: tismAqua.withAlpha(25),
          child: Icon(icon, color: tismAqua, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(Icons.folder_open, color: Colors.grey[400], size: 20),
        onTap: onTap,
        dense: true,
      ),
    );
  }

  Future<void> _openPDF(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Não foi possível abrir';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Abrindo pasta de recursos...'),
            backgroundColor: tismAqua,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
}