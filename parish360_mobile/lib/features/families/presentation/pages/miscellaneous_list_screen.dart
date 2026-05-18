import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/families/domain/entities/miscellaneous_info.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/miscellaneous/miscellaneous_list_controller.dart';
import 'package:parish360_mobile/features/families/presentation/pages/miscellaneous_info_screen.dart';

class MiscellaneousListScreen extends ConsumerWidget {
  final String familyId;

  const MiscellaneousListScreen({super.key, required this.familyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final miscellaneousList = ref.watch(
      miscellaneousListControllerProvider(familyId),
    );

    return miscellaneousList.when(
      data: (items) {
        if (items.isEmpty) {
          return SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Miscellaneous Directory',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'No records found',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: Colors.white70),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            final newEntry = MiscellaneousInfo(
                              createdAt: DateTime.now(),
                              commentedBy: '',
                              comment: '',
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MiscellaneousInfoScreen(
                                  familyId: familyId,
                                  miscellaneousInfo: newEntry,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return _MiscellaneousListView(
          miscellaneousItems: items,
          familyId: familyId,
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}

class _MiscellaneousListView extends StatelessWidget {
  final List<MiscellaneousInfo> miscellaneousItems;
  final String familyId;

  const _MiscellaneousListView({
    required this.miscellaneousItems,
    required this.familyId,
  });

  String _monthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return monthNames[(month - 1).clamp(0, 11)];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Miscellaneous Directory',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${miscellaneousItems.length} record(s) found',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      final newEntry = MiscellaneousInfo(
                        createdAt: DateTime.now(),
                        commentedBy: '',
                        comment: '',
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MiscellaneousInfoScreen(
                            familyId: familyId,
                            miscellaneousInfo: newEntry,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: miscellaneousItems.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = miscellaneousItems[index];
                  final createdAt = item.createdAt;
                  final monthLabel = createdAt != null
                      ? _monthName(createdAt.month)
                      : 'N/A';
                  final dayLabel = createdAt != null
                      ? createdAt.day.toString()
                      : '--';
                  final yearLabel = createdAt != null
                      ? createdAt.year.toString()
                      : '----';

                  return Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MiscellaneousInfoScreen(
                              familyId: familyId,
                              miscellaneousInfo: item,
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      splashColor: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(40),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 72,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 8,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      monthLabel.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    Text(
                                      dayLabel,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    Text(
                                      yearLabel,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.commentedBy?.isNotEmpty == true
                                          ? item.commentedBy!
                                          : 'Unknown commenter',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item.comment?.isNotEmpty == true
                                          ? item.comment!
                                          : 'No comment provided',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.black87),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
