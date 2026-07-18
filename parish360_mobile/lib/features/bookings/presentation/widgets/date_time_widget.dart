import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateTimeWidget extends ConsumerWidget {
  final TextEditingController fromDate;
  final TextEditingController toDate;

  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController fromTimeController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController toTimeController = TextEditingController();

  DateTimeWidget({super.key, required this.fromDate, required this.toDate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _initialDates();
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 6,
                child: TextFormField(
                  controller: fromDateController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'From Date',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context, 'FROM'),
                    ),
                  ),
                  readOnly: true, // Always read-only to prevent manual input
                  onTap: () => _selectDate(context, 'FROM'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter from date';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUnfocus,
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                flex: 4,
                child: TextFormField(
                  controller: fromTimeController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'From Time',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () => _selectTime(context, 'FROM'),
                    ),
                  ),
                  readOnly: true, // Always read-only to prevent manual input
                  onTap: () => _selectTime(context, 'FROM'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter from time';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUnfocus,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: TextFormField(
                  controller: toDateController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'To Date',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context, 'TO'),
                    ),
                  ),
                  readOnly: true, // Always read-only to prevent manual input
                  onTap: () => _selectDate(context, 'TO'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter to date';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUnfocus,
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                flex: 4,
                child: TextFormField(
                  controller: toTimeController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'To Time',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () => _selectTime(context, 'TO'),
                    ),
                  ),
                  readOnly: true, // Always read-only to prevent manual input
                  onTap: () => _selectTime(context, 'TO'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter to time';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUnfocus,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _findInitialDate(type),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      final month = picked.month.toString().padLeft(2, '0');
      final day = picked.day.toString().padLeft(2, '0');
      if (type.toUpperCase() == 'FROM') {
        fromDateController.text = '${picked.year}-$month-$day';
        toDateController.clear();
      }
      if (type.toUpperCase() == 'TO') {
        toDateController.text = '${picked.year}-$month-$day';
      }
      _updateFromAndToController();
    }
  }

  Future<void> _selectTime(BuildContext context, String type) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _findInitialTIme(type),
    );
    if (picked != null) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      if (type.toUpperCase() == 'FROM') {
        fromTimeController.text = '$hour:$minute';
      }
      if (type.toUpperCase() == 'TO') {
        toTimeController.text = '$hour:$minute';
      }
      _updateFromAndToController();
    }
  }

  DateTime _findInitialDate(String type) {
    if (type.toUpperCase() == 'FROM') {
      if (fromDateController.text.isNotEmpty) {
        return DateTime.parse(fromDateController.text);
      }
      if (fromDate.text.isNotEmpty && fromDate.text.split('T')[0] != '') {
        return DateTime.parse(fromDate.text);
      }
      return DateTime.now().add(const Duration(days: 1));
    }
    if (type.toUpperCase() == 'TO') {
      if (toDateController.text.isNotEmpty) {
        return DateTime.parse(toDateController.text);
      }
      if (fromDateController.text.isNotEmpty) {
        return DateTime.parse(fromDateController.text).add(const Duration(days: 1));
      }
      if (fromDate.text.isNotEmpty && fromDate.text.split('T')[0] != '') {
        return DateTime.parse(fromDate.text).add(const Duration(days: 1));
      }
      return DateTime.now().add(const Duration(days: 2));
    }
    return DateTime.now().add(const Duration(days: 1));
  }

  TimeOfDay _findInitialTIme(String type) {
    if (type.toUpperCase() == 'FROM') {
      return fromTimeController.text.isNotEmpty
          ? TimeOfDay(
              hour: int.parse(fromTimeController.text.split(':')[0]),
              minute: int.parse(fromTimeController.text.split(':')[0]),
            )
          : TimeOfDay(hour: 0, minute: 0);
    }
    if (type.toUpperCase() == 'TO') {
      return toTimeController.text.isNotEmpty
          ? TimeOfDay(
              hour: int.parse(toTimeController.text.split(':')[0]),
              minute: int.parse(toTimeController.text.split(':')[0]),
            )
          : TimeOfDay(hour: 0, minute: 0);
    }
    return TimeOfDay(hour: 0, minute: 0);
  }

  void _initialDates () {
    if(fromDate.text.isNotEmpty) {
      fromDateController.text = fromDate.text.split('T')[0];
      fromTimeController.text = fromDate.text.split('T')[1];
    }
    if(toDate.text.isNotEmpty) {
      toDateController.text = toDate.text.split('T')[0];
      toTimeController.text = toDate.text.split('T')[1];
    }
  }

  void _updateFromAndToController(){
    fromDate.text = '${fromDateController.text}T${fromTimeController.text}';
    toDate.text = '${toDateController.text}T${toTimeController.text}';
  }
}
