import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/families/domain/entities/blessing_info.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/blessings/blessing_info_controller.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/blessings/blessing_list_controller.dart';

class BlessingsInfoScreen extends ConsumerStatefulWidget {
  final String familyId;
  final BlessingInfo blessingInfo;

  const BlessingsInfoScreen({
    super.key,
    required this.familyId,
    required this.blessingInfo,
  });

  @override
  ConsumerState<BlessingsInfoScreen> createState() =>
      _BlessingsInfoScreenState();
}

class _BlessingsInfoScreenState extends ConsumerState<BlessingsInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _date;
  late TextEditingController _priest;
  late TextEditingController _reason;

  @override
  void initState() {
    super.initState();
    if (widget.blessingInfo.date != null) {
      final date = widget.blessingInfo.date!;
      _date = TextEditingController(
        text: '${date.day}/${date.month}/${date.year}',
      );
    } else {
      _date = TextEditingController();
    }
    _priest = TextEditingController(text: widget.blessingInfo.priest);
    _reason = TextEditingController(text: widget.blessingInfo.reason);
  }

  @override
  void dispose() {
    _date.dispose();
    _priest.dispose();
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.blessingInfo.id == null
            ? const Text('Create Blessing Information')
            : const Text('Blessing Information'),
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
              TextField(
                controller: _date,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              _field('Priest', _priest),
              _field('Reason', _reason),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _saveBlessingInfo(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Save Blessing'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveBlessingInfo() async {
    if (_formKey.currentState?.validate() ?? false) {
      final messenger = ScaffoldMessenger.of(context);

      // Parse date of blessing from the text field
      DateTime? dateOfBlessing;
      if (_date.text.isNotEmpty) {
        try {
          final parts = _date.text.split('/');
          if (parts.length == 3) {
            dateOfBlessing = DateTime(
              int.parse(parts[2]),
              int.parse(parts[1]),
              int.parse(parts[0]),
            );
          }
        } catch (e) {
          messenger.showSnackBar(
            const SnackBar(
              content: Text('Invalid date format. Use DD/MM/YYYY'),
            ),
          );
          return;
        }
      }

      BlessingInfo newBlessingInfo = BlessingInfo(
        id: widget.blessingInfo.id,
        date: dateOfBlessing,
        priest: _priest.text.trim(),
        reason: _reason.text.trim(),
      );

      try {
        if (widget.blessingInfo.id == null) {
          await ref
              .read(
                blessingInfoControllerProvider(
                  widget.familyId,
                  widget.blessingInfo.id ?? '',
                ).notifier,
              )
              .createBlessingInfo(widget.familyId, newBlessingInfo);
          ref.invalidate(blessingListControllerProvider(widget.familyId));

          messenger.showSnackBar(
            const SnackBar(content: Text('Blessing info created successfully')),
          );
        } else {
          await ref
              .read(
                blessingInfoControllerProvider(
                  widget.familyId,
                  widget.blessingInfo.id ?? '',
                ).notifier,
              )
              .updateBlessingInfo(widget.familyId, newBlessingInfo);

          ref.invalidate(blessingListControllerProvider(widget.familyId));

          messenger.showSnackBar(
            const SnackBar(content: Text('Blessing info updated successfully')),
          );
        }
      } catch (e) {
        messenger.showSnackBar(
          SnackBar(content: Text('Error saving blessing info: $e')),
        );
      } finally {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
    }
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.blessingInfo.date ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _date.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }
}
