import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parish360_mobile/features/families/data/providers/families_providers.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/family/family_info_list_controller.dart';

class FamilyInfoListScreen extends ConsumerWidget {
  FamilyInfoListScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(familySearchQueryProvider);
    final filteredFamilies = ref.watch(
      filteredFamilyInfoListProvider(searchQuery),
    );

    final familyInfoList = ref.watch(familyInfoListControllerProvider);

    return familyInfoList.when(
      data: (_) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  ref.read(familySearchQueryProvider.notifier).update(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search by code, name, contact, address',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredFamilies.length,
                itemBuilder: (context, index) {
                  final family = filteredFamilies[index];
                  return ListTile(
                    title: Text(family.familyName ?? 'No Name'),
                    subtitle: Text(
                      'Book No: ${family.familyCode} | Contact: ${family.contact}',
                    ),
                    onTap: () => context.go('/families/${family.id}'),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}
