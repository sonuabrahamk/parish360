import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/associations/presentation/controllers/py_association_list_controller.dart';
import 'package:parish360_mobile/features/parish-year/presentation/widgets/py_association_list_screen.dart';

class AssociationsScreen extends ConsumerStatefulWidget {
  final String parishYearId;

  const AssociationsScreen({super.key, required this.parishYearId});

  @override
  ConsumerState<AssociationsScreen> createState() => _AssociationsScreenState();
}

class _AssociationsScreenState extends ConsumerState<AssociationsScreen> {
  late TextEditingController _searchController;

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
  Widget build(BuildContext context) {
    final pyAssociations = ref.watch(
      filteredpyAssociationsProvider(
        widget.parishYearId,
        _searchController.text,
      ),
    );

    if (pyAssociations.isEmpty) {
      return const Center(
        child: Text('No Associations found for this Parish Year'),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                hintText: 'Search Associations ...',
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
          PyAssociationListScreen(pyAssociations: pyAssociations),
        ],
      ),
    );
  }
}
