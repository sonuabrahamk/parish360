import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/list_title.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/associations/data/providers/py_association_providers.dart';
import 'package:parish360_mobile/features/associations/domain/entities/associates_request.dart';
import 'package:parish360_mobile/features/associations/presentation/controllers/associate_list_controller.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/association_info.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/associations/association_list_controller.dart';
import 'package:parish360_mobile/features/dashboard/presentation/controllers/dashboard_controllers.dart';
import 'package:parish360_mobile/features/families/data/providers/families_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/family_info.dart';
import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';

class AssociateMappingScreen extends ConsumerStatefulWidget {
  final String pyAssociationId;
  final String associationType;

  const AssociateMappingScreen({
    super.key,
    required this.pyAssociationId,
    required this.associationType,
  });

  @override
  ConsumerState<AssociateMappingScreen> createState() =>
      _AssociateMappingScreenState();
}

class _AssociateMappingScreenState
    extends ConsumerState<AssociateMappingScreen> {
  late final TextEditingController _searchController;

  final Set<String> _selectedAssociateIds = <String>{};
  late final dynamic _mappedAssociates;

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

    final mappedAssociatesAsync = ref.watch(
      associateListControllerProvider(widget.pyAssociationId),
    );

    if (!_hasInitializedSelection && mappedAssociatesAsync.hasValue) {
      final initialAssociates = mappedAssociatesAsync.value! as List<dynamic>;
      final initialIds = initialAssociates
          .map((item) => item['id'])
          .whereType<String>()
          .toSet();

      setState(() {
        _mappedAssociates = mappedAssociatesAsync.value!;
        _selectedAssociateIds
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
    final currentSelection = _selectedAssociateIds.toList();
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
      final controller = ref.read(pyAssociationRepositoryProvider);

      if (additions.isNotEmpty) {
        await controller.mapAssociates(
          widget.pyAssociationId,
          AssociatesRequest(associates: additions),
        );
      }

      if (removals.isNotEmpty) {
        await controller.unMapAssociates(
          widget.pyAssociationId,
          AssociatesRequest(associates: removals),
        );
      }

      ref.invalidate(associateListControllerProvider(widget.pyAssociationId));

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
    final mappedAssociatesAsync = ref.watch(
      associateListControllerProvider(widget.pyAssociationId),
    );

    final availableMemberAssociates = ref.watch(
      filteredMembersListControllerProvider(_searchController.text),
    );
    final availableFamilyAssociates = ref.watch(
      filteredFamilyInfoListProvider(_searchController.text),
    );
    final availableAssociationAssociates = ref.watch(
      filteredAssociationsInfoListProvider(_searchController.text),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Associates'),
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
                      'Currently Mapped: ${_mappedAssociates.length} | Selected: ${_selectedAssociateIds.length}',
                  title: '${widget.associationType} Associates',
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
            child: switch (widget.associationType) {
              'MEMBER' => mappedAssociatesAsync.when(
                data: (_) {
                  if (availableMemberAssociates.isEmpty) {
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
                              'No associates match your search',
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
                    itemCount: availableMemberAssociates.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final associate = availableMemberAssociates[index];
                      final isSelected = _selectedAssociateIds.contains(
                        associate.id,
                      );
                      return _MemberTile(
                        associate: associate,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedAssociateIds.remove(associate.id);
                            } else {
                              if (associate.id != null) {
                                _selectedAssociateIds.add(associate.id!);
                              }
                            }
                          });
                        },
                      );
                    },
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
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
                          'We could not load the associates right now.',
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
              'FAMILY' => mappedAssociatesAsync.when(
                data: (_) {
                  if (availableFamilyAssociates.isEmpty) {
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
                              'No associates match your search',
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
                    itemCount: availableFamilyAssociates.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final associate = availableFamilyAssociates[index];
                      final isSelected = _selectedAssociateIds.contains(
                        associate.id,
                      );
                      return _FamilyTile(
                        associate: associate,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedAssociateIds.remove(associate.id);
                            } else {
                              if (associate.id != null) {
                                _selectedAssociateIds.add(associate.id!);
                              }
                            }
                          });
                        },
                      );
                    },
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
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
                          'We could not load the associates right now.',
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
              'ASSOCIATION' => mappedAssociatesAsync.when(
                data: (_) {
                  if (availableAssociationAssociates.isEmpty) {
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
                              'No associates match your search',
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
                    itemCount: availableAssociationAssociates.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final associate = availableAssociationAssociates[index];
                      final isSelected = _selectedAssociateIds.contains(
                        associate.id,
                      );
                      return _AssociationTile(
                        associate: associate,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedAssociateIds.remove(associate.id);
                            } else {
                              if (associate.id != null) {
                                _selectedAssociateIds.add(associate.id!);
                              }
                            }
                          });
                        },
                      );
                    },
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
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
                          'We could not load the associates right now.',
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
              _ => Center(
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
                        'We could not load the associates right now.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Invalid association type',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            },
          ),
        ],
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  final MemberInfo associate;
  final bool isSelected;
  final VoidCallback onTap;

  const _MemberTile({
    required this.associate,
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
                          '${associate.firstName ?? ''} ${associate.lastName ?? ''}',
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
                    'Email: ${associate.email}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Occupation: ${associate.occupation}',
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
                      if (associate.contact?.isNotEmpty == true)
                        _InfoChip(label: associate.contact!),
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

class _FamilyTile extends StatelessWidget {
  final FamilyInfo associate;
  final bool isSelected;
  final VoidCallback onTap;

  const _FamilyTile({
    required this.associate,
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
                          associate.familyName ?? 'Family Name',
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
                    'Code: ${associate.familyCode}',
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
                      if (associate.contact?.isNotEmpty == true)
                        _InfoChip(label: associate.contact!),
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

class _AssociationTile extends StatelessWidget {
  final AssociationInfo associate;
  final bool isSelected;
  final VoidCallback onTap;

  const _AssociationTile({
    required this.associate,
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
                          associate.name ?? 'Association Name',
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
                    associate.description ?? '',
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
                      if (associate.type?.isNotEmpty == true)
                        _InfoChip(label: associate.type!),
                      if (associate.scope?.isNotEmpty == true)
                        _InfoChip(label: associate.scope!),
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
