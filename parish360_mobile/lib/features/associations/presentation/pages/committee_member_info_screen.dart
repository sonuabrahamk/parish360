import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/contact_widget.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/associations/domain/entities/committee_member_info.dart';
import 'package:parish360_mobile/features/associations/presentation/controllers/committee_member_info_controller.dart';
import 'package:parish360_mobile/features/associations/presentation/controllers/committee_member_list_controller.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';

class CommitteeMemberInfoScreen extends ConsumerStatefulWidget {
  final String pyAssociationId;
  final CommitteeMemberInfo committeeMemberInfo;

  const CommitteeMemberInfoScreen({
    super.key,
    required this.committeeMemberInfo,
    required this.pyAssociationId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommitteeMemberInfoState();
}

class _CommitteeMemberInfoState
    extends ConsumerState<CommitteeMemberInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _contactController;
  late TextEditingController _emailController;
  late TextEditingController _designationController;
  late TextEditingController _positionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.committeeMemberInfo.name,
    );
    _contactController = TextEditingController(
      text: widget.committeeMemberInfo.contact,
    );
    _emailController = TextEditingController(
      text: widget.committeeMemberInfo.email,
    );
    _designationController = TextEditingController(
      text: widget.committeeMemberInfo.designation,
    );
    _positionController = TextEditingController(
      text: widget.committeeMemberInfo.position != null
          ? widget.committeeMemberInfo.position.toString()
          : "1",
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _designationController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canEdit = ref
        .watch(authControllerProvider.notifier)
        .canEdit('associations');
    return Scaffold(
      appBar: AppBar(
        title: widget.committeeMemberInfo.id == null
            ? const Text('Add new Committee Member')
            : const Text('Committee Member Information'),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ContactWidget(controller: _contactController, isEditing: canEdit),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _designationController,
                decoration: const InputDecoration(
                  labelText: 'Designation',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter designation';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(
                  labelText: 'Position of Designation',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              if (canEdit)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _saveCommitteeMemberInfo(),
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

  void _saveCommitteeMemberInfo() async {
    if (!_formKey.currentState!.validate()) {
      showAppSnackBar(
        context,
        'Please fill in all required fields',
        SnackBarType.warning,
      );
      return;
    }

    CommitteeMemberInfo newMember = CommitteeMemberInfo(
      name: _nameController.text,
      contact: _contactController.text,
      email: _emailController.text,
      designation: _designationController.text,
      position: int.parse(_positionController.text),
    );

    try {
      if (widget.committeeMemberInfo.id == null) {
        await ref
            .read(
              committeeMemberInfoControllerProvider(
                widget.pyAssociationId,
                '',
              ).notifier,
            )
            .addCommitteeMember(widget.pyAssociationId, newMember);
        ref.invalidate(committeeMemberListControllerProvider);

        if (mounted) {
          showAppSnackBar(
            context,
            'New Committee member created successfully',
            SnackBarType.success,
          );
        }
      } else {
        await ref
            .read(
              committeeMemberInfoControllerProvider(
                widget.pyAssociationId,
                widget.committeeMemberInfo.id!,
              ).notifier,
            )
            .updateCommitteeMember(
              widget.pyAssociationId,
              widget.committeeMemberInfo.id!,
              newMember,
            );

        ref.invalidate(committeeMemberListControllerProvider);

        if (mounted) {
          showAppSnackBar(
            context,
            'Committee member details updated successfully',
            SnackBarType.success,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        showAppSnackBar(
          context,
          'Error saving committee member info',
          SnackBarType.error,
        );
      }
    } finally {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }
}
