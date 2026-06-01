import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parish360_mobile/core/error/api_exception.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/configurations/data/providers/resources_providers.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/resource_info.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/resources/resources_info_controller.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/resources/resources_list_controller.dart';

class ResourceInfoScreen extends ConsumerStatefulWidget {
  final ResourceInfo resourceInfo;
  final bool canEdit;

  const ResourceInfoScreen({
    super.key,
    required this.resourceInfo,
    required this.canEdit,
  });

  @override
  ConsumerState<ResourceInfoScreen> createState() => _ResourceInfoScreenState();
}

class _ResourceInfoScreenState extends ConsumerState<ResourceInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  final TextEditingController _massCompatibleController =
      TextEditingController();
  final TextEditingController _activeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('Mass Compatible: ${widget.resourceInfo.massCompatible}');
    _nameController.text = widget.resourceInfo.name ?? '';
    _descriptionController.text = widget.resourceInfo.description ?? '';
    _capacityController.text = widget.resourceInfo.capacity?.toString() ?? '';
    _amountController.text = widget.resourceInfo.amount?.toString() ?? '';
    _currencyController.text = widget.resourceInfo.currency ?? '';
    _massCompatibleController.text =
        widget.resourceInfo.massCompatible.toString().toLowerCase() == 'true'
        ? 'true'
        : 'false';
    _activeController.text = widget.resourceInfo.active ?? true ? 'Yes' : 'No';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _capacityController.dispose();
    _amountController.dispose();
    _currencyController.dispose();
    _massCompatibleController.dispose();
    _activeController.dispose();
    super.dispose();
  }

  Future<void> _saveResourceInfo() async {
    if (_formKey.currentState!.validate() == false) return;

    print(_massCompatibleController.text.trim().toLowerCase() == 'true');

    ResourceInfo updatedInfo = ResourceInfo(
      id: widget.resourceInfo.id,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      capacity: int.tryParse(_capacityController.text.trim()),
      amount: double.tryParse(_amountController.text.trim()),
      currency: _currencyController.text.trim(),
      massCompatible:
          _massCompatibleController.text.trim().toLowerCase() == 'true',
      active: _activeController.text.trim().toLowerCase() == 'true',
    );

    try {
      if (widget.resourceInfo.id == null) {
        // Create new resource using repository directly
        await ref.read(resourceRepositoryProvider).createResource(updatedInfo);
      } else {
        // Update existing resource
        await ref
            .read(
              resourcesInfoControllerProvider(widget.resourceInfo.id!).notifier,
            )
            .updateResourceInfo(widget.resourceInfo.id!, updatedInfo);
      }
    } on ApiException catch (e) {
      if (!mounted) return;
      showAppSnackBar(context, e.message, SnackBarType.error);
      return;
    } on DioException catch (e) {
      if (!mounted) return;
      showAppSnackBar(
        context,
        e.response?.data['message'] ?? 'An error occurred',
        SnackBarType.error,
      );
      return;
    }

    // Invalidate the list to refresh after create/update
    ref.invalidate(resourcesListControllerProvider);

    if (mounted) {
      widget.resourceInfo.id == null
          ? showAppSnackBar(
              context,
              'Resource created successfully',
              SnackBarType.success,
            )
          : showAppSnackBar(
              context,
              'Resource updated successfully',
              SnackBarType.success,
            );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.resourceInfo.id == null
            ? const Text('Create Resource')
            : const Text('Resource Information'),
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
                  labelText: 'Resource Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a resource name';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUnfocus,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                readOnly: !widget.canEdit,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _capacityController,
                readOnly: !widget.canEdit,
                decoration: InputDecoration(
                  labelText: 'Capacity',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountController,
                readOnly: !widget.canEdit,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _currencyController,
                readOnly: !widget.canEdit,
                decoration: InputDecoration(
                  labelText: 'Currency',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Is Mass Compatible',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                initialValue:
                    _massCompatibleController.text.trim().toLowerCase() == ''
                    ? 'true'
                    : _massCompatibleController.text.trim().toLowerCase() ==
                          'true'
                    ? 'true'
                    : 'false',
                items: const [
                  DropdownMenuItem(value: 'true', child: Text('Yes')),
                  DropdownMenuItem(value: 'false', child: Text('No')),
                ],
                onChanged: widget.canEdit
                    ? (value) {
                        _massCompatibleController.text = value.toString();
                      }
                    : null,
              ),
              const SizedBox(height: 12),

              widget.canEdit
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveResourceInfo,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('Save Resource'),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
