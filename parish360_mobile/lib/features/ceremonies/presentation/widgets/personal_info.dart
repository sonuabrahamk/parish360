import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/contact_widget.dart';
import 'package:parish360_mobile/core/common/widgets/date_widget.dart';
import 'package:parish360_mobile/core/common/widgets/section_form_group.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/controllers/ceremony_member_form_controller.dart';

class PersonalInfo extends ConsumerWidget {
  final CeremonyMemberFormController personalDetailsFormControllers;
  final String title;
  final bool isEditable;

  const PersonalInfo({
    super.key,
    required this.personalDetailsFormControllers,
    required this.title,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SectionFormGroup(
      title: title,
      children: [
        TextField(
          controller: personalDetailsFormControllers.nameController,
          readOnly: !isEditable,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: personalDetailsFormControllers.baptismNameController,
          readOnly: !isEditable,
          decoration: const InputDecoration(
            labelText: 'Baptism Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: personalDetailsFormControllers.fatherController,
          readOnly: !isEditable,
          decoration: const InputDecoration(
            labelText: 'Father\'s Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: personalDetailsFormControllers.motherController,
          readOnly: !isEditable,
          decoration: const InputDecoration(
            labelText: 'Mother\'s Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        DateWidget(
          controller: personalDetailsFormControllers.dobController,
          label: 'Date of Birth',
          isEditing: isEditable,
        ),
        TextField(
          controller: personalDetailsFormControllers.emailController,
          readOnly: !isEditable,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        ContactWidget(
          controller: personalDetailsFormControllers.contactController,
          isEditing: isEditable,
          isRequired: false,
        ),
        DropdownButtonFormField<String>(
          initialValue:
              personalDetailsFormControllers.maritalStatusController.text == ''
              ? null
              : personalDetailsFormControllers.maritalStatusController.text,
          decoration: const InputDecoration(
            labelText: 'Marital Status',
            border: OutlineInputBorder(),
          ),
          items: [
            DropdownMenuItem<String>(
              value: 'Unmarried',
              child: Text('Unmarried'),
            ),
            DropdownMenuItem<String>(value: 'Married', child: Text('Married')),
            DropdownMenuItem<String>(value: 'Widowed', child: Text('Widowed')),
          ],
          onChanged: isEditable
              ? (String? newValue) {
                  personalDetailsFormControllers.maritalStatusController.value =
                      TextEditingValue(text: newValue ?? '');
                }
              : null,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: personalDetailsFormControllers.remarksController,
          readOnly: !isEditable,
          decoration: const InputDecoration(
            labelText: 'Remarks',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        SectionFormGroup(
          title: 'Birth Place Information',
          children: [
            TextField(
              controller: personalDetailsFormControllers
                  .personalBirthPlaceCityController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: personalDetailsFormControllers
                  .personalBirthPlaceStateController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'State',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: personalDetailsFormControllers
                  .personalBirthPlaceCountryController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        SectionFormGroup(
          title: 'Parish Information',
          children: [
            TextField(
              controller: personalDetailsFormControllers
                  .personalParishFamilyCodeController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Family Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: personalDetailsFormControllers
                  .personalParishParishNameController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Parish Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: personalDetailsFormControllers
                  .personalParishDioceseNameController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Diocese Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: personalDetailsFormControllers
                  .personalParishLocationCityController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: personalDetailsFormControllers
                  .personalParishLocationStateController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'State',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: personalDetailsFormControllers
                  .personalParishLocationCountryController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        SectionFormGroup(
          title: 'God Father Information',
          children: [
            TextField(
              controller: personalDetailsFormControllers
                  .personalGodFatherNameController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: personalDetailsFormControllers
                  .personalGodFatherBaptismNameController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Baptism Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: personalDetailsFormControllers
                  .personalGodFatherParishController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Parish',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ContactWidget(
              controller: personalDetailsFormControllers
                  .personalGodFatherContactController,
              isEditing: isEditable,
              isRequired: false,
            ),
          ],
        ),
        SectionFormGroup(
          title: 'God Mother Information',
          children: [
            TextField(
              controller: personalDetailsFormControllers
                  .personalGodMotherNameController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: personalDetailsFormControllers
                  .personalGodMotherBaptismNameController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Baptism Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: personalDetailsFormControllers
                  .personalGodMotherParishController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Parish',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ContactWidget(
              controller: personalDetailsFormControllers
                  .personalGodMotherContactController,
              isEditing: isEditable,
              isRequired: false,
            ),
          ],
        ),
      ],
    );
  }
}
