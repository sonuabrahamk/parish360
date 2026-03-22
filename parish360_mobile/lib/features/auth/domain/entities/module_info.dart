import 'package:flutter/material.dart';

class ModuleInfo {
  final String label;
  final IconData icon;
  final String route;
  final int? badgeCount;

  ModuleInfo({
    required this.label,
    required this.icon,
    required this.route,
    this.badgeCount,
  });

}