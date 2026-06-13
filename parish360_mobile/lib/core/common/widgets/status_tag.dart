import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/utils/theme.dart';

class StatusTag extends ConsumerWidget {
  final String status;
  final Widget child;

  const StatusTag({super.key, required this.status, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: statusColor(status),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        child: child,
      ),
    );
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'in-progress':
      case 'in-active':
      case 'false':
        return AppTheme.secondaryColor;
      case 'completed':
      case 'confirmed':
      case 'active':
      case 'true':
        return Colors.green;
      case 'info':
        return Colors.blue;
      case 'delete':
        return Colors.red.shade800;
      default:
        return AppTheme.primaryColor;
    }
  }
}
