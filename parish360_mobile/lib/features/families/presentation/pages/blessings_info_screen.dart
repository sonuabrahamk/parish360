import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/date_widget.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/families/domain/entities/blessing_info.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/blessings/blessing_info_controller.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/blessings/blessing_list_controller.dart';

class BlessingsInfoScreen extends ConsumerStatefulWidget {
  final String familyId;
  final BlessingInfo blessingInfo;
  final bool canEdit;

  const BlessingsInfoScreen({
    super.key,
    required this.familyId,
    required this.blessingInfo,
    required this.canEdit,
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
        text:
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
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
              DateWidget(
                controller: _date,
                label: 'Date',
                isEditing: widget.canEdit,
                isRequired: true,
                lastDate: DateTime.now(),
              ),
              const SizedBox(height: 12.0),
              _field('Priest', _priest, true),
              _field('Reason', _reason, false),
              widget.canEdit
                  ? SizedBox(
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
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveBlessingInfo() async {
    if (_formKey.currentState?.validate() ?? false) {
      BlessingInfo newBlessingInfo = BlessingInfo(
        id: widget.blessingInfo.id,
        date: _date.text.trim().isEmpty
            ? null
            : DateTime.parse(_date.text.trim()),
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

          if (mounted) {
            showAppSnackBar(
              context,
              'Blessing info created successfully',
              SnackBarType.success,
            );
          }
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

          if (mounted) {
            showAppSnackBar(
              context,
              'Blessing info updated successfully',
              SnackBarType.success,
            );
          }
        }
      } catch (e) {
        if (mounted) {
          showAppSnackBar(
            context,
            'Error saving blessing info',
            SnackBarType.error,
          );
        }
      } finally {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    } else {
      showAppSnackBar(
        context,
        'Please fill in all required fields',
        SnackBarType.warning,
      );
    }
  }

  Widget _field(
    String label,
    TextEditingController controller,
    bool isRequired,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        readOnly: !widget.canEdit,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        validator: (value) {
          if (isRequired && (value == null || value.trim().isEmpty)) {
            return 'This field is required';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUnfocus,
      ),
    );
  }
}
