import 'package:flutter/material.dart';
import 'package:parish360_mobile/core/utils/theme.dart';

class DashboardStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final Color? iconColor;

  const DashboardStatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = Colors.white;
    final cardShadow = [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        offset: const Offset(0, 4),
        blurRadius: 8,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: cardShadow,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, size: 45, color: iconColor ?? theme.colorScheme.primary),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  color: valueColor ?? AppTheme.secondaryColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, thickness: 1, color: AppTheme.secondaryColor),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              label,
              style: TextStyle(
                color: valueColor ?? AppTheme.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
