import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/dashboard/presentation/pages/members_screen.dart';
import 'package:parish360_mobile/features/dashboard/presentation/pages/reports_screen.dart';
import 'package:parish360_mobile/features/dashboard/presentation/pages/statements_screen.dart';

class DashboardScreen extends ConsumerWidget{
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3, // number of tabs
      child: Scaffold(
        appBar: TabBar(
          isScrollable: false,
          tabAlignment: TabAlignment.fill,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          labelPadding: const EdgeInsets.symmetric(horizontal: 12),
          tabs: [
            Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
            Tab(icon: Icon(Icons.groups), text: 'Members'),
            Tab(icon: Icon(Icons.account_balance), text: 'Statement'),
          ],
        ),

        body: TabBarView(
          children: [
            ReportsScreen(),
            MembersScreen(),
            StatementsScreen(),
          ],
        ),
      ),
    );
  }
}