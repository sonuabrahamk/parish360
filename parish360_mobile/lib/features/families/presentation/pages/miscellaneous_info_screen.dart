import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/families/domain/entities/miscellaneous_info.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/miscellaneous/miscellaneous_info_controller.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/miscellaneous/miscellaneous_list_controller.dart';

class MiscellaneousInfoScreen extends ConsumerStatefulWidget {
  final String familyId;
  final MiscellaneousInfo miscellaneousInfo;
  final bool canEdit;

  const MiscellaneousInfoScreen({
    super.key,
    required this.familyId,
    required this.miscellaneousInfo,
    required this.canEdit,
  });

  @override
  ConsumerState<MiscellaneousInfoScreen> createState() =>
      _MiscellaneousInfoScreenState();
}

class _MiscellaneousInfoScreenState
    extends ConsumerState<MiscellaneousInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _commentedBy;
  late TextEditingController _comment;

  @override
  void initState() {
    super.initState();
    _commentedBy = TextEditingController(
      text: widget.miscellaneousInfo.commentedBy,
    );
    _comment = TextEditingController(text: widget.miscellaneousInfo.comment);
  }

  @override
  void dispose() {
    _commentedBy.dispose();
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.miscellaneousInfo.id == null
            ? const Text('Create Miscellaneous Information')
            : const Text('Miscellaneous Information'),
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
              _field('Commented By', _commentedBy),
              _field('Comment', _comment),
              widget.canEdit
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _saveMiscellaneousInfo(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('Save Miscellaneous'),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveMiscellaneousInfo() async {
    if (_formKey.currentState?.validate() ?? false) {
      MiscellaneousInfo newMiscellaneousInfo = MiscellaneousInfo(
        commentedBy: _commentedBy.text.trim(),
        comment: _comment.text.trim(),
      );

      try {
        if (widget.miscellaneousInfo.id != null) {
          await ref
              .read(
                miscellaneousInfoControllerProvider(
                  widget.familyId,
                  widget.miscellaneousInfo.id ?? '',
                ).notifier,
              )
              .updateMiscellaneousInfo(
                widget.familyId,
                widget.miscellaneousInfo.id ?? '',
                newMiscellaneousInfo,
              );
        } else {
          await ref
              .read(
                miscellaneousInfoControllerProvider(
                  widget.familyId,
                  widget.miscellaneousInfo.id ?? '',
                ).notifier,
              )
              .createMiscellaneousInfo(widget.familyId, newMiscellaneousInfo);
        }
        ref.invalidate(miscellaneousListControllerProvider(widget.familyId));
        if (mounted) {
          if (widget.miscellaneousInfo.id != null) {
            showAppSnackBar(
              context,
              'Miscellaneous info updated successfully.',
              SnackBarType.success,
            );
          } else {
            showAppSnackBar(
              context,
              'Miscellaneous info created successfully.',
              SnackBarType.success,
            );
          }
        }
      } catch (e) {
        if (mounted) {
          showAppSnackBar(
            context,
            'Failed to save miscellaneous info. Please try again.',
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
        'Please fill in all required fields.',
        SnackBarType.warning,
      );
    }
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        readOnly: !widget.canEdit,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUnfocus,
      ),
    );
  }
}
