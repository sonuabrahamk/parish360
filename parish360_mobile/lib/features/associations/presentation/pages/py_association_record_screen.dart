import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/associations/presentation/pages/associate_list_screen.dart';
import 'package:parish360_mobile/features/associations/presentation/pages/associate_mapping_screen.dart';
import 'package:parish360_mobile/features/associations/presentation/pages/committee_member_list_screen.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/py_association_response.dart';

class PyAssociationRecordScreen extends ConsumerWidget {
  final PyAssociationResponse pyAssociationResponse;

  const PyAssociationRecordScreen({
    super.key,
    required this.pyAssociationResponse,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pyAssociationResponse.association?.name ?? 'Asssociation Info',
        ),
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppTheme.primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            isScrollable: false,
            tabAlignment: TabAlignment.fill,
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.workspace_premium, size: 18),
                    SizedBox(width: 2),
                    Text('Committee', softWrap: true,),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.groups, size: 18),
                    SizedBox(width: 8),
                    Text('Associates'),
                  ],
                ),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              CommitteeMemberListScreen(
                pyAssociationId: pyAssociationResponse.id!,
              ),
              Stack(
                children: [
                  AssociateListScreen(
                    pyAssociationId: pyAssociationResponse.id!,
                    associationType: pyAssociationResponse.association!.type!,
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: FloatingActionButton.extended(
                      backgroundColor: AppTheme.primaryColor,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssociateMappingScreen(
                              pyAssociationId: pyAssociationResponse.id!,
                              associationType:
                                  pyAssociationResponse.association!.type!,
                            ),
                          ),
                        );
                      },
                      label: const Icon(Icons.edit_note),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
