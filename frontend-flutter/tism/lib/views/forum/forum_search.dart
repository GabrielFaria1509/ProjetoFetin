import 'package:flutter/material.dart';
import 'package:tism/l10n/app_localizations.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/services/forum_service.dart';
import 'package:tism/utils/text_utils.dart';
import 'post_widget.dart';

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
  bool _hasSubmitted = false;



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
        _hasSubmitted = false;
      });
      return;
    }

    setState(() {
      _hasSubmitted = false; // Reset quando digita
      _suggestions = [];
    });
  }

  void _performSearch(String query) async {
    setState(() {
      _isSearching = true;
      _suggestions = [];
      _hasSubmitted = true;
    });

    try {
      final results = await ForumService.searchPosts(query);
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
    }
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
                  hintText: AppLocalizations.of(context)!.search_posts,
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

    if (_searchController.text.isEmpty) {
      return _buildInitialState();
    }

    if (_suggestions.isNotEmpty) {
      return _buildSuggestions();
    }

    if (_searchResults.isNotEmpty) {
      return _buildSearchResults();
    }

    if (_hasSubmitted) {
      return _buildNoResults();
    }

    return _buildTypingState();
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
      padding: const EdgeInsets.all(8),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return PostWidget(
          post: _searchResults[index],
          onLike: (postId) => _toggleLike(postId),
          onComment: (postId) => {},
        );
      },
    );
  }

  Future<void> _toggleLike(String postId) async {
    final success = await ForumService.likePost(int.parse(postId));
    if (success) {
      setState(() {
        final postIndex = _searchResults.indexWhere((p) => p['id'].toString() == postId);
        if (postIndex != -1) {
          _searchResults[postIndex]['isLiked'] = !_searchResults[postIndex]['isLiked'];
          _searchResults[postIndex]['likes'] = (_searchResults[postIndex]['likes'] ?? 0) + 
              (_searchResults[postIndex]['isLiked'] ? 1 : -1);
        }
      });
    }
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
            AppLocalizations.of(context)!.no_results_found,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            TextUtils.processLineBreaks(AppLocalizations.of(context)!.try_different_keywords),
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

  Widget _buildTypingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.type_to_search,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            TextUtils.processLineBreaks(AppLocalizations.of(context)!.find_posts_profiles),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.type_to_search,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            TextUtils.processLineBreaks(AppLocalizations.of(context)!.find_posts_profiles),
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
}