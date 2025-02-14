// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
