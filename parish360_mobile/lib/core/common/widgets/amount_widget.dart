import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/utils/global_constants.dart';

class AmountWidget extends ConsumerWidget {
  final TextEditingController currencyController;
  final TextEditingController amountController;
  final bool isEditing;
  final bool isRequired;

  const AmountWidget({
    super.key,
    required this.currencyController,
    required this.amountController,
    required this.isEditing,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencies = currencyOptions;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Currency - 30%
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: currencyController.text.isNotEmpty
                      ? currencyController.text
                      : 'INR',
                  items: currencies.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.value,
                      child: Text(entry.key),
                    );
                  }).toList(),
                  onChanged: isEditing
                      ? (value) {
                          if (value != null) {
                            currencyController.text = value;
                          }
                        }
                      : null,
                  decoration: const InputDecoration(
                    labelText: 'Currency',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (isRequired && (value == null || value.isEmpty)) {
                      return 'Please select a currency';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Amount - 70%
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
