import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/member_info_controller.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/member_list_controller.dart';
import 'package:parish360_mobile/features/families/presentation/pages/member_record_screen.dart';

class MemberListScreen extends ConsumerWidget {
  final String familyId;
  const MemberListScreen({super.key, required this.familyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberList = ref.watch(memberListControllerProvider(familyId));

    return memberList.when(
      data: (members) {
        return DefaultTabController(
          length: members.length + 1, // for new member tab
          child: Scaffold(
            appBar: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              labelPadding: const EdgeInsets.symmetric(horizontal: 12),
              tabs: [
                ...members.map(
                  (member) => GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Member'),
                          content: Text(
                            'Are you sure you want to delete ${member.firstName} ${member.lastName}?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Implement delete logic here
                                await ref
                                    .read(
                                      memberInfoControllerProvider(
                                        familyId,
                                        member.id ?? '',
                                      ).notifier,
                                    )
                                    .deleteMember(familyId, member.id ?? '');
                                ref.invalidate(
                                  memberListControllerProvider(familyId),
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${member.firstName} ${member.lastName} deleted',
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(member.firstName ?? 'No Name'),
                  ),
                ),
                const Tab(text: 'Add Member'),
              ],
            ),
            body: TabBarView(
              children: [
                ...members.map(
                  (member) => MemberRecordScreen(
                    familyId: familyId,
                    memberId: member.id ?? '',
                  ),
                ),
                MemberRecordScreen(familyId: familyId, memberId: 'new'),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}
