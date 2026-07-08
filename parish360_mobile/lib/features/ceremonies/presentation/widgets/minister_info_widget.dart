import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/section_form_group.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/controllers/minister_form_controller.dart';

class MinisterInfoWidget extends ConsumerWidget {
  final MinisterFormControllers? ministerFormControllers;
  final bool isEditable;

  const MinisterInfoWidget({
    super.key,
    required this.ministerFormControllers,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SectionFormGroup(
      title: 'Minister Information',
      children: [
        TextField(
          controller: ministerFormControllers?.ministerPriestController,
          readOnly: !isEditable,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: ministerFormControllers?.ministerTitleController,
          readOnly: !isEditable,
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
