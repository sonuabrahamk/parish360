import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/contact_widget.dart';
import 'package:parish360_mobile/core/common/widgets/section_form_group.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/controllers/witness_form_controller.dart';

class WitnessInfoWidget extends ConsumerWidget {
  final WitnessFormControllers witnessFormControllers;
  final String witnessTitle;
  final bool isEditable;

  const WitnessInfoWidget({
    super.key,
    required this.witnessFormControllers,
    required this.witnessTitle,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SectionFormGroup(
      title: witnessTitle,
      children: [
        TextField(
          controller: witnessFormControllers.witnessNameController,
          readOnly: !isEditable,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: witnessFormControllers.witnessRelationController,
          readOnly: !isEditable,
          decoration: const InputDecoration(
            labelText: 'Relation',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: witnessFormControllers.witnessParishController,
          readOnly: !isEditable,
          decoration: const InputDecoration(
            labelText: 'Parish',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        ContactWidget(
          controller: witnessFormControllers.witnessContactController,
          isEditing: isEditable,
          isRequired: false,
        ),
      ],
    );
  }
}
