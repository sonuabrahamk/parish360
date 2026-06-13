import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/list_title.dart';
import 'package:parish360_mobile/core/common/widgets/status_tag.dart';
import 'package:parish360_mobile/features/associations/presentation/controllers/py_association_list_controller.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/parish_year_info.dart';
import 'package:parish360_mobile/features/parish-year/presentation/controllers/parish_year_list_controller.dart';

class ParishYearAssociationsScreen extends ConsumerStatefulWidget {
  const ParishYearAssociationsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ParishYearAssociationsScreenState();
}

class _ParishYearAssociationsScreenState
    extends ConsumerState<ParishYearAssociationsScreen> {
  late final TextEditingController _parishYearIdController;

  @override
  void initState() {
    super.initState();
    _parishYearIdController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _parishYearIdController.dispose();
    super.dispose();
  }

  ParishYearInfo initializeAssociations(List<ParishYearInfo> parishYearList) {
    for (int i = 0; i < parishYearList.length; i++) {
      if (parishYearList[i].status?.toUpperCase() == 'IN-PROGRESS') {
        return parishYearList[i];
      }
    }
    return parishYearList[0];
  }

  @override
  Widget build(BuildContext context) {
    final parishYearListAsync = ref.watch(parishYearListControllerProvider);
    final pyAssociations = ref.watch(
      filteredpyAssociationsProvider(_parishYearIdController.text, ''),
    );

    return parishYearListAsync.when(
      data: (parishYearList) {
        if (parishYearList.isEmpty) {
          return const Center(child: Text('No Parish year data found'));
        }
        ParishYearInfo activeParishYear = initializeAssociations(
          parishYearList,
        );
        if (_parishYearIdController.text.isEmpty) {
          _parishYearIdController.text = activeParishYear.id ?? '';
        }
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              pyAssociations.isEmpty
                  ? ListTitle(
                      module: 'parish',
                      subTitle: 'No Associations found',
                      title: 'Associations',
                      onCreatePressed: () {},
                    )
                  : ListTitle(
                      module: 'parish',
                      subTitle: 'Showing ${pyAssociations.length} associations',
                      title: 'Associations',
                      onCreatePressed: () {},
                    ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.zero,
                child: DropdownButtonFormField<String?>(
                  initialValue: _parishYearIdController.text.isEmpty
                      ? null
                      : _parishYearIdController.text,
                  items: parishYearList
                      .map(
                        (parishYear) => DropdownMenuItem<String?>(
                          value: parishYear.id,
                          child: Text(parishYear.name ?? ''),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      print(' Value : $value');
                      _parishYearIdController.text = value ?? '';
                    });
                    print('Updated Length : ${pyAssociations.length}');
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: pyAssociations.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final association = pyAssociations[index].association;
                    return Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        splashColor: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(12),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        association?.name ?? '',
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
                                                  'Description : ${association?.description}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: Colors
                                                            .grey
                                                            .shade600,
                                                      ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  'Type : ${association?.type}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.visible,
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
                                                  association?.scope ?? '',
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              StatusTag(
                                                status:
                                                    '${association?.active}',
                                                child: Text(
                                                  association?.active ?? false
                                                      ? 'ACTIVE'
                                                      : 'IN-ACTIVE',
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
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(
        child: Text('Error loading parish year list to find associations'),
      ),
    );
  }
}
