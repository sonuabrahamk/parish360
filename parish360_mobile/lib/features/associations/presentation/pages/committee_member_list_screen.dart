import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/list_title.dart';
import 'package:parish360_mobile/core/common/widgets/status_tag.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/features/associations/domain/entities/committee_member_info.dart';
import 'package:parish360_mobile/features/associations/presentation/controllers/committee_member_info_controller.dart';
import 'package:parish360_mobile/features/associations/presentation/controllers/committee_member_list_controller.dart';
import 'package:parish360_mobile/features/associations/presentation/pages/committee_member_info_screen.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';

class CommitteeMemberListScreen extends ConsumerStatefulWidget {
  final String pyAssociationId;

  const CommitteeMemberListScreen({super.key, required this.pyAssociationId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommitteeMemberListScreenState();
}

class _CommitteeMemberListScreenState
    extends ConsumerState<CommitteeMemberListScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String module = 'associations';
    final committeeMembersAsync = ref.watch(
      committeeMemberListControllerProvider(widget.pyAssociationId),
    );
    final filteredCommitteeMembers = ref.watch(
      filteredCommitteeMembersProvider(
        widget.pyAssociationId,
        _searchController.text,
      ),
    );
    final canDelete = ref
        .watch(authControllerProvider.notifier)
        .canDelete(module);

    return committeeMembersAsync.when(
      data: (committeeMembers) => Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            committeeMembers.isEmpty
                ? ListTitle(
                    module: module,
                    subTitle: 'No Committee members',
                    title: 'Committee Members',
                    onCreatePressed: onCreatePressed,
                  )
                : ListTitle(
                    module: module,
                    subTitle:
                        'Showing ${filteredCommitteeMembers.length} of ${committeeMembers.length} committee members',
                    title: 'Committee Members',
                    onCreatePressed: onCreatePressed,
                  ),
            const SizedBox(height: 10),
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
                  hintText: 'Search Committee Members ...',
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
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: filteredCommitteeMembers.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final member = filteredCommitteeMembers[index];
                  return Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      splashColor: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(12),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommitteeMemberInfoScreen(
                            pyAssociationId: widget.pyAssociationId,
                            committeeMemberInfo: member,
                          ),
                        ),
                      ),
                      onLongPress: !canDelete
                          ? null
                          : () {
                              showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete Committee Member'),
                                  content: const Text(
                                    'Are you sure you want to remove this member from committee?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await ref
                                            .read(
                                              committeeMemberInfoControllerProvider(
                                                widget.pyAssociationId,
                                                member.id ?? '',
                                              ).notifier,
                                            )
                                            .deleteCommitteeMember(
                                              widget.pyAssociationId,
                                              member.id ?? '',
                                            );
                                        ref.invalidate(
                                          committeeMemberListControllerProvider,
                                        );
                                        if (!context.mounted) return;
                                        showAppSnackBar(
                                          context,
                                          'Member moved from committee',
                                          SnackBarType.success,
                                        );
                                        Navigator.of(context).pop(true);
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
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(0, 0, 0, 0.04),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      member.name ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Contact : ${member.contact}',
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Email : ${member.email}',
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Divider(height: 1, color: Colors.grey),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            StatusTag(
                                              status: 'default',
                                              child: Text(
                                                member.designation ?? '',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error loading ceremonies')),
    );
  }

  void onCreatePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommitteeMemberInfoScreen(
          pyAssociationId: widget.pyAssociationId,
          committeeMemberInfo: CommitteeMemberInfo(),
        ),
      ),
    );
  }
}
