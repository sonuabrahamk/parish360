import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateWidget extends ConsumerWidget {
  final TextEditingController controller;
  final String label;
  final bool isEditing;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DateWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.isEditing,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: !isEditing
              ? null
              : IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
        ),
        readOnly: !isEditing,
        validator: (value) {
          // Additional validation for date format can be added here
          return null;
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.text.isNotEmpty
          ? DateTime.parse(controller.text)
          : DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
    );
    if (picked != null) {
      final month = picked.month.toString().padLeft(2, '0');
      final day = picked.day.toString().padLeft(2, '0');
      controller.text = '${picked.year}-$month-$day';
    }
  }
}
