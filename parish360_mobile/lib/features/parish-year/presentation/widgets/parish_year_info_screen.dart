import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/date_widget.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/parish_year_info.dart';
import 'package:parish360_mobile/features/parish-year/presentation/controllers/parish_year_info_controller.dart';
import 'package:parish360_mobile/features/parish-year/presentation/controllers/parish_year_list_controller.dart';

class ParishYearInfoScreen extends ConsumerStatefulWidget {
  final ParishYearInfo parishYearInfo;

  const ParishYearInfoScreen({super.key, required this.parishYearInfo});

  @override
  ConsumerState<ParishYearInfoScreen> createState() =>
      _ParishYearInfoScreenState();
}

class _ParishYearInfoScreenState extends ConsumerState<ParishYearInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _statusController;
  late TextEditingController _commentController;
  late TextEditingController _lockedController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.parishYearInfo.name ?? '',
    );
    _startDateController = TextEditingController(
      text: widget.parishYearInfo.startDate == null
          ? '${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}'
          : '${widget.parishYearInfo.startDate?.year.toString()}-${widget.parishYearInfo.startDate?.month.toString().padLeft(2, '0')}-${widget.parishYearInfo.startDate?.day.toString().padLeft(2, '0')}',
    );
    _endDateController = TextEditingController(
      text: widget.parishYearInfo.endDate == null
          ? '${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}'
          : '${widget.parishYearInfo.endDate?.year.toString()}-${widget.parishYearInfo.endDate?.month.toString().padLeft(2, '0')}-${widget.parishYearInfo.endDate?.day.toString().padLeft(2, '0')}',
    );
    _statusController = TextEditingController(
      text: widget.parishYearInfo.status ?? 'IN-PROGRESS',
    );
    _commentController = TextEditingController(
      text: widget.parishYearInfo.comment ?? '',
    );
    _lockedController = TextEditingController(
      text: widget.parishYearInfo.locked?.toString() ?? 'false',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _statusController.dispose();
    _commentController.dispose();
    _lockedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canCreate = ref
        .read(authControllerProvider.notifier)
        .canCreate("configurations");
    final canEdit =
        (widget.parishYearInfo.status == null ||
            widget.parishYearInfo.status == 'IN-PROGRESS') &&
        (canCreate ||
            ref
                .read(authControllerProvider.notifier)
                .canEdit("configurations"));

    final statusOptions = {
      'ACTIVE': 'Active',
      'IN-PROGRESS': 'In Progress',
      'COMPLETED': 'Completed',
    };

    return Scaffold(
      appBar: AppBar(
        title: widget.parishYearInfo.id == null
            ? const Text('Create Parish Year Info')
            : const Text('Details'),
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppTheme.primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                readOnly: !canEdit,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DateWidget(
                controller: _startDateController,
                label: 'Start Date',
                isEditing: canEdit,
                isRequired: true,
              ),
              DateWidget(
                controller: _endDateController,
                label: 'End Date',
                isEditing: canEdit,
                isRequired: true,
              ),
              TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(),
                ),
                readOnly: !canEdit,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue:
                    widget.parishYearInfo.status == null ||
                        widget.parishYearInfo.status == ''
                    ? 'IN-PROGRESS'
                    : widget.parishYearInfo.status,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: statusOptions.entries
                    .map(
                      (entry) => DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      ),
                    )
                    .toList(),
                onChanged: canEdit
                    ? (String? newValue) {
                        _statusController.value = TextEditingValue(
                          text: newValue ?? '',
                        );
                      }
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: widget.parishYearInfo.locked == true
                    ? 'true'
                    : 'false',
                decoration: const InputDecoration(
                  labelText: 'Locked',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem<String>(value: 'true', child: Text('Yes')),
                  DropdownMenuItem<String>(value: 'false', child: Text('No')),
                ],
                onChanged: canEdit
                    ? (String? newValue) {
                        _lockedController.value = TextEditingValue(
                          text: newValue ?? '',
                        );
                      }
                    : null,
              ),
              const SizedBox(height: 12),
              if (canEdit)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _saveParishYearInfo(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Save Information'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveParishYearInfo() async {
    if (!_formKey.currentState!.validate()) {
      showAppSnackBar(
        context,
        'Please fill all required fields correctly',
        SnackBarType.error,
      );
      return;
    }
    try {
      final updatedParishYearInfo = ParishYearInfo(
        name: _nameController.text,
        startDate: DateTime.parse(_startDateController.text),
        endDate: DateTime.parse(_endDateController.text),
        status: _statusController.text,
        comment: _commentController.text,
        locked: _lockedController.text == 'true',
      );

      if (widget.parishYearInfo.id == null) {
        // Create new Parish Year Info
        await ref
            .read(parishYearInfoControllerProvider('new').notifier)
            .createParishYear(updatedParishYearInfo);

        ref.invalidate(parishYearListControllerProvider);

        if (mounted) {
          showAppSnackBar(
            context,
            'Parish Year info created successfully',
            SnackBarType.success,
          );
        }
      } else {
        // Update existing Parish Year Info
        await ref
            .read(
              parishYearInfoControllerProvider(
                widget.parishYearInfo.id ?? '',
              ).notifier,
            )
            .updateParishYear(
              widget.parishYearInfo.id ?? '',
              updatedParishYearInfo,
            );

        ref.invalidate(parishYearListControllerProvider);

        if (mounted) {
          showAppSnackBar(
            context,
            'Parish Year info updated successfully',
            SnackBarType.success,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        showAppSnackBar(
          context,
          'Error saving Parish Year info',
          SnackBarType.error,
        );
      }
    } finally {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }
}
