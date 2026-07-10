import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:parish360_mobile/core/common/widgets/list_title.dart';
import 'package:parish360_mobile/core/common/widgets/status_tag.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/parish_year_info.dart';
import 'package:parish360_mobile/features/parish-year/presentation/controllers/parish_year_info_controller.dart';
import 'package:parish360_mobile/features/parish-year/presentation/controllers/parish_year_list_controller.dart';
import 'package:parish360_mobile/features/parish-year/presentation/pages/parish_year_record_screen.dart';
import 'package:parish360_mobile/features/parish-year/presentation/widgets/parish_year_info_screen.dart';

class ParishYearListScreen extends ConsumerStatefulWidget {
  const ParishYearListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ParishYearListScreenState();
}

class _ParishYearListScreenState extends ConsumerState<ParishYearListScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parishYearListAsync = ref.watch(parishYearListControllerProvider);
    final filteredParishYearList = ref.watch(
      filteredParishYearListProvider(_searchController.text),
    );

    final canDelete = ref
        .watch(authControllerProvider.notifier)
        .canDelete("configurations");

    return parishYearListAsync.when(
      data: (parishYearList) => Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            parishYearList.isEmpty
                ? ListTitle(
                    module: 'configurations',
                    subTitle: 'No Parish Year records found',
                    title: 'Parish Year',
                    onCreatePressed: onCreatePressed,
                  )
                : ListTitle(
                    module: 'users',
                    subTitle:
                        'Showing ${filteredParishYearList.length} of ${parishYearList.length} Parish Year',
                    title: 'Parish Year',
                    onCreatePressed: onCreatePressed,
                  ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.zero,
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchController.text = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search parish year ...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: filteredParishYearList.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final parishYear = filteredParishYearList[index];
                  return Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      splashColor: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(12),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParishYearRecordScreen(
                            parishYearInfo: parishYear,
                          ),
                        ),
                      ),
                      onLongPress: !canDelete
                          ? null
                          : () {
                              showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    'Delete Parish Year Record',
                                  ),
                                  content: const Text(
                                    'Are you sure you want to delete this parish year record?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        // await ref
                                        //     .read(
                                        //       parishYearInfoControllerProvider(
                                        //         parishYear.id ?? '',
                                        //       ).notifier,
                                        //     )
                                        //     .deleteParishYear(parishYear.id ?? '');
                                        // ref.invalidate(
                                        //   parishYearListControllerProvider,
                                        // );
                                        if (!context.mounted) return;
                                        showAppSnackBar(
                                          context,
                                          'Deletion is not supported for parish year',
                                          SnackBarType.info,
                                        );
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
                                      parishYear.name ?? '',
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
                                    const SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                parishYear.comment ?? '',
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.grey.shade600,
                                                  size: 16,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  parishYear.startDate == null
                                                      ? '-'
                                                      : DateFormat(
                                                          'yyyy-MM-dd',
                                                        ).format(
                                                          parishYear.startDate!,
                                                        ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: Colors
                                                            .grey
                                                            .shade600,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.grey.shade600,
                                                  size: 16,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  parishYear.endDate == null
                                                      ? '-'
                                                      : DateFormat(
                                                          'yyyy-MM-dd',
                                                        ).format(
                                                          parishYear.endDate!,
                                                        ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: Colors
                                                            .grey
                                                            .shade600,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Divider(height: 1, color: Colors.grey),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            StatusTag(
                                              status: 'default',
                                              child: Text(
                                                parishYear.status ??
                                                    'NOT FOUND',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error loading parish year list')),
    );
  }

  void onCreatePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ParishYearInfoScreen(parishYearInfo: ParishYearInfo()),
      ),
    );
  }
}
