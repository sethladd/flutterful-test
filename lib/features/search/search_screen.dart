// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutterful/features/search/models/search_result.dart';
import 'package:flutterful/features/search/services/search_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _searchService = SearchService();
  List<SearchResult> _results = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    if (query.isEmpty) {
      setState(() {
        _results = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _results = _searchService.search(query, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search widgets, graphics, colors...',
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                : null,
          ),
        ),
      ),
      body: _buildResults(),
    );
  }

  Widget _buildResults() {
    if (_searchController.text.isEmpty) {
      return const Center(
        child: Text('Start typing to search'),
      );
    }

    if (_results.isEmpty) {
      return const Center(
        child: Text('No results found'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final result = _results[index];
        return _SearchResultTile(result: result);
      },
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final SearchResult result;

  const _SearchResultTile({
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          result.icon != null ? Icon(result.icon) : _buildTypeIcon(result.type),
      title: Text(result.title),
      subtitle: Text(result.description),
      trailing: _buildTypeChip(result.type),
      onTap: result.onTap,
    );
  }

  Widget _buildTypeIcon(SearchResultType type) {
    IconData icon;
    switch (type) {
      case SearchResultType.widget:
        icon = Icons.widgets;
      case SearchResultType.graphicsFeature:
        icon = Icons.brush;
      case SearchResultType.category:
        icon = Icons.folder;
      case SearchResultType.curve:
        icon = Icons.animation;
    }
    return Icon(icon);
  }

  Widget _buildTypeChip(SearchResultType type) {
    return Chip(
      label: Text(
        type.name[0].toUpperCase() + type.name.substring(1),
        style: const TextStyle(fontSize: 12),
      ),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );
  }
}
