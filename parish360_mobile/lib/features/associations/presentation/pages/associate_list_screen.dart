import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/list_title.dart';
import 'package:parish360_mobile/features/associations/presentation/controllers/associate_list_controller.dart';
import 'package:parish360_mobile/features/associations/presentation/widgets/association_associate_list.dart';
import 'package:parish360_mobile/features/associations/presentation/widgets/family_associate_list.dart';
import 'package:parish360_mobile/features/associations/presentation/widgets/member_associate_list.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/association_info.dart';
import 'package:parish360_mobile/features/families/domain/entities/family_info.dart';
import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';

class AssociateListScreen extends ConsumerStatefulWidget {
  final String pyAssociationId;
  final String associationType;

  const AssociateListScreen({
    super.key,
    required this.pyAssociationId,
    required this.associationType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AssociateListState();
}

class _AssociateListState extends ConsumerState<AssociateListScreen> {
  late TextEditingController _searchController;

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
    final associatesAsync = ref.watch(
      associateListControllerProvider(widget.pyAssociationId),
    );
    final filteredAssociates = ref.watch(
      filteredAssociatesProvider(
        widget.pyAssociationId,
        widget.associationType,
        _searchController.text,
      ),
    );

    return associatesAsync.when(
      data: (associates) => Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            associates.isEmpty
                ? ListTitle(
                    module: 'no-create-access',
                    subTitle: 'No Associates found for this association',
                    title: 'Associates',
                    onCreatePressed: () {},
                  )
                : ListTitle(
                    module: 'no-create-access',
                    subTitle:
                        'Showing ${filteredAssociates.length} of ${associates.length} associates',
                    title: 'Associates',
                    onCreatePressed: () {},
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
                  hintText: 'Search Associates ...',
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
              child: switch (widget.associationType) {
                'MEMBER' => MemberAssociateList(
                  members: filteredAssociates as List<MemberInfo>,
                ),
                'FAMILY' => FamilyAssociateList(
                  families: filteredAssociates as List<FamilyInfo>,
                ),
                'ASSOCIATION' => AssociationAssociateList(
                  associations: filteredAssociates as List<AssociationInfo>,
                ),
                _ => const Text('Invalid type of association'),
              },
            ),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error loading ceremonies')),
    );
  }
}
