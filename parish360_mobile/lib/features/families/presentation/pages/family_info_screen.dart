import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/families/domain/entities/family_info.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/family/family_info_controller.dart';

class FamilyInfoScreen extends ConsumerStatefulWidget {
  final String familyId;
  const FamilyInfoScreen({super.key, required this.familyId});

  @override
  ConsumerState<FamilyInfoScreen> createState() => _FamilyInfoScreenState();
}

class _FamilyInfoScreenState extends ConsumerState<FamilyInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _familyNameController;
  late TextEditingController _familyCodeController;
  late TextEditingController _contactController;
  late TextEditingController _addressController;
  late TextEditingController _unitController;
  late TextEditingController _headOfFamilyController;
  late TextEditingController _joinedDateController;
  late TextEditingController _contactVerifiedController;

  bool _initialized = false;
  bool _isEditing = false;

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

  void _initControllers(FamilyInfo familyInfo) {
    _familyNameController = TextEditingController(
      text: familyInfo.familyName ?? '',
    );
    _familyCodeController = TextEditingController(
      text: familyInfo.familyCode ?? '',
    );
    _contactController = TextEditingController(text: familyInfo.contact ?? '');
    _addressController = TextEditingController(text: familyInfo.address ?? '');
    _unitController = TextEditingController(text: familyInfo.unit ?? '');
    _headOfFamilyController = TextEditingController(
      text: familyInfo.headOfFamily ?? '',
    );
    _joinedDateController = TextEditingController(
      text: familyInfo.joinedDate != null
          ? familyInfo.joinedDate!.toLocal().toString().split(' ')[0]
          : '',
    );
    _contactVerifiedController = TextEditingController(
      text: familyInfo.contactVerified == null
          ? ''
          : familyInfo.contactVerified!
          ? 'Yes'
          : 'No',
    );

    _initialized = true;
  }

  void _saveFamilyInfo() {
    if (_formKey.currentState!.validate()) {
      // Implement save logic here
      setState(() {
        _isEditing = false;
      });

      var familyInfo = FamilyInfo(
        id: widget.familyId,
        familyName: _familyNameController.text,
        familyCode: _familyCodeController.text,
        contact: _contactController.text,
        address: _addressController.text,
        unit: _unitController.text,
        headOfFamily: _headOfFamilyController.text,
        joinedDate: DateTime.tryParse(_joinedDateController.text),
        contactVerified:
            _contactVerifiedController.text.toLowerCase() == 'yes',
      );

      ref
          .read(familyInfoControllerProvider(widget.familyId).notifier).updateFamily(widget.familyId, familyInfo);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Family info saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final familyAsync = ref.watch(
      familyInfoControllerProvider(widget.familyId),
    );

    return familyAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (familyInfo) {
        if (!_initialized) {
          _initControllers(familyInfo);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              _familyNameController.text.isEmpty
                  ? 'Family Info'
                  : '${_familyNameController.text} - Details',
            ),
            centerTitle: false,
            backgroundColor: AppTheme.primaryColor,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1, thickness: 1),
            ),
            actions: [
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert),
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                      break;
                    case 'save':
                      _saveFamilyInfo();
                      break;
                    case 'cancel':
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                      break;
                  }
                },
                itemBuilder: (context) => [
                  if (!_isEditing)
                    const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  if (_isEditing)
                    const PopupMenuItem(value: 'save', child: Text('Save')),
                  if (_isEditing)
                    const PopupMenuItem(value: 'cancel', child: Text('Cancel')),
                ],
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _field('Family Name', _familyNameController),
                  _field('Family Code', _familyCodeController),
                  _field('Contact', _contactController),
                  _field('Address', _addressController),
                  _field('Unit', _unitController),
                  _field('Head of Family', _headOfFamilyController),
                  _field('Joined Date', _joinedDateController),
                  _field('Contact Verified', _contactVerifiedController),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        readOnly: !_isEditing,
      ),
    );
  }
}
