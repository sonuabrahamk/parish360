import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/date_widget.dart';
import 'package:parish360_mobile/core/common/widgets/section_form_group.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/controllers/afterlife_form_controller.dart';

class AfterlifeInfoWidget extends ConsumerWidget {
  final AfterlifeFormControllers afterlifeFormControllers;
  final bool isEditable;

  const AfterlifeInfoWidget({
    super.key,
    required this.afterlifeFormControllers,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SectionFormGroup(
      title: 'Afterlife Information',
      children: [
        DateWidget(
          controller: afterlifeFormControllers.dateOfDeathController,
          label: 'Date of Death',
          isEditing: isEditable,
        ),
        SectionFormGroup(
          title: 'Place of Death',
          children: [
            TextField(
              controller: afterlifeFormControllers.deathPlaceCityController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: afterlifeFormControllers.deathPlaceStateController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'State',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: afterlifeFormControllers.deathPlaceCountryController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        TextField(
          controller: afterlifeFormControllers.cemetryNameController,
          readOnly: !isEditable,
          decoration: const InputDecoration(
            labelText: 'Cemetery Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        SectionFormGroup(
          title: 'Cemetery Location',
          children: [
            TextField(
              controller: afterlifeFormControllers.cemetryPlaceCityController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: afterlifeFormControllers.cemetryPlaceStateController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'State',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:
                  afterlifeFormControllers.cemetryPlaceCountryController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
