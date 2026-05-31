import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/entities/god_parent.dart';
import 'package:parish360_mobile/core/common/entities/place.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
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

  final formKey = GlobalKey<FormState>();
  final memberFormControllers = MemberFormControllers();

  bool get _canCreate =>
      ref.read(authControllerProvider.notifier).canCreate('family-records');
  bool get _canEdit =>
      ref.read(authControllerProvider.notifier).canEdit('family-records');

  @override
  void dispose() {
    memberFormControllers.dispose();
    super.dispose();
  }

  Future<void> _saveMemberInfo(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final messenger = ScaffoldMessenger.of(context);

    // create MemberInfo
    MemberInfo memberInfo = MemberInfo(
      firstName: memberFormControllers.firstNameController.text.trim(),
      lastName: memberFormControllers.lastNameController.text.trim(),
      baptismName: memberFormControllers.baptismNameController.text.trim(),
      email: memberFormControllers.emailController.text.trim(),
      contact: memberFormControllers.contactController.text.trim(),
      father: memberFormControllers.fatherController.text.trim(),
      mother: memberFormControllers.motherController.text.trim(),
      dob: memberFormControllers.dobController.text.trim().isNotEmpty
          ? DateTime.parse(memberFormControllers.dobController.text.trim())
          : null,
      relationship: memberFormControllers.relationshipController.text.trim(),
      gender: memberFormControllers.genderController.text.trim(),
      maritalStatus: memberFormControllers.maritalStatusController.text.trim(),
      qualification: memberFormControllers.qualificationController.text.trim(),
      occupation: memberFormControllers.occupationController.text.trim(),
      birthPlace: Place(
        city: memberFormControllers.birthPlaceCityController.text.trim(),
        state: memberFormControllers.birthPlaceStateController.text.trim(),
        country: memberFormControllers.birthPlaceCountryController.text.trim(),
      ),
      godFather: GodParent(
        name: memberFormControllers.godFatherNameController.text.trim(),
        baptismName: memberFormControllers.godFatherBaptismNameController.text
            .trim(),
        parish: memberFormControllers.godFatherParishController.text.trim(),
        contact: memberFormControllers.godFatherContactController.text.trim(),
      ),
      godMother: GodParent(
        name: memberFormControllers.godMotherNameController.text.trim(),
        baptismName: memberFormControllers.godMotherBaptismNameController.text
            .trim(),
        parish: memberFormControllers.godMotherParishController.text.trim(),
        contact: memberFormControllers.godMotherContactController.text.trim(),
      ),
    );

    try {
      if (widget.memberId == 'new') {
        await ref
            .read(memberInfoControllerProvider(widget.familyId, '').notifier)
            .createMember(widget.familyId, memberInfo);
      } else {
        await ref
            .read(
              memberInfoControllerProvider(
                widget.familyId,
                widget.memberId,
              ).notifier,
            )
            .updateMember(widget.familyId, widget.memberId, memberInfo);
      }
      if (!mounted) return;

      setState(() {
        isEditing = false;
      });

      messenger.showSnackBar(
        widget.memberId == 'new'
            ? SnackBar(content: Text('Member info created successfully'))
            : SnackBar(content: Text('Member info updated successfully')),
      );
      if (widget.memberId == 'new') {
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
    });
  }

  void initializeMemberFormControllers(MemberInfo initialMemberInfo) {
    memberFormControllers.firstNameController.value = TextEditingValue(
      text: initialMemberInfo.firstName ?? '',
    );
    memberFormControllers.lastNameController.value = TextEditingValue(
      text: initialMemberInfo.lastName ?? '',
    );
    memberFormControllers.baptismNameController.value = TextEditingValue(
      text: initialMemberInfo.baptismName ?? '',
    );
    memberFormControllers.contactController.value = TextEditingValue(
      text: initialMemberInfo.contact ?? '',
    );
    memberFormControllers.dobController.value = TextEditingValue(
      text: initialMemberInfo.dob != null
          ? '${initialMemberInfo.dob?.year}-${initialMemberInfo.dob?.month.toString().padLeft(2, '0')}-${initialMemberInfo.dob?.day.toString().padLeft(2, '0')}'
          : '',
    );
    memberFormControllers.emailController.value = TextEditingValue(
      text: initialMemberInfo.email ?? '',
    );
    memberFormControllers.fatherController.value = TextEditingValue(
      text: initialMemberInfo.father ?? '',
    );
    memberFormControllers.motherController.value = TextEditingValue(
      text: initialMemberInfo.mother ?? '',
    );
    memberFormControllers.relationshipController.value = TextEditingValue(
      text: initialMemberInfo.relationship ?? '',
    );
    memberFormControllers.genderController.value = TextEditingValue(
      text: initialMemberInfo.gender ?? '',
    );
    memberFormControllers.maritalStatusController.value = TextEditingValue(
      text: initialMemberInfo.maritalStatus ?? '',
    );
    memberFormControllers.qualificationController.value = TextEditingValue(
      text: initialMemberInfo.qualification ?? '',
    );
    memberFormControllers.occupationController.value = TextEditingValue(
      text: initialMemberInfo.occupation ?? '',
    );

    // birth place initialisation
    memberFormControllers.birthPlaceCityController.value = TextEditingValue(
      text: initialMemberInfo.birthPlace?.city ?? '',
    );
    memberFormControllers.birthPlaceStateController.value = TextEditingValue(
      text: initialMemberInfo.birthPlace?.state ?? '',
    );
    memberFormControllers.birthPlaceCountryController.value = TextEditingValue(
      text: initialMemberInfo.birthPlace?.country ?? '',
    );

    // God father details initialisation
    memberFormControllers.godFatherNameController.value = TextEditingValue(
      text: initialMemberInfo.godFather?.name ?? '',
    );
    memberFormControllers.godFatherBaptismNameController.value =
        TextEditingValue(text: initialMemberInfo.godFather?.baptismName ?? '');
    memberFormControllers.godFatherContactController.value = TextEditingValue(
      text: initialMemberInfo.godFather?.contact ?? '',
    );
    memberFormControllers.godFatherParishController.value = TextEditingValue(
      text: initialMemberInfo.godFather?.parish ?? '',
    );

    // God Mother details initialisation
    memberFormControllers.godMotherNameController.value = TextEditingValue(
      text: initialMemberInfo.godMother?.name ?? '',
    );
    memberFormControllers.godMotherBaptismNameController.value =
        TextEditingValue(text: initialMemberInfo.godMother?.baptismName ?? '');
    memberFormControllers.godMotherContactController.value = TextEditingValue(
      text: initialMemberInfo.godMother?.contact ?? '',
    );
    memberFormControllers.godMotherParishController.value = TextEditingValue(
      text: initialMemberInfo.godMother?.parish ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    bool showEditAction = !isEditing;
    bool showSaveAction = isEditing;
    bool showCancelAction = isEditing;

    // Handle the case for new member creation
    if (widget.memberId == 'new' && _canCreate) {
      currentTab = 'info';
      _toggleEditing(); // Start in editing mode for new member
      initializeMemberFormControllers(MemberInfo());
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
        body: Form(
          key: formKey,
          child: MemberInfoScreen(
            isEditing: isEditing,
            controllers: memberFormControllers,
          ),
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
          initializeMemberFormControllers(info);
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
            actions: currentTab != 'info' || !_canEdit
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
            'info' => Form(
              key: formKey,
              child: MemberInfoScreen(
                isEditing: isEditing,
                controllers: memberFormControllers,
              ),
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
