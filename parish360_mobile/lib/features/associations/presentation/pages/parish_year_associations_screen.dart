import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/associations/presentation/controllers/py_association_list_controller.dart';

class ParishYearAssociationsScreen extends ConsumerStatefulWidget {
  const ParishYearAssociationsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ParishYearAssociationsScreenState();
}

class _ParishYearAssociationsScreenState
    extends ConsumerState<ParishYearAssociationsScreen> {
  @override
  Widget build(BuildContext context) {
    final pyAssociationsAsync = ref.watch(
      pyAssociationListControllerProvider('1-dOJZCoQv2QqbWFQeNSLQ'),
    );

    return pyAssociationsAsync.when(
      data: (pyAssociations) => SizedBox.expand(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final pyAssociation = pyAssociations[index];
            return Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 0.04),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${pyAssociation.association?.name}',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Active: ${pyAssociation.association?.active ?? ''}',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemCount: pyAssociations.length,
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(
        child: Text('Error loading associations for the provided parish year'),
      ),
    );
  }
}
