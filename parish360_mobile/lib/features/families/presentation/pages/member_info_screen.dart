import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';

class MemberInfoScreen extends ConsumerStatefulWidget {
  final String familyId;
  final String memberId;
  final bool isEditing;
  final MemberInfo memberInfo;
  final ValueChanged<MemberInfo> onInfoChanged;

  const MemberInfoScreen({
    super.key,
    required this.familyId,
    required this.memberId,
    required this.isEditing,
    required this.memberInfo,
    required this.onInfoChanged,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MemberInfoScreenState();
}

class _MemberInfoScreenState extends ConsumerState<MemberInfoScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _contactController;
  late TextEditingController _fatherController;
  late TextEditingController _motherController;
  late TextEditingController _dobController;
  String? _selectedRelationship;

  final List<String> _relationshipOptions = [
    'father',
    'mother',
    'son',
    'daughter',
    'head-of-family',
    'spouse',
    'brother',
    'sister',
    'grandfather',
    'grandmother',
    'uncle',
    'aunt',
    'nephew',
    'niece',
    'other',
  ];

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.memberInfo.firstName ?? '');
    _contactController = TextEditingController(text: widget.memberInfo.contact ?? '');
    _fatherController = TextEditingController(text: widget.memberInfo.father ?? '');
    _motherController = TextEditingController(text: widget.memberInfo.mother ?? '');
    _dobController = TextEditingController(
      text: widget.memberInfo.dob != null
          ? '${widget.memberInfo.dob!.day}/${widget.memberInfo.dob!.month}/${widget.memberInfo.dob!.year}'
          : '',
    );
    _selectedRelationship = widget.memberInfo.relationship;
  }

  @override
  void didUpdateWidget(covariant MemberInfoScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.memberInfo != widget.memberInfo) {
      _firstNameController.text = widget.memberInfo.firstName ?? '';
      _contactController.text = widget.memberInfo.contact ?? '';
      _fatherController.text = widget.memberInfo.father ?? '';
      _motherController.text = widget.memberInfo.mother ?? '';
      _dobController.text = widget.memberInfo.dob != null
          ? '${widget.memberInfo.dob!.day}/${widget.memberInfo.dob!.month}/${widget.memberInfo.dob!.year}'
          : '';
      _selectedRelationship = widget.memberInfo.relationship;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _contactController.dispose();
    _fatherController.dispose();
    _motherController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.memberInfo.dob ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dobController.text = '${picked.day}/${picked.month}/${picked.year}';
      _notifyChanged();
    }
  }

  void _notifyChanged() {
    DateTime? dob;
    if (_dobController.text.isNotEmpty) {
      try {
        final parts = _dobController.text.split('/');
        if (parts.length == 3) {
          dob = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
        }
      } catch (e) {
        // Invalid date format, keep as null
      }
    }

    widget.onInfoChanged(
      widget.memberInfo.copyWith(
        firstName: _firstNameController.text.trim(),
        contact: _contactController.text.trim(),
        father: _fatherController.text.trim(),
        mother: _motherController.text.trim(),
        dob: dob,
        relationship: _selectedRelationship,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allowEdit = widget.isEditing;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _firstNameController,
            readOnly: !allowEdit,
            decoration: const InputDecoration(labelText: 'First Name'),
            onChanged: (_) => _notifyChanged(),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _contactController,
            readOnly: !allowEdit,
            decoration: const InputDecoration(labelText: 'Contact'),
            onChanged: (_) => _notifyChanged(),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _dobController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Date of Birth',
              suffixIcon: allowEdit
                  ? IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _fatherController,
            readOnly: !allowEdit,
            decoration: const InputDecoration(labelText: 'Father'),
            onChanged: (_) => _notifyChanged(),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _motherController,
            readOnly: !allowEdit,
            decoration: const InputDecoration(labelText: 'Mother'),
            onChanged: (_) => _notifyChanged(),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _selectedRelationship,
            decoration: const InputDecoration(labelText: 'Relationship'),
            items: _relationshipOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: allowEdit
                ? (String? newValue) {
                    setState(() {
                      _selectedRelationship = newValue;
                    });
                    _notifyChanged();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
