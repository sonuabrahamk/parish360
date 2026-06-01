import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/member_info_controller.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/member_list_controller.dart';
import 'package:parish360_mobile/features/families/presentation/pages/member_record_screen.dart';

class MemberListScreen extends ConsumerWidget {
  final String familyId;
  const MemberListScreen({super.key, required this.familyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberList = ref.watch(memberListControllerProvider(familyId));

    final bool canCreate = ref
        .read(authControllerProvider.notifier)
        .canCreate('family-records');
    final bool canDelete = ref
        .read(authControllerProvider.notifier)
        .canDelete('family-records');

    return memberList.when(
      data: (members) {
        return DefaultTabController(
          length: members.length + (canCreate ? 1 : 0),
          child: Scaffold(
            appBar: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              labelPadding: const EdgeInsets.symmetric(horizontal: 12),
              tabs: [
                ...members.map(
                  (member) => Tab(
                    child: GestureDetector(
                      onLongPress: !canDelete
                          ? null
                          : () {
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
                                            .deleteMember(
                                              familyId,
                                              member.id ?? '',
                                            );
                                        ref.invalidate(
                                          memberListControllerProvider(
                                            familyId,
                                          ),
                                        );
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '${member.firstName} ${member.lastName} deleted',
                                              ),
                                            ),
                                          );
                                        }
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
                ),
                if (canCreate) const Tab(text: 'Add Member'),
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
                if (canCreate)
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
