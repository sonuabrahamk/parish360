import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/families/domain/entities/miscellaneous_info.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/miscellaneous/miscellaneous_info_controller.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/miscellaneous/miscellaneous_list_controller.dart';

class MiscellaneousInfoScreen extends ConsumerStatefulWidget {
  final String familyId;
  final MiscellaneousInfo miscellaneousInfo;

  const MiscellaneousInfoScreen({
    super.key,
    required this.familyId,
    required this.miscellaneousInfo,
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
              SizedBox(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveMiscellaneousInfo() async {
    if (_formKey.currentState?.validate() ?? false) {
      final messenger = ScaffoldMessenger.of(context);

      MiscellaneousInfo newMiscellaneousInfo = MiscellaneousInfo(
        commentedBy: _commentedBy.text.trim(),
        comment: _comment.text.trim(),
      );

      try {
        await ref
            .read(
              miscellaneousInfoControllerProvider(
                widget.familyId,
                widget.miscellaneousInfo.id ?? '',
              ).notifier,
            )
            .createMiscellaneousInfo(widget.familyId, newMiscellaneousInfo);
        ref.invalidate(miscellaneousListControllerProvider(widget.familyId));

        messenger.showSnackBar(
          const SnackBar(
            content: Text('Miscellaneous info created successfully'),
          ),
        );
      } catch (e) {
        messenger.showSnackBar(
          SnackBar(content: Text('Error saving miscellaneous info: $e')),
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
}
