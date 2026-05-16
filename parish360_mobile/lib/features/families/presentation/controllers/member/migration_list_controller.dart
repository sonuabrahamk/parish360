import 'package:parish360_mobile/features/families/data/providers/migration_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/migration_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'migration_list_controller.g.dart';

@riverpod
class MigrationListController extends _$MigrationListController {
  
  @override
  Future<List<MigrationInfo>> build(String familyId, String memberId) async {
    return ref.read(migrationRepositoryProvider).getMigrations(familyId, memberId);
  }

}