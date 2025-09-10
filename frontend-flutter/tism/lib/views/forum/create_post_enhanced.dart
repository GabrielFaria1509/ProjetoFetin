import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';

class CreatePostEnhanced extends StatefulWidget {
  const CreatePostEnhanced({super.key});

  @override
  State<CreatePostEnhanced> createState() => _CreatePostEnhancedState();
}

class _CreatePostEnhancedState extends State<CreatePostEnhanced> with TickerProviderStateMixin {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  late TabController _tabController;
  
  bool _isPosting = false;
  bool _showPreview = false;
  final List<String> _tags = [];
  String _selectedCategory = 'Geral';
  
  final List<String> _categories = ['Geral', 'Dicas', 'Experiências', 'Dúvidas', 'Recursos'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _contentController.addListener(() {
      setState(() {}); // Para atualizar preview em tempo real
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    _tagController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _createPost() async {
    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, escreva algo antes de postar'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isPosting = true;
    });

    // Simular criação do post
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post criado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Post'),
        backgroundColor: tismAqua,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showPreview = !_showPreview;
              });
            },
            icon: Icon(_showPreview ? Icons.edit : Icons.preview),
          ),
          TextButton(
            onPressed: _isPosting ? null : _createPost,
            child: _isPosting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Postar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Escrever'),
            Tab(text: 'Configurações'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildWriteTab(),
          _buildSettingsTab(),
        ],
      ),
    );
  }

  Widget _buildWriteTab() {
    if (_showPreview) {
      return _buildPreview();
    }
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: _contentController,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(
                hintText: 'Compartilhe sua experiência, dúvida ou dica com a comunidade TEA...\n\nDicas:\n• Use #tags para categorizar\n• Seja respeitoso e construtivo\n• Compartilhe experiências reais',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // Adicionar imagem
                  _showImagePicker();
                },
                icon: const Icon(Icons.image, color: tismAqua),
                tooltip: 'Adicionar imagem',
              ),
              IconButton(
                onPressed: () {
                  // Adicionar emoji
                  _showEmojiPicker();
                },
                icon: const Icon(Icons.emoji_emotions, color: tismAqua),
                tooltip: 'Adicionar emoji',
              ),
              IconButton(
                onPressed: () {
                  _showTagDialog();
                },
                icon: const Icon(Icons.tag, color: tismAqua),
                tooltip: 'Adicionar tag',
              ),
              const Spacer(),
              Text(
                '${_contentController.text.length}/2000',
                style: TextStyle(
                  color: _contentController.text.length > 2000 ? Colors.red : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categoria',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: _categories.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Tags',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (_tags.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: _tags.map((tag) {
                return Chip(
                  label: Text('#$tag'),
                  deleteIcon: const Icon(Icons.close, size: 18),
                  onDeleted: () => _removeTag(tag),
                  backgroundColor: tismAqua.withValues(alpha: 0.1),
                  labelStyle: const TextStyle(color: tismAqua),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
          ],
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _tagController,
                  decoration: const InputDecoration(
                    hintText: 'Adicionar tag...',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _addTag(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _addTag,
                style: ElevatedButton.styleFrom(
                  backgroundColor: tismAqua,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Adicionar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Preview do Post',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: tismAqua,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Você',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Agora • $_selectedCategory',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _contentController.text.isEmpty 
                        ? 'Seu post aparecerá aqui...'
                        : _contentController.text,
                    style: TextStyle(
                      fontSize: 16,
                      color: _contentController.text.isEmpty ? Colors.grey : null,
                      height: 1.4,
                    ),
                  ),
                  if (_tags.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: _tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: tismAqua.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: tismAqua.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            '#$tag',
                            style: const TextStyle(
                              color: tismAqua,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showImagePicker() {
    // Implementar seleção de imagem
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Funcionalidade de imagem em desenvolvimento')),
    );
  }

  void _showEmojiPicker() {
    // Implementar seletor de emoji
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Funcionalidade de emoji em desenvolvimento')),
    );
  }

  void _showTagDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Tag'),
        content: TextField(
          controller: _tagController,
          decoration: const InputDecoration(
            hintText: 'Digite a tag...',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          onSubmitted: (_) {
            _addTag();
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              _addTag();
              Navigator.pop(context);
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}