import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parish360_mobile/core/error/api_exception.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/account_info.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/accounts/account_info_controller.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/accounts/account_list_controler.dart';

class AccountInfoScreen extends ConsumerStatefulWidget {
  final AccountInfo account;
  final bool canEdit;

  const AccountInfoScreen({
    super.key,
    required this.account,
    required this.canEdit,
  });

  @override
  ConsumerState<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends ConsumerState<AccountInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNoController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.account.name ?? '';
    _descriptionController.text = widget.account.description ?? '';
    _typeController.text = widget.account.type ?? '';
    _ownerController.text = widget.account.owner ?? '';
    _bankNameController.text = widget.account.bankName ?? '';
    _accountNoController.text = widget.account.accountNumber ?? '';
    _branchController.text = widget.account.branch ?? '';
    _ifscCodeController.text = widget.account.ifscCode ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _typeController.dispose();
    _ownerController.dispose();
    _bankNameController.dispose();
    _accountNoController.dispose();
    _branchController.dispose();
    _ifscCodeController.dispose();
    super.dispose();
  }

  void _saveAccountInfo() async {
    if (_formKey.currentState!.validate() == false) return;

    AccountInfo updatedAccount = AccountInfo(
      id: widget.account.id,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      type: _typeController.text.trim(),
      owner: _ownerController.text.trim(),
      bankName: _bankNameController.text.trim(),
      accountNumber: _accountNoController.text.trim(),
      branch: _branchController.text.trim(),
      ifscCode: _ifscCodeController.text.trim(),
    );

    try {
      if (widget.account.id == null) {
        // Create new resource using repository directly
        await ref
            .read(
              accountInfoControllerProvider(widget.account.id ?? '').notifier,
            )
            .createAccount(updatedAccount);
      } else {
        // Update existing resource
        await ref
            .read(
              accountInfoControllerProvider(widget.account.id ?? '').notifier,
            )
            .updateAccountInfo(widget.account.id!, updatedAccount);
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
    ref.invalidate(accountListControllerProvider);

    if (mounted) {
      widget.account.id == null
          ? showAppSnackBar(
              context,
              'Account created successfully',
              SnackBarType.success,
            )
          : showAppSnackBar(
              context,
              'Account updated successfully',
              SnackBarType.success,
            );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.account.id == null
            ? const Text('Create Account')
            : const Text('Account Information'),
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
                  labelText: 'Account Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a account name';
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
                controller: _typeController,
                readOnly: !widget.canEdit,
                decoration: InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ownerController,
                readOnly: !widget.canEdit,
                decoration: InputDecoration(
                  labelText: 'Owner',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _bankNameController,
                readOnly: !widget.canEdit,
                decoration: InputDecoration(
                  labelText: 'Bank Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _accountNoController,
                readOnly: !widget.canEdit,
                decoration: InputDecoration(
                  labelText: 'Account Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _branchController,
                readOnly: !widget.canEdit,
                decoration: InputDecoration(
                  labelText: 'Branch Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ifscCodeController,
                readOnly: !widget.canEdit,
                decoration: InputDecoration(
                  labelText: 'IFSC Code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              widget.canEdit
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveAccountInfo,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('Save Account Info'),
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
