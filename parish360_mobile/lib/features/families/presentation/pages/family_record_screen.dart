import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/families/presentation/pages/family_info_screen.dart';
import 'package:parish360_mobile/features/families/presentation/pages/member_list_screen.dart';

class FamilyRecordScreen extends ConsumerWidget {
  final String familyId;
  const FamilyRecordScreen({super.key, required this.familyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
        length: 6, // number of tabs
        child: Scaffold(
          appBar: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              labelPadding: const EdgeInsets.symmetric(horizontal: 12),
              tabs: [
                Tab(icon: Icon(Icons.house), text: 'Family Info'),
                Tab(icon: Icon(Icons.groups), text: 'Members'),
                Tab(icon: Icon(Icons.self_improvement), text: 'Blessings'),
                Tab(icon: Icon(Icons.calendar_month), text: 'Subscriptions'),
                Tab(icon: Icon(Icons.widgets), text: 'Miscellaneous'),
                Tab(icon: Icon(Icons.payments), text: 'Payments'),
              ],
            ),
          
          body: TabBarView(
            children: [
              Center(child: FamilyInfoScreen(familyId: familyId)),
              Center(child: MemberListScreen(familyId: familyId)),
              Center(child: Text('Settings Page')),
              Center(child: Text('Home Page')),
              Center(child: Text('Favorites Page')),
              Center(child: Text('Settings Page')),
            ],
          ),
        ),
    );
  }
}
