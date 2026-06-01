import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/association_info.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/associations/association_info_controller.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/associations/association_list_controller.dart';
import 'package:parish360_mobile/features/configurations/presentation/pages/association_info_screen.dart';

class AssociationListScreen extends ConsumerStatefulWidget {
  const AssociationListScreen({super.key});

  @override
  ConsumerState<AssociationListScreen> createState() =>
      _AssociationListScreenState();
}

class _AssociationListScreenState extends ConsumerState<AssociationListScreen> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(
      text: ref.read(associationSearchQueryProvider),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(associationSearchQueryProvider);
    final associationListAsync = ref.watch(associationListControllerProvider);
    final filteredAssociationList = ref.watch(
      filteredAssociationsInfoListProvider(searchQuery),
    );

    bool canCreate = ref
        .read(authControllerProvider.notifier)
        .canCreate('configurations');
    bool canEdit = ref
        .read(authControllerProvider.notifier)
        .canEdit('configurations');
    bool canDelete = ref
        .read(authControllerProvider.notifier)
        .canDelete('configurations');

    return associationListAsync.when(
      data: (associations) => SizedBox.expand(
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
                          'Associations Directory',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${associations.length} associations found',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        canCreate
                            ? IconButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AssociationInfoScreen(
                                      association: AssociationInfo(),
                                      canEdit: canCreate,
                                    ),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    ref
                        .read(associationSearchQueryProvider.notifier)
                        .update(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search by name, type or scope',
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
              const SizedBox(height: 18),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: filteredAssociationList.length,
                  itemBuilder: (context, index) {
                    final association = filteredAssociationList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssociationInfoScreen(
                                association: association,
                                canEdit: canEdit,
                              ),
                            ),
                          );
                        },
                        onLongPress: !canDelete
                            ? null
                            : () {
                                showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete Association'),
                                    content: const Text(
                                      'Are you sure you want to delete this association?',
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
                                                associationInfoControllerProvider(
                                                  association.id ?? '',
                                                ).notifier,
                                              )
                                              .deleteAssociation(
                                                association.id ?? '',
                                              );
                                          ref.invalidate(
                                            associationListControllerProvider,
                                          );
                                          if (!context.mounted) return;
                                          showAppSnackBar(
                                            context,
                                            'Association record deleted',
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  association.name?.isNotEmpty == true
                                      ? association.name!
                                      : 'Unknown Association',
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
                                  'Assciation Type : ${association.type ?? 'N/A'}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey.shade600),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Assciation Scope : ${association.scope ?? 'N/A'}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey.shade600),
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
      ),
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
