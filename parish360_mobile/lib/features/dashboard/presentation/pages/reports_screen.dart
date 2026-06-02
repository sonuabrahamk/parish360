import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/dashboard/presentation/controllers/dashboard_controllers.dart';
import 'package:parish360_mobile/features/dashboard/presentation/widgets/dashboard_stat_card.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(parishReportControllerProvider);
    return reportsAsync.when(
      data: (reportInfo) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DashboardStatCard(
                icon: Icons.groups_2,
                value: '${reportInfo.numberOfAssociations ?? 0}',
                label: 'Associations',
              ),
              const SizedBox(height: 12),
              DashboardStatCard(
                icon: Icons.grid_view,
                value: '${reportInfo.numberOfUnits ?? 0}',
                label: 'Units',
              ),
              const SizedBox(height: 12),
              DashboardStatCard(
                icon: Icons.family_restroom,
                value: '${reportInfo.numberOfFamilies ?? 0}',
                label: 'Families',
              ),
              const SizedBox(height: 12),
              DashboardStatCard(
                icon: Icons.group_add,
                value: '${reportInfo.numberOfMembers ?? 0}',
                label: 'Members',
              ),
            ],
          ),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error loading report')),
    );
  }
}
