import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/families/domain/entities/migration_info.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/migration_list_controller.dart';
import 'package:parish360_mobile/features/families/presentation/pages/migration_info_screen.dart';

class MigrationsScreen extends ConsumerStatefulWidget {
  final String familyId;
  final String memberId;

  const MigrationsScreen({
    super.key,
    required this.familyId,
    required this.memberId,
  });

  @override
  ConsumerState<MigrationsScreen> createState() => _MigrationsScreenState();
}

class _MigrationsScreenState extends ConsumerState<MigrationsScreen> {
  bool _draftMigrationExists = false;
  final MigrationInfo _draftMigration = MigrationInfo();

  void _addDraftMigration() {
    setState(() {
      _draftMigrationExists = true;
    });
  }

  void _removeDraftMigration(MigrationInfo migration) {
    setState(() {
      _draftMigrationExists = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final migrations = ref.watch(
      migrationListControllerProvider(widget.familyId, widget.memberId),
    );

    return migrations.when(
      data: (data) => SingleChildScrollView(
        child: Column(
          children: [
            ...data.map(
              (migration) => MigrationInfoScreen(
                familyId: widget.familyId,
                memberId: widget.memberId,
                migration: migration,
              ),
            ),
            if (_draftMigrationExists)
              MigrationInfoScreen(
                familyId: widget.familyId,
                memberId: widget.memberId,
                migration: _draftMigration,
                onSaved: () => _removeDraftMigration(_draftMigration),
              ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _addDraftMigration,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                  ),
                  child: const Text('Add Migration'),
                ),
              ),
            ),
          ],
        ),
      ),
      error: (error, stack) =>
          Center(child: Text('Error loading migrations: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
