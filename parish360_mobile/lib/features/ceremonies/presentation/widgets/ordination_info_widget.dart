import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/date_widget.dart';
import 'package:parish360_mobile/core/common/widgets/section_form_group.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/controllers/ordination_form_controller.dart';

class OrdinationInfoWidget extends ConsumerWidget {
  final OrdinationFormControllers ordinationFormControllers;
  final bool isEditable;

  const OrdinationInfoWidget({
    super.key,
    required this.ordinationFormControllers,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SectionFormGroup(
      title: 'Ordination Information',
      children: [
        TextField(
          controller: ordinationFormControllers.religiousOrderController,
          readOnly: !isEditable,
          decoration: const InputDecoration(
            labelText: 'Religious Order',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: ordinationFormControllers.seminaryNameController,
          readOnly: !isEditable,
          decoration: const InputDecoration(
            labelText: 'Seminary Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        SectionFormGroup(
          title: 'Seminary Location',
          children: [
            TextField(
              controller: ordinationFormControllers.seminaryCityController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: ordinationFormControllers.seminaryStateController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'State',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: ordinationFormControllers.seminaryCountryController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        SectionFormGroup(
          title: 'Previous Ordination Information',
          children: [
            TextField(
              controller:
                  ordinationFormControllers.previousOrdinationTypeController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DateWidget(
              controller:
                  ordinationFormControllers.previousOrdinationDateController,
              label: 'Date',
              isEditing: isEditable,
            ),
            SectionFormGroup(
              title: 'Previous Ordination Location',
              children: [
                TextField(
                  controller: ordinationFormControllers
                      .previousOrdinationCityController,
                  readOnly: !isEditable,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: ordinationFormControllers
                      .previousOrdinationStateController,
                  readOnly: !isEditable,
                  decoration: const InputDecoration(
                    labelText: 'State',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: ordinationFormControllers
                      .previousOrdinationCountryController,
                  readOnly: !isEditable,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
