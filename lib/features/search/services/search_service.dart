// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutterful/features/search/models/search_result.dart';
import 'package:flutterful/features/widgets/data/widget_categories.dart';
import 'package:flutterful/features/widgets/models/widget_category.dart';

class SearchService {
  List<SearchResult> search(String query, BuildContext context) {
    final results = <SearchResult>[];
    final lowercaseQuery = query.toLowerCase();

    // Search through widget categories
    for (final category in widgetCategories) {
      // Match category
      if (category.name.toLowerCase().contains(lowercaseQuery) ||
          category.description.toLowerCase().contains(lowercaseQuery)) {
        results.add(
          SearchResult(
            title: category.name,
            description: category.description,
            type: SearchResultType.category,
            icon: category.icon,
            onTap: () => _navigateToCategory(context, category),
          ),
        );
      }

      // Match widgets within category
      for (final widget in category.widgets) {
        if (widget.name.toLowerCase().contains(lowercaseQuery) ||
            widget.description.toLowerCase().contains(lowercaseQuery)) {
          results.add(
            SearchResult(
              title: widget.name,
              description: '${category.name} - ${widget.description}',
              type: SearchResultType.widget,
              onTap: () => _navigateToWidget(context, category, widget),
            ),
          );
        }
      }
    }

    // TODO: Add searches for graphics features, curves, etc.

    return results;
  }

  void _navigateToCategory(BuildContext context, WidgetCategory category) {
    Navigator.pushNamed(context, '/widgets/category', arguments: category);
  }

  void _navigateToWidget(
    BuildContext context,
    WidgetCategory category,
    WidgetItem widget,
  ) {
    Navigator.pushNamed(context, '/widgets/detail', arguments: widget);
  }
}
