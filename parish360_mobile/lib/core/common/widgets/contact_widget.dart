import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactWidget extends ConsumerWidget {
  final TextEditingController controller;
  final bool isEditing;
  final bool isRequired;

  const ContactWidget({
    super.key,
    required this.controller,
    required this.isEditing,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Contact',
          border: const OutlineInputBorder(),
        ),
        readOnly: !isEditing, // Always read-only to prevent manual input
        validator: (value) {
          if (isRequired && (value == null || value.trim().isEmpty)) {
            return 'Contact is required';
          }
          if (isRequired &&
              value != null &&
              !RegExp(r'^[0-9\s\-]+$').hasMatch(value.trim()) &&
              value.trim().length != 10) {
            return 'Please enter a valid contact';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUnfocus,
      ),
    );
  }
}
