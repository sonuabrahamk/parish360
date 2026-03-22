import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/member_list_controller.dart';
import 'package:parish360_mobile/features/families/presentation/pages/member_record_screen.dart';

class MemberListScreen extends ConsumerWidget{
  final String familyId;
  const MemberListScreen({super.key, required this.familyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberList = ref.watch(memberListControllerProvider(familyId));

    return memberList.when(
      data: (members) {
        return DefaultTabController(
          length: members.length, 
          child: Scaffold(
            appBar: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              labelPadding: const EdgeInsets.symmetric(horizontal: 12),
              tabs: members.map((member) => Tab(text: member.firstName ?? 'No Name')).toList(),
            ),
            body: TabBarView(
              children: members.map((member) => MemberRecordScreen(familyId: familyId, memberId: member.id ?? '')).toList(),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}