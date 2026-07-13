import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/list_title.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/associations/presentation/controllers/py_association_list_controller.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/association_info.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/associations/association_list_controller.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/py_association_request.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/py_association_response.dart';
import 'package:parish360_mobile/features/parish-year/presentation/controllers/parish_year_info_controller.dart';

class AssociationMappingScreen extends ConsumerStatefulWidget {
  final String parishYearId;

  const AssociationMappingScreen({super.key, required this.parishYearId});

  @override
  ConsumerState<AssociationMappingScreen> createState() =>
      _AssociationMappingScreenState();
}

class _AssociationMappingScreenState
    extends ConsumerState<AssociationMappingScreen> {
  late final TextEditingController _searchController;
  final Set<String> _selectedAssociationIds = <String>{};
  late final List<PyAssociationResponse> _mappedAssociations;
  bool _hasInitializedSelection = false;
  bool _isSaving = false;
  late final Set<String> _initialSelectionIds = <String>{};

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final mappedAssociationsAsync = ref.watch(
      pyAssociationListControllerProvider(widget.parishYearId),
    );

    if (!_hasInitializedSelection && mappedAssociationsAsync.hasValue) {
      final initialIds = mappedAssociationsAsync.value!
          .map((item) => item.association?.id)
          .whereType<String>()
          .toSet();

      setState(() {
        _mappedAssociations = mappedAssociationsAsync.value!;
        _selectedAssociationIds
          ..clear()
          ..addAll(initialIds);
        _initialSelectionIds
          ..clear()
          ..addAll(initialIds);
        _hasInitializedSelection = true;
      });
    }
  }

  Future<void> _saveChanges() async {
    final currentSelection = _selectedAssociationIds.toList();
    final initialSelection = _initialSelectionIds.toList();

    final additions = currentSelection
        .where((id) => !initialSelection.contains(id))
        .toList();
    final removals = initialSelection
        .where((id) => !currentSelection.contains(id))
        .toList();

    if (additions.isEmpty && removals.isEmpty) {
      if (mounted) {
        Navigator.pop(context);
      }
      return;
    }

    setState(() => _isSaving = true);

    try {
      final controller = ref.read(
        parishYearInfoControllerProvider(widget.parishYearId).notifier,
      );

      if (additions.isNotEmpty) {
        await controller.mapAssociationsToParishYear(
          widget.parishYearId,
          PyAssociationRequest(associations: additions),
        );
      }

      if (removals.isNotEmpty) {
        final removalPayload = _mappedAssociations
            .where(
              (mappings) =>
                  mappings.association!.id != null &&
                  removals.contains(mappings.association!.id),
            )
            .map((mappings) => mappings.id)
            .whereType<String>()
            .toList();

        await controller.unMapAssociationsFromParishYear(
          widget.parishYearId,
          PyAssociationRequest(associations: removalPayload),
        );
      }

      ref.invalidate(pyAssociationListControllerProvider(widget.parishYearId));
      ref.invalidate(associationListControllerProvider);

      if (!mounted) {
        return;
      }

      showAppSnackBar(
        context,
        'Association mapping updated successfully',
        SnackBarType.success,
      );
      Navigator.pop(context);
    } catch (error) {
      if (!mounted) {
        return;
      }

      showAppSnackBar(
        context,
        'Unable to update associations',
        SnackBarType.error,
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mappedAssociationsAsync = ref.watch(
      pyAssociationListControllerProvider(widget.parishYearId),
    );
    final availableAssociations = ref.watch(
      filteredAssociationsInfoListProvider(_searchController.text),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Associations'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppTheme.primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          _isSaving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : IconButton(
                  icon: Icon(Icons.check, color: AppTheme.primaryColor),
                  onPressed: _isSaving ? null : _saveChanges,
                  tooltip: 'Save',
                ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTitle(
                  module: 'parishYear',
                  subTitle:
                      'Currently Mapped: ${_mappedAssociations.length} | Selected: ${_selectedAssociationIds.length}',
                  title:
                      _mappedAssociations.first.parishYear!.name ??
                      'Parish Year',
                  onCreatePressed: () {},
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search associations',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: mappedAssociationsAsync.when(
              data: (_) {
                if (availableAssociations.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.groups_outlined,
                            size: 56,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No associations match your search',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Try a different keyword or check if the association exists in the directory.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  itemCount: availableAssociations
                      .where((association) => association.active!)
                      .length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final association = availableAssociations[index];
                    final isSelected = _selectedAssociationIds.contains(
                      association.id,
                    );

                    return association.active!
                        ? _AssociationTile(
                            association: association,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _selectedAssociationIds.remove(
                                    association.id,
                                  );
                                } else {
                                  if (association.id != null) {
                                    _selectedAssociationIds.add(
                                      association.id!,
                                    );
                                  }
                                }
                              });
                            },
                          )
                        : null;
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red.shade700,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'We could not load the associations right now.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AssociationTile extends StatelessWidget {
  final AssociationInfo association;
  final bool isSelected;
  final VoidCallback onTap;

  const _AssociationTile({
    required this.association,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer.withValues(alpha: 0.35)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary.withValues(alpha: 0.6)
                : colorScheme.outlineVariant,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          association.name?.isNotEmpty == true
                              ? association.name!
                              : 'Unknown association',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      if (isSelected)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            'Selected',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    association.description?.isNotEmpty == true
                        ? association.description!
                        : 'Tap to add or remove this association from the parish year.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (association.type?.isNotEmpty == true)
                        _InfoChip(label: association.type!),
                      if (association.scope?.isNotEmpty == true)
                        _InfoChip(label: association.scope!),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Checkbox(
              value: isSelected,
              onChanged: (_) => onTap(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;

  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
