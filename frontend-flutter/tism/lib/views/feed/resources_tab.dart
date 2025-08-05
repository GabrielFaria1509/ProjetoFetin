import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/views/pdf/pdf_viewer.dart';

class ResourcesTab extends StatefulWidget {
  const ResourcesTab({super.key});

  @override
  State<ResourcesTab> createState() => _ResourcesTabState();
}

class _ResourcesTabState extends State<ResourcesTab> {
  String selectedType = 'Todos';
  final List<String> resourceTypes = ['Todos', 'Guias', 'Checklists', 'Manuais', 'Artigos'];

  final List<Map<String, dynamic>> mockResources = [
    {
      'title': 'Guia TEA Completo',
      'description': 'Manual abrangente sobre TEA',
      'type': 'Guias',
      'assetPath': 'assets/pdfs/guia-tea.pdf',
      'icon': Icons.book
    },
    {
      'title': 'Compreendendo o Autismo',
      'description': 'Fundamentos e características',
      'type': 'Guias',
      'assetPath': 'assets/pdfs/Compreendendo o Autismo.pdf',
      'icon': Icons.psychology
    },
    {
      'title': 'Primeiros Sintomas',
      'description': 'Identificação precoce do TEA',
      'type': 'Checklists',
      'assetPath': 'assets/pdfs/primeirosSintomas .pdf',
      'icon': Icons.checklist_rtl
    },
    {
      'title': 'Intervenções Psicoeducacionais',
      'description': 'Estratégias terapêuticas',
      'type': 'Manuais',
      'assetPath': 'assets/pdfs/intervencoes_psicoeducacionais.pdf',
      'icon': Icons.healing
    },
    {
      'title': 'Escolarização de Alunos com Autismo',
      'description': 'Inclusão escolar e adaptações',
      'type': 'Manuais',
      'assetPath': 'assets/pdfs/escolarizacaoAlunosComAutismo.pdf',
      'icon': Icons.school
    },
    {
      'title': 'Família e Autismo',
      'description': 'Orientações para familiares',
      'type': 'Guias',
      'assetPath': 'assets/pdfs/familia e autismo.pdf',
      'icon': Icons.family_restroom
    },
    {
      'title': 'Competência Social no Autismo',
      'description': 'Desenvolvimento de habilidades sociais',
      'type': 'Manuais',
      'assetPath': 'assets/pdfs/competenciasocialautismo.pdf',
      'icon': Icons.people
    },
    {
      'title': 'Políticas de Autismo no Brasil',
      'description': 'Legislação e políticas públicas',
      'type': 'Artigos',
      'assetPath': 'assets/pdfs/politicasAutismonoBrasil.pdf',
      'icon': Icons.gavel
    },
    {
      'title': 'Visão Geral: Autismo e Asperger',
      'description': 'Diferenças e características',
      'type': 'Artigos',
      'assetPath': 'assets/pdfs/visão geral autismo e asperger.pdf',
      'icon': Icons.visibility
    },
    {
      'title': 'Um Olhar Sobre o Autismo',
      'description': 'Especificações e características',
      'type': 'Artigos',
      'assetPath': 'assets/pdfs/UM-OLHAR-SOBRE-O-AUTISMO-E-SUAS-ESPECIFICAÇÕES.pdf',
      'icon': Icons.remove_red_eye
    },
    {
      'title': 'Autismo: Perda de Contato',
      'description': 'Aspectos comportamentais',
      'type': 'Artigos',
      'assetPath': 'assets/pdfs/Autismo_Perda_de_contato_com_a_realizade.pdf',
      'icon': Icons.psychology_alt
    },
    {
      'title': 'Pesquisa Científica TEA',
      'description': 'Estudo acadêmico sobre TEA',
      'type': 'Artigos',
      'assetPath': 'assets/pdfs/Viana+et+al.+-+5+RSD.pdf',
      'icon': Icons.science
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
                () => _openPDF(resource['title'], resource['assetPath']),
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

  void _openPDF(String title, String assetPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewer(
          title: title,
          assetPath: assetPath,
        ),
      ),
    );
  }
}