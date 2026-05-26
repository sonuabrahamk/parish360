import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/contact_widget.dart';
import 'package:parish360_mobile/core/common/widgets/date_widget.dart';
import 'package:parish360_mobile/core/common/widgets/section_form_group.dart';
import 'package:parish360_mobile/core/utils/member_option_constants.dart';

class MemberInfoScreen extends ConsumerWidget {
  final bool isEditing;
  final MemberFormControllers controllers;

  final Map<String, String> _genderOptions = kMemberGenderOptions;
  final Map<String, String> _relationshipOptions = kMemberRelationshipOptions;
  final Map<String, String> _maritalStatusOptions = kMemberMaritalStatusOptions;

  const MemberInfoScreen({
    super.key,
    required this.isEditing,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controllers.firstNameController,
            readOnly: !isEditing,
            decoration: const InputDecoration(
              labelText: 'First Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'First name is required';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUnfocus,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: controllers.lastNameController,
            readOnly: !isEditing,
            decoration: const InputDecoration(
              labelText: 'Last Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: controllers.emailController,
            readOnly: !isEditing,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return null; // email is not required
              } else if (!RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              ).hasMatch(value)) {
                return 'Please enter valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          ContactWidget(
            controller: controllers.contactController,
            isEditing: isEditing,
            isRequired: false,
          ),
          DropdownButtonFormField<String>(
            initialValue: controllers.relationshipController.text == ''
                ? null
                : controllers.relationshipController.text,
            decoration: const InputDecoration(
              labelText: 'Relationship',
              border: OutlineInputBorder(),
            ),
            items: _relationshipOptions.entries
                .map(
                  (entry) => DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  ),
                )
                .toList(),
            onChanged: isEditing
                ? (String? newValue) {
                    controllers.relationshipController.value = TextEditingValue(
                      text: newValue ?? '',
                    );
                  }
                : null,
            validator: (value) {
              if (value == null) {
                return 'Please select a relationship';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUnfocus,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: controllers.fatherController,
            readOnly: !isEditing,
            decoration: const InputDecoration(
              labelText: 'Father',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: controllers.motherController,
            readOnly: !isEditing,
            decoration: const InputDecoration(
              labelText: 'Mother',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          DateWidget(
            controller: controllers.dobController,
            label: 'Date Of Birth',
            isEditing: isEditing,
          ),
          DropdownButtonFormField<String>(
            initialValue: controllers.genderController.text == ''
                ? null
                : controllers.genderController.text,
            decoration: const InputDecoration(
              labelText: 'Gender',
              border: OutlineInputBorder(),
            ),
            items: _genderOptions.entries
                .map(
                  (entry) => DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  ),
                )
                .toList(),
            onChanged: isEditing
                ? (String? newValue) {
                    controllers.genderController.value = TextEditingValue(
                      text: newValue ?? '',
                    );
                  }
                : null,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: controllers.maritalStatusController.text == ''
                ? null
                : controllers.maritalStatusController.text,
            decoration: const InputDecoration(
              labelText: 'Marital Status',
              border: OutlineInputBorder(),
            ),
            items: _maritalStatusOptions.entries
                .map(
                  (entry) => DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  ),
                )
                .toList(),
            onChanged: isEditing
                ? (String? newValue) {
                    controllers.maritalStatusController.value =
                        TextEditingValue(text: newValue ?? '');
                  }
                : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: controllers.qualificationController,
            readOnly: !isEditing,
            decoration: const InputDecoration(
              labelText: 'Qualification',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: controllers.occupationController,
            readOnly: !isEditing,
            decoration: const InputDecoration(
              labelText: 'Occupation',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 5),
          SectionFormGroup(
            title: 'Birth Place',
            children: [
              TextFormField(
                controller: controllers.birthPlaceCityController,
                readOnly: !isEditing,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controllers.birthPlaceStateController,
                readOnly: !isEditing,
                decoration: const InputDecoration(
                  labelText: 'State',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controllers.birthPlaceCountryController,
                readOnly: !isEditing,
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          SectionFormGroup(
            title: 'God Father Details',
            children: [
              TextFormField(
                controller: controllers.godFatherNameController,
                readOnly: !isEditing,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controllers.godFatherBaptismNameController,
                readOnly: !isEditing,
                decoration: const InputDecoration(
                  labelText: 'Baptism Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controllers.godFatherParishController,
                readOnly: !isEditing,
                decoration: const InputDecoration(
                  labelText: 'Parish',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ContactWidget(
                controller: controllers.godFatherContactController,
                isEditing: isEditing,
                isRequired: false,
              ),
            ],
          ),
          SectionFormGroup(
            title: 'God Mother Details',
            children: [
              TextFormField(
                controller: controllers.godMotherNameController,
                readOnly: !isEditing,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controllers.godMotherBaptismNameController,
                readOnly: !isEditing,
                decoration: const InputDecoration(
                  labelText: 'Baptism Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controllers.godMotherParishController,
                readOnly: !isEditing,
                decoration: const InputDecoration(
                  labelText: 'Parish',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ContactWidget(
                controller: controllers.godMotherContactController,
                isEditing: isEditing,
                isRequired: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MemberFormControllers {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final baptismNameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  final fatherController = TextEditingController();
  final motherController = TextEditingController();
  final dobController = TextEditingController();

  final relationshipController = TextEditingController();
  final genderController = TextEditingController();
  final maritalStatusController = TextEditingController();

  final qualificationController = TextEditingController();
  final occupationController = TextEditingController();
  final birthPlaceCityController = TextEditingController();
  final birthPlaceStateController = TextEditingController();
  final birthPlaceCountryController = TextEditingController();
  final godFatherNameController = TextEditingController();
  final godMotherNameController = TextEditingController();
  final godFatherBaptismNameController = TextEditingController();
  final godMotherBaptismNameController = TextEditingController();
  final godFatherParishController = TextEditingController();
  final godMotherParishController = TextEditingController();
  final godFatherContactController = TextEditingController();
  final godMotherContactController = TextEditingController();

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    baptismNameController.dispose();
    emailController.dispose();
    contactController.dispose();
    fatherController.dispose();
    motherController.dispose();
    dobController.dispose();
    relationshipController.dispose();
    genderController.dispose();
    maritalStatusController.dispose();
    qualificationController.dispose();
    occupationController.dispose();
    birthPlaceCityController.dispose();
    birthPlaceStateController.dispose();
    birthPlaceCountryController.dispose();
    godFatherNameController.dispose();
    godMotherNameController.dispose();
    godFatherBaptismNameController.dispose();
    godMotherBaptismNameController.dispose();
    godFatherParishController.dispose();
    godMotherParishController.dispose();
    godFatherContactController.dispose();
    godMotherContactController.dispose();
  }
}
