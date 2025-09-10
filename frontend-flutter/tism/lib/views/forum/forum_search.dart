import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';

class ForumSearch extends StatefulWidget {
  const ForumSearch({super.key});

  @override
  State<ForumSearch> createState() => _ForumSearchState();
}

class _ForumSearchState extends State<ForumSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;
  String _selectedFilter = 'Todos';

  final List<String> _filters = ['Todos', 'Posts', 'Usuários', 'Tags'];
  final List<String> _categories = ['Geral', 'Dicas', 'Experiências', 'Dúvidas', 'Recursos'];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
        _searchResults = [];
      });
      return;
    }

    // Simular sugestões em tempo real
    setState(() {
      _suggestions = [
        'atividades sensoriais',
        'terapia ABA',
        'escola inclusiva',
        'comunicação alternativa',
        'rotina diária',
      ].where((s) => s.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void _performSearch(String query) async {
    setState(() {
      _isSearching = true;
      _suggestions = [];
    });

    // Simular busca
    await Future.delayed(const Duration(milliseconds: 800));

    setState(() {
      _searchResults = [
        {
          'type': 'post',
          'title': 'Dicas de atividades sensoriais para crianças autistas',
          'author': 'Ana Costa',
          'content': 'Compartilho algumas atividades que funcionaram muito bem...',
          'likes': 25,
          'comments': 8,
        },
        {
          'type': 'user',
          'name': 'Dr. Carlos Silva',
          'bio': 'Terapeuta especializado em TEA',
          'followers': 150,
        },
      ];
      _isSearching = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Barra de busca
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar posts, pessoas ou tópicos...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _suggestions = [];
                              _searchResults = [];
                            });
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: tismAqua),
                  ),
                ),
                onSubmitted: _performSearch,
              ),
              
              const SizedBox(height: 12),
              
              // Filtros
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters.map((filter) {
                    final isSelected = _selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(filter),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedFilter = filter;
                          });
                        },
                        selectedColor: tismAqua.withOpacity(0.2),
                        checkmarkColor: tismAqua,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        
        // Conteúdo
        Expanded(
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (_isSearching) {
      return const Center(
        child: CircularProgressIndicator(color: tismAqua),
      );
    }

    if (_suggestions.isNotEmpty) {
      return _buildSuggestions();
    }

    if (_searchResults.isNotEmpty) {
      return _buildSearchResults();
    }

    if (_searchController.text.isNotEmpty) {
      return _buildNoResults();
    }

    return _buildInitialState();
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      itemCount: _suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = _suggestions[index];
        return ListTile(
          leading: const Icon(Icons.search, color: Colors.grey),
          title: Text(suggestion),
          onTap: () {
            _searchController.text = suggestion;
            _performSearch(suggestion);
          },
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        
        if (result['type'] == 'post') {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(result['title']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Por ${result['author']}'),
                  const SizedBox(height: 4),
                  Text(result['content'], maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.favorite, size: 16, color: Colors.grey[600]),
                      Text(' ${result['likes']}'),
                      const SizedBox(width: 16),
                      Icon(Icons.comment, size: 16, color: Colors.grey[600]),
                      Text(' ${result['comments']}'),
                    ],
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          );
        } else {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: tismAqua,
                child: Text(result['name'][0]),
              ),
              title: Text(result['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(result['bio']),
                  Text('${result['followers']} seguidores'),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: tismAqua,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Seguir'),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum resultado encontrado',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tente usar palavras-chave diferentes\nou explore as categorias abaixo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categorias Populares',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((category) {
              return ActionChip(
                label: Text(category),
                onPressed: () {
                  _searchController.text = category;
                  _performSearch(category);
                },
                backgroundColor: tismAqua.withOpacity(0.1),
                labelStyle: const TextStyle(color: tismAqua),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Buscas Recentes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Suas buscas aparecerão aqui',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}