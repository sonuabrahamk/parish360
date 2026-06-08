import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/parish-year/presentation/controllers/parish_year_list_controller.dart';

class ParishYearListScreen extends ConsumerStatefulWidget {
  const ParishYearListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ParishYearListScreenState();
}

class _ParishYearListScreenState extends ConsumerState<ParishYearListScreen> {
  @override
  Widget build(BuildContext context) {
    final parishYearListAsync = ref.watch(parishYearListControllerProvider);

    return parishYearListAsync.when(
      data: (parishYearList) => SizedBox.expand(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final parishYear = parishYearList[index];
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
                                '${parishYear.name}',
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
                                'Active: ${parishYear.status ?? ''}',
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
          itemCount: parishYearList.length,
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error loading parish year list')),
    );
  }
}
