import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/sacrament_list_controller.dart';
import 'package:parish360_mobile/features/families/presentation/pages/sacrament_info_screen.dart';

class SacramentsScreen extends ConsumerWidget {
  final String familyId;
  final String memberId;

  const SacramentsScreen({
    super.key,
    required this.familyId,
    required this.memberId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sacraments = ref.watch(sacramentListControllerProvider(familyId, memberId));
    
    return sacraments.when(
      data: (data) => SingleChildScrollView(
        child: Column(
          children: data.map((sacrament) => SacramentInfoScreen(familyId: familyId, memberId: memberId, sacrament: sacrament)).toList(),
        ),
      ),
      error: (error, stack) => Center(child: Text('Error loading sacraments: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}