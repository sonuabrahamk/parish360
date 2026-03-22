import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/member_info_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    final memberInfo = ref.watch(
      memberInfoControllerProvider(widget.familyId, widget.memberId),
    );

    return memberInfo.when(
      data: (info) {
        if (!initialized) {
          // Initialize any controllers or state here using the member info
          initialized = true;
          currentTab = 'info';
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: Container(
                color: Theme.of(context).primaryColor,
                height: 1.0,
              ),
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
            actions: [
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert, 
                  color: Theme.of(context).primaryColor
                ),
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      setState(() {
                        isEditing = !isEditing;
                      });
                      break;
                    case 'save':
                      break;
                    case 'cancel':
                      setState(() {
                        isEditing = !isEditing;
                      });
                      break;
                  }
                },
                itemBuilder: (context) => [
                  if (!isEditing)
                    const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  if (isEditing)
                    const PopupMenuItem(value: 'save', child: Text('Save')),
                  if (isEditing)
                    const PopupMenuItem(value: 'cancel', child: Text('Cancel')),
                ],
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
                    tileColor: currentTab == 'info' ? Theme.of(context).primaryColor : Colors.white,
                    textColor: currentTab == 'info' ? Colors.white : Theme.of(context).primaryColor,
                    onTap: () {
                      setState(() {
                        currentTab = 'info';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Sacrament Info'),
                    tileColor: currentTab == 'sacrament' ? Theme.of(context).primaryColor : Colors.white,
                    textColor: currentTab == 'sacrament' ? Colors.white : Theme.of(context).primaryColor,
                    onTap: () {
                      setState(() {
                        currentTab = 'sacrament';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Migration Info'),
                    tileColor: currentTab == 'migration' ? Theme.of(context).primaryColor : Colors.white,
                    textColor: currentTab == 'migration' ? Colors.white : Theme.of(context).primaryColor,
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
            }),
          ),
          body: switch (currentTab) {
            'info' => Center(child: Text('Personal Info for ${info.firstName}')),
            'sacrament' => Center(child: Text('Sacrament Info for ${info.firstName}')),
            'migration' => Center(child: Text('Migration Info for ${info.firstName}')),
            _ => Center(child: Text('Personal Info for ${info.firstName}')),
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error loading member info')),
    );
  }
}
