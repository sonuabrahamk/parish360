import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/families/data/providers/families_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/family_info.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/family/family_info_controller.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/family/family_info_list_controller.dart';

class FamilyInfoScreen extends ConsumerStatefulWidget {
  final String familyId;
  final bool isEditing;

  const FamilyInfoScreen({super.key, required this.familyId, this.isEditing = false});

  @override
  ConsumerState<FamilyInfoScreen> createState() => _FamilyInfoScreenState();
}

class _FamilyInfoScreenState extends ConsumerState<FamilyInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  bool _initialized = false;
  FamilyInfo? _currentFamilyInfo;

  late final TextEditingController _familyNameController;
  late final TextEditingController _familyCodeController;
  late final TextEditingController _contactController;
  late final TextEditingController _addressController;
  late final TextEditingController _unitController;
  late final TextEditingController _headOfFamilyController;
  late final TextEditingController _joinedDateController;
  late final TextEditingController _contactVerifiedController;

  bool get _isNewFamily => widget.familyId == 'new';

  @override
  void initState() {
    super.initState();
    _familyNameController = TextEditingController();
    _familyCodeController = TextEditingController();
    _contactController = TextEditingController();
    _addressController = TextEditingController();
    _unitController = TextEditingController();
    _headOfFamilyController = TextEditingController();
    _joinedDateController = TextEditingController();
    _contactVerifiedController = TextEditingController();
    _isEditing = widget.isEditing;
    if (_isNewFamily) {
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _familyNameController.dispose();
    _familyCodeController.dispose();
    _contactController.dispose();
    _addressController.dispose();
    _unitController.dispose();
    _headOfFamilyController.dispose();
    _joinedDateController.dispose();
    _contactVerifiedController.dispose();
    super.dispose();
  }

  void _initializeFromFamilyInfo(FamilyInfo familyInfo) {
    _currentFamilyInfo = familyInfo;
    _familyNameController.text = familyInfo.familyName ?? '';
    _familyCodeController.text = familyInfo.familyCode ?? '';
    _contactController.text = familyInfo.contact ?? '';
    _addressController.text = familyInfo.address ?? '';
    _unitController.text = familyInfo.unit ?? '';
    _headOfFamilyController.text = familyInfo.headOfFamily ?? '';
    _joinedDateController.text = familyInfo.joinedDate != null
        ? familyInfo.joinedDate!.toLocal().toString().split(' ')[0]
        : '';
    _contactVerifiedController.text = familyInfo.contactVerified == null
        ? ''
        : familyInfo.contactVerified!
        ? 'Yes'
        : 'No';
    _initialized = true;
  }

  Future<void> _saveFamilyInfo() async {
    if (!_formKey.currentState!.validate()) return;

    final familyInfo = FamilyInfo(
      id: _isNewFamily ? null : widget.familyId,
      familyName: _familyNameController.text.trim(),
      familyCode: _familyCodeController.text.trim(),
      contact: _contactController.text.trim(),
      address: _addressController.text.trim(),
      unit: _unitController.text.trim(),
      headOfFamily: _headOfFamilyController.text.trim(),
      joinedDate: DateTime.tryParse(_joinedDateController.text.trim()),
      contactVerified:
          _contactVerifiedController.text.trim().toLowerCase() == 'yes',
      createdAt: _currentFamilyInfo?.createdAt ?? DateTime.now(),
      createdBy: _currentFamilyInfo?.createdBy,
      updatedAt: _isNewFamily ? null : DateTime.now(),
      updatedBy: _currentFamilyInfo?.updatedBy,
      parishId: _currentFamilyInfo?.parishId,
    );

    try {
      if (_isNewFamily) {
        await ref.read(familyInfoRepositoryProvider).createFamily(familyInfo);
      } else {
        await ref
            .read(familyInfoControllerProvider(widget.familyId).notifier)
            .updateFamily(widget.familyId, familyInfo);
      }

      setState(() {
        _isEditing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_isNewFamily ? 'Family info created successfully' : 'Family info saved successfully')),
        );
        if (_isNewFamily) {
          ref.invalidate(familyInfoListControllerProvider);
          context.pop();
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_isNewFamily ? 'Failed to create family info: $error' : 'Failed to save family info: $error')),
        );
      }
    }
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isNewFamily) {
      return _buildScaffold(
        context,
        title: 'New Family Info',
        showEditAction: false,
        showSaveAction: true,
        showCancelAction: true,
      );
    }

    final familyAsync = ref.watch(
      familyInfoControllerProvider(widget.familyId),
    );

    return familyAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Text(
          'Error loading family info: $error',
          style: const TextStyle(color: Colors.red),
        ),
      ),
      data: (familyInfo) {
        if (!_initialized || _currentFamilyInfo?.id != familyInfo.id) {
          _initializeFromFamilyInfo(familyInfo);
        }

        return _buildScaffold(
          context,
          title: familyInfo.familyName?.isNotEmpty == true
              ? '${familyInfo.familyName} Details'
              : 'Family Info',
          showEditAction: !_isEditing,
          showSaveAction: _isEditing,
          showCancelAction: _isEditing,
        );
      },
    );
  }

  Widget _buildScaffold(
    BuildContext context, {
    required String title,
    required bool showEditAction,
    required bool showSaveAction,
    required bool showCancelAction,
  }) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1),
        ),
        actions: [
          if (showEditAction)
            IconButton(
              icon: Icon(Icons.edit, color: AppTheme.primaryColor),
              onPressed: _toggleEditing,
              tooltip: 'Edit',
            ),
          if (showSaveAction)
            IconButton(
              icon: Icon(Icons.check, color: AppTheme.primaryColor),
              onPressed: _saveFamilyInfo,
              tooltip: 'Save',
            ),
          if (showCancelAction)
            IconButton(
              icon: Icon(Icons.close, color: AppTheme.primaryColor),
              onPressed: () {
                if (_isNewFamily) {
                  context.pop();
                } else {
                  _toggleEditing();
                }
              },
              tooltip: 'Cancel',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FamilyInfoForm(
              formKey: _formKey,
              isEditing: _isEditing,
              familyNameController: _familyNameController,
              familyCodeController: _familyCodeController,
              contactController: _contactController,
              addressController: _addressController,
              unitController: _unitController,
              headOfFamilyController: _headOfFamilyController,
              joinedDateController: _joinedDateController,
              contactVerifiedController: _contactVerifiedController,
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyInfoSummaryCard extends StatelessWidget {
  final FamilyInfo familyInfo;

  const FamilyInfoSummaryCard({super.key, required this.familyInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            familyInfo.familyName?.isNotEmpty == true
                ? familyInfo.familyName!
                : 'Family Details',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            familyInfo.familyCode ?? 'No family code available',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _summaryChip(
                context,
                label: 'Joined',
                value: familyInfo.joinedDate != null
                    ? familyInfo.joinedDate!.toLocal().toString().split(' ')[0]
                    : 'Unknown',
              ),
              _summaryChip(
                context,
                label: 'Verified',
                value: familyInfo.contactVerified == true ? 'Yes' : 'No',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryChip(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(40),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class FamilyInfoForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isEditing;
  final TextEditingController familyNameController;
  final TextEditingController familyCodeController;
  final TextEditingController contactController;
  final TextEditingController addressController;
  final TextEditingController unitController;
  final TextEditingController headOfFamilyController;
  final TextEditingController joinedDateController;
  final TextEditingController contactVerifiedController;

  const FamilyInfoForm({
    super.key,
    required this.formKey,
    required this.isEditing,
    required this.familyNameController,
    required this.familyCodeController,
    required this.contactController,
    required this.addressController,
    required this.unitController,
    required this.headOfFamilyController,
    required this.joinedDateController,
    required this.contactVerifiedController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _field('Family Name', familyNameController, isEditing),
          _field('Family Code', familyCodeController, isEditing),
          _field('Contact', contactController, isEditing),
          _field('Address', addressController, isEditing),
          _field('Unit', unitController, isEditing),
          _field('Head of Family', headOfFamilyController, isEditing),
          _field('Joined Date', joinedDateController, isEditing),
          _field('Contact Verified', contactVerifiedController, isEditing),
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController controller, bool enabled) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        readOnly: !enabled,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
