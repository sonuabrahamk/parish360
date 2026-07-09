import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/list_title.dart';
import 'package:parish360_mobile/core/common/widgets/status_tag.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/ceremony_info.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/controllers/ceremony_info_controller.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/controllers/ceremony_list_controller.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/pages/ceremony_info_screen.dart';

class CeremoniesScreen extends ConsumerStatefulWidget {
  const CeremoniesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CeremoniesScreenState();
}

class _CeremoniesScreenState extends ConsumerState<CeremoniesScreen> {
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
    final String module = 'ceremonies';
    final ceremoniesAsync = ref.watch(ceremonyListControllerProvider);
    final filteredCeremonies = ref.watch(
      filteredCeremoniesProvider(_searchController.text),
    );

    final canDelete = ref
        .read(authControllerProvider.notifier)
        .canDelete(module);

    return ceremoniesAsync.when(
      data: (ceremonies) => Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ceremonies.isEmpty
                ? ListTitle(
                    module: module,
                    subTitle: 'No Ceremony records found',
                    title: 'Ceremonies',
                    onCreatePressed: onCreatePressed,
                  )
                : ListTitle(
                    module: module,
                    subTitle:
                        'Showing ${filteredCeremonies.length} of ${ceremonies.length} ceremonies',
                    title: 'Ceremonies',
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
                  hintText: 'Search Ceremonies ...',
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
                itemCount: filteredCeremonies.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final ceremony = filteredCeremonies[index];
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
                          builder: (context) =>
                              CeremonyInfoScreen(ceremonyInfo: ceremony),
                        ),
                      ),
                      onLongPress: !canDelete
                          ? null
                          : () {
                              showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete Ceremony Record'),
                                  content: const Text(
                                    'Are you sure you want to delete this ceremony record?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await ref
                                            .read(
                                              ceremonyInfoControllerProvider(
                                                ceremony.id ?? '',
                                              ).notifier,
                                            )
                                            .deleteCeremony(ceremony.id ?? '');
                                        ref.invalidate(
                                          ceremonyListControllerProvider,
                                        );
                                        if (!context.mounted) return;
                                        showAppSnackBar(
                                          context,
                                          'Ceremony record deleted',
                                          SnackBarType.success,
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
                                      ceremony.type ?? '',
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
                                                'Name : ${ceremony.name}',
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
                                              const SizedBox(height: 5),
                                              Text(
                                                'Minister : ${ceremony.minister?.priest}',
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
                                                ceremony.parishioner == true
                                                    ? 'Parishioner'
                                                    : 'Non-Parishioner',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            StatusTag(
                                              status: 'default',
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    ceremony.date
                                                        .toString()
                                                        .split(' ')[0],
                                                  ),
                                                ],
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
      error: (e, st) => Center(child: Text('Error loading ceremonies')),
    );
  }

  void onCreatePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CeremonyInfoScreen(ceremonyInfo: CeremonyInfo()),
      ),
    );
  }
}
