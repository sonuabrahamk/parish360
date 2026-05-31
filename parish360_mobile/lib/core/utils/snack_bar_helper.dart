import 'package:flutter/material.dart';

enum SnackBarType { error, success, warning, info }

Color _snackBarColor(BuildContext context, SnackBarType type) {
  switch (type) {
    case SnackBarType.error:
      return Colors.red;
    case SnackBarType.success:
      return Colors.green;
    case SnackBarType.warning:
      return Colors.orange;
    case SnackBarType.info:
      return Theme.of(context).colorScheme.primary;
  }
}

void showAppSnackBar(BuildContext context, String message, SnackBarType type) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: _snackBarColor(context, type),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
