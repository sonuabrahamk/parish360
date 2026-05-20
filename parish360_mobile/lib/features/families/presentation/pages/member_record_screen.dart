import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/member_info_controller.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/member_list_controller.dart';
import 'package:parish360_mobile/features/families/presentation/pages/member_info_screen.dart';
import 'package:parish360_mobile/features/families/presentation/pages/migrations_screen.dart';
import 'package:parish360_mobile/features/families/presentation/pages/sacraments_screen.dart';

class MemberRecordScreen extends ConsumerStatefulWidget {
  final String familyId;
  final String memberId;

  const MemberRecordScreen({
    super.key,
    required this.familyId,
    required this.memberId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MemberRecordScreenState();
}

class _MemberRecordScreenState extends ConsumerState<MemberRecordScreen> {
  bool isEditing = false;
  bool initialized = false;
  String currentTab = 'info';
  MemberInfo? editedInfo;

  Future<void> _saveMemberInfo(BuildContext context) async {
    if (editedInfo == null) return;

    final messenger = ScaffoldMessenger.of(context);

    try {
      if (editedInfo?.id == 'new') {
        // Strip out the 'new' id when creating
        final memberToCreate = MemberInfo(
          id: null,
          firstName: editedInfo?.firstName,
          contact: editedInfo?.contact,
          contactVerified: editedInfo?.contactVerified,
          dob: editedInfo?.dob,
          father: editedInfo?.father,
          mother: editedInfo?.mother,
          relationship: editedInfo?.relationship,
          createdAt: editedInfo?.createdAt,
          createdBy: editedInfo?.createdBy,
          updatedAt: editedInfo?.updatedAt,
        );
        await ref
            .read(memberInfoControllerProvider(widget.familyId, '').notifier)
            .createMember(widget.familyId, memberToCreate);
      } else {
        await ref
            .read(
              memberInfoControllerProvider(
                widget.familyId,
                widget.memberId,
              ).notifier,
            )
            .updateMember(widget.familyId, widget.memberId, editedInfo!);
      }
      if (!mounted) return;
      setState(() {
        isEditing = false;
      });
      messenger.showSnackBar(
        editedInfo?.id == 'new'
            ? SnackBar(content: Text('Member info created successfully'))
            : SnackBar(content: Text('Member info updated successfully')),
      );
      if (editedInfo?.id == 'new') {
        // Invalidate the member list to show the new member
        ref.invalidate(memberListControllerProvider(widget.familyId));
      } else {
        // Invalidate the member info to show the updated info
        ref.invalidate(
          memberInfoControllerProvider(widget.familyId, widget.memberId),
        );
      }
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Failed to save member info: $e')),
      );
    }
  }

  void _toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        editedInfo = null; // Discard changes when exiting edit mode
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showEditAction = !isEditing;
    bool showSaveAction = isEditing;
    bool showCancelAction = isEditing;

    // Handle the case for new member creation
    if (widget.memberId == 'new') {
      currentTab = 'info';
      _toggleEditing(); // Start in editing mode for new member
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1, thickness: 1),
          ),
          title: Text(
            'Create New Member',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          actions: currentTab != 'info'
              ? null
              : [
                  IconButton(
                    icon: Icon(Icons.check, color: AppTheme.primaryColor),
                    onPressed: () => _saveMemberInfo(context),
                    tooltip: 'Save',
                  ),
                ],
        ),
        body: MemberInfoScreen(
          familyId: widget.familyId,
          memberId: widget.memberId,
          isEditing: isEditing,
          memberInfo: MemberInfo(id: 'new', firstName: ''),
          onInfoChanged: (newInfo) {
            editedInfo = newInfo;
          },
        ),
      );
    }

    // For existing members, load the info as usual
    final memberInfo = ref.watch(
      memberInfoControllerProvider(widget.familyId, widget.memberId),
    );

    return memberInfo.when(
      data: (info) {
        if (!initialized) {
          // Initialize any controllers or state here using the member info
          initialized = true;
          currentTab = 'info';
          editedInfo = info;
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Colors.transparent,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1, thickness: 1),
            ),
            title: Text(
              switch (currentTab) {
                'info' => 'Personal Info',
                'sacrament' => 'Sacrament Info',
                'migration' => 'Migration Info',
                _ => 'Personal Info',
              },
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                color: Theme.of(context).primaryColor,
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            actions: currentTab != 'info'
                ? null
                : [
                    if (showEditAction)
                      IconButton(
                        icon: Icon(Icons.edit, color: AppTheme.primaryColor),
                        onPressed: _toggleEditing,
                        tooltip: 'Edit',
                      ),
                    if (showSaveAction)
                      IconButton(
                        icon: Icon(Icons.check, color: AppTheme.primaryColor),
                        onPressed: () => _saveMemberInfo(context),
                        tooltip: 'Save',
                      ),
                    if (showCancelAction)
                      IconButton(
                        icon: Icon(Icons.close, color: AppTheme.primaryColor),
                        onPressed: _toggleEditing,
                        tooltip: 'Cancel',
                      ),
                  ],
          ),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text('Personal Info'),
                      tileColor: currentTab == 'info'
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      textColor: currentTab == 'info'
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      onTap: () {
                        setState(() {
                          currentTab = 'info';
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Sacrament Info'),
                      tileColor: currentTab == 'sacrament'
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      textColor: currentTab == 'sacrament'
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      onTap: () {
                        setState(() {
                          currentTab = 'sacrament';
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Migration Info'),
                      tileColor: currentTab == 'migration'
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      textColor: currentTab == 'migration'
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      onTap: () {
                        setState(() {
                          currentTab = 'migration';
                        });
                        Navigator.pop(context);
                      },
                    ),
                    // Add drawer items here
                  ],
                );
              },
            ),
          ),
          body: switch (currentTab) {
            'info' => MemberInfoScreen(
              familyId: widget.familyId,
              memberId: widget.memberId,
              isEditing: isEditing,
              memberInfo: editedInfo ?? info,
              onInfoChanged: (newInfo) {
                editedInfo = newInfo;
              },
            ),
            'sacrament' => SacramentsScreen(
              familyId: widget.familyId,
              memberId: widget.memberId,
            ),
            'migration' => MigrationsScreen(
              familyId: widget.familyId,
              memberId: widget.memberId,
            ),
            _ => Text('Unknown tab'),
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error loading member info')),
    );
  }
}
