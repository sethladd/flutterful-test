// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

enum WidgetType {
  foundational,
  material,
  cupertino,
}

class WidgetCategory {
  final String name;
  final String description;
  final List<WidgetItem> widgets;
  final IconData icon;

  const WidgetCategory({
    required this.name,
    required this.description,
    required this.widgets,
    required this.icon,
  });
}

class WidgetItem {
  final String name;
  final String description;
  final List<WidgetType> types;
  final Widget example;

  const WidgetItem({
    required this.name,
    required this.description,
    required this.types,
    required this.example,
  });
}
