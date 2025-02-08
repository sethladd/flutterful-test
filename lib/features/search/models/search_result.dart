import 'package:flutter/material.dart';

enum SearchResultType {
  widget,
  graphicsFeature,
  category,
  curve,
}

class SearchResult {
  final String title;
  final String description;
  final SearchResultType type;
  final VoidCallback onTap;
  final IconData? icon;

  const SearchResult({
    required this.title,
    required this.description,
    required this.type,
    required this.onTap,
    this.icon,
  });
}
