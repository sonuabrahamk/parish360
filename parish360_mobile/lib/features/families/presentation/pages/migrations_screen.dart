import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
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

  bool get _canCreate =>
      ref.read(authControllerProvider.notifier).canCreate('family-records');

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
      data: (data) => SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Migrations',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${data.length} migration(s)',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                    _canCreate
                        ? IconButton(
                            onPressed: _addDraftMigration,
                            icon: const Icon(Icons.add, color: Colors.white),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: data.length + (_draftMigrationExists ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < data.length) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: MigrationInfoScreen(
                          familyId: widget.familyId,
                          memberId: widget.memberId,
                          migration: data[index],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: MigrationInfoScreen(
                          familyId: widget.familyId,
                          memberId: widget.memberId,
                          migration: _draftMigration,
                          onSaved: () => _removeDraftMigration(_draftMigration),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      error: (error, stack) =>
          Center(child: Text('Error loading migrations: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
