import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parish360_mobile/core/common/widgets/date_widget.dart';
import 'package:parish360_mobile/core/error/api_exception.dart';
import 'package:parish360_mobile/core/utils/member_option_constants.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/association_info.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/associations/association_info_controller.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/associations/association_list_controller.dart';

class AssociationInfoScreen extends ConsumerStatefulWidget {
  final AssociationInfo association;
  final bool canEdit;

  const AssociationInfoScreen({
    super.key,
    required this.association,
    required this.canEdit,
  });

  @override
  ConsumerState<AssociationInfoScreen> createState() =>
      _AssociationInfoScreenState();
}

class _AssociationInfoScreenState extends ConsumerState<AssociationInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _typeController = TextEditingController();
  final _directorController = TextEditingController();
  final _scopeController = TextEditingController();
  final _patronController = TextEditingController();
  final _foundedDateController = TextEditingController();
  final _isActiveController = TextEditingController();

  @override
  void initState() {
    initializeAssociationInfo(widget.association);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _typeController.dispose();
    _directorController.dispose();
    _scopeController.dispose();
    _patronController.dispose();
    _foundedDateController.dispose();
    _isActiveController.dispose();
  }

  void initializeAssociationInfo(AssociationInfo associationInfo) {
    _nameController.text = associationInfo.name ?? '';
    _descriptionController.text = associationInfo.description ?? '';
    _typeController.text = associationInfo.type ?? '';
    _directorController.text = associationInfo.director ?? '';
    _scopeController.text = associationInfo.scope ?? '';
    _patronController.text = associationInfo.patron ?? '';
    _foundedDateController.text = associationInfo.foundedDate != null
        ? associationInfo.foundedDate.toString().trim().split(' ')[0]
        : DateTime.now().toString().trim().split(' ')[0];
    _isActiveController.text = associationInfo.isActive.toString();
  }

  void _saveAssociation() async {
    if (_formKey.currentState!.validate() == false) return;

    AssociationInfo updatedInfo = AssociationInfo(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      type: _typeController.text.trim(),
      patron: _patronController.text.trim(),
      scope: _scopeController.text.trim(),
      director: _directorController.text.trim(),
      foundedDate: DateTime.parse(_foundedDateController.text.trim()),
      isActive: widget.association.id == null
          ? true
          : widget.association.isActive,
    );

    try {
      if (widget.association.id == null) {
        await ref
            .read(
              associationInfoControllerProvider(
                widget.association.id ?? '',
              ).notifier,
            )
            .createAssociation(updatedInfo);
      } else {
        await ref
            .read(
              associationInfoControllerProvider(
                widget.association.id ?? '',
              ).notifier,
            )
            .updateAssociation(widget.association.id ?? '', updatedInfo);
      }
    } on ApiException catch (e) {
      if (!mounted) return;
      showAppSnackBar(context, e.message, SnackBarType.error);
    } finally {
      ref.invalidate(associationListControllerProvider);
      if(mounted) {
        widget.association.id == null ? 
        showAppSnackBar(context, 'Association created successfully', SnackBarType.success)
        : showAppSnackBar(context, 'Association updated successfully', SnackBarType.success);
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.association.id == null
            ? const Text('Create Association')
            : const Text('Association Information'),
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
                readOnly: !widget.canEdit,
                decoration: InputDecoration(
                  label: Text('Association Name'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Association name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _descriptionController,
                readOnly: !widget.canEdit,
                decoration: InputDecoration(
                  label: Text('Description'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              DropdownButtonFormField<String>(
                initialValue: _typeController.text == ''
                    ? null
                    : _typeController.text.toUpperCase(),
                decoration: const InputDecoration(
                  labelText: 'Association Type',
                ),
                items: kAssociationTypes.entries
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item.key,
                        child: Text(item.value),
                      ),
                    )
                    .toList(),
                onChanged: widget.canEdit
                    ? (String? newValue) {
                        _typeController.text = newValue ?? '';
                      }
                    : null,
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _directorController,
                readOnly: !widget.canEdit,
                decoration: InputDecoration(
                  label: Text('Director'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              DropdownButtonFormField<String>(
                initialValue: _scopeController.text == ''
                    ? null
                    : _scopeController.text.toUpperCase(),
                decoration: const InputDecoration(
                  labelText: 'Association Scope',
                ),
                items: kAssociationScopes.entries
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item.key,
                        child: Text(item.value),
                      ),
                    )
                    .toList(),
                onChanged: widget.canEdit
                    ? (String? newValue) {
                        _scopeController.text = newValue ?? '';
                      }
                    : null,
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _patronController,
                readOnly: !widget.canEdit,
                decoration: InputDecoration(
                  label: Text('Patron'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              DateWidget(
                controller: _foundedDateController,
                label: 'Founded Date',
                isEditing: widget.canEdit,
              ),
              widget.canEdit
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveAssociation,
                        child: Text('Save'),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
