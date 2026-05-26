import 'package:flutter/material.dart';

/// A reusable form section wrapper with a rounded border and a title
/// shown on the top-right edge of the border.
///
/// This is useful for grouping related `TextFormField`s or other form
/// controls into visually distinct sections.
class SectionFormGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderRadiusGeometry borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final Color? titleBackgroundColor;

  const SectionFormGroup({
    super.key,
    required this.title,
    required this.children,
    this.padding = const EdgeInsets.fromLTRB(16, 20, 16, 16),
    this.margin = const EdgeInsets.symmetric(vertical: 12),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.borderColor,
    this.borderWidth = 1.0,
    this.titleBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBorderColor = borderColor ?? theme.dividerColor;
    final effectiveTitleBackground =
        titleBackgroundColor ?? theme.scaffoldBackgroundColor;

    return Container(
      margin: margin,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: effectiveBorderColor,
                width: borderWidth,
              ),
              borderRadius: borderRadius,
            ),
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
          Positioned(
            top: -10,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: effectiveTitleBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
