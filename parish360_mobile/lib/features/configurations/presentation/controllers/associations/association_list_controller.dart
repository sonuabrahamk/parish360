import 'package:parish360_mobile/features/configurations/data/providers/associations_providers.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/association_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'association_list_controller.g.dart';

@riverpod
class AssociationListController extends _$AssociationListController {
  @override
  Future<List<AssociationInfo>> build() async {
    return await ref.read(associationRepositoryProvider).getAllAssociations();
  }
}

@riverpod
List<AssociationInfo> filteredAssociationsInfoList(Ref ref, String filter) {
  final associationsListAsync = ref.watch(associationListControllerProvider);

  return associationsListAsync.when(
    data: (associations) {
      final lowerFilter = filter.toLowerCase();

      return associations.where((association) {
        final name = association.name?.toLowerCase() ?? '';
        final type = association.type?.toLowerCase() ?? '';
        final scope = association.scope?.toLowerCase() ?? '';

        return name.contains(lowerFilter) ||
            type.contains(lowerFilter) ||
            scope.contains(lowerFilter);
      }).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
}

@riverpod
class AssociationSearchQuery extends _$AssociationSearchQuery {
  @override
  String build() => '';

  void update(String value) => state = value;
}
