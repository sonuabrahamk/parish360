import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/configurations/presentation/pages/parish_info_screen.dart';

class ConfigurationsScreen extends ConsumerWidget {
  const ConfigurationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          labelPadding: const EdgeInsets.symmetric(horizontal: 12),
          tabs: [
            Tab(icon: Icon(Icons.church), text: 'Parish Info'),
            Tab(icon: Icon(Icons.groups), text: 'Associations'),
            Tab(icon: Icon(Icons.self_improvement), text: 'Services'),
            Tab(icon: Icon(Icons.inventory_2), text: 'Resources'),
            Tab(icon: Icon(Icons.account_balance_sharp), text: 'Accounts'),
            // Tab(icon: Icon(Icons.payments), text: 'Payments'),
          ],
        ),
        body: TabBarView(
          children: [
            ParishInfoScreen(),
            Text('Associations Configuration'),
            Text('Services Configuration'),
            Text('Resources Configuration'),
            Text('Accounts Configuration'),
            // Center(child: Text('Payments Page')),
          ],
        ),
      ),
    );
  }
}
