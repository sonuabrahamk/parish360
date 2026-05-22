import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactWidget extends ConsumerWidget {
  final TextEditingController controller;
  final bool isEditing;

  const ContactWidget({
    super.key,
    required this.controller,
    required this.isEditing,
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
        readOnly: !isEditing,
        validator: (value) {
          if (value == null ||
              value.trim().isEmpty ||
              !RegExp(r'^\+?[0-9\s\-]+$').hasMatch(value.trim()) ||
              value.trim().length != 10) {
            return 'Please enter a valid contact';
          }
          return null;
        },
      ),
    );
  }
}
