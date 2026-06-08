import 'package:parish360_mobile/features/parish-year/data/providers/parish_year_providers.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/py_association_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'py_association_list_controller.g.dart';

@riverpod
class PyAssociationListController extends _$PyAssociationListController {
  @override
  Future<List<PyAssociationResponse>> build(String parishYearId) async {
    return await ref
        .read(parishYearRepositoryProvider)
        .getParishYearAssociations(parishYearId);
  }
}

@riverpod
List<PyAssociationResponse> filteredpyAssociations(
  Ref ref,
  String parishYearId,
  String filter,
) {
  final pyAssociationsAsync = ref.watch(
    pyAssociationListControllerProvider(parishYearId),
  );

  return pyAssociationsAsync.when(
    data: (pyAssociations) {
      final lowerFilter = filter.toLowerCase();

      return pyAssociations.where((pyAssociation) {
        final name = pyAssociation.association?.name?.toLowerCase() ?? '';
        final type = pyAssociation.association?.type?.toLowerCase() ?? '';
        final scope = pyAssociation.association?.scope?.toLowerCase() ?? '';

        return name.contains(lowerFilter) ||
            type.contains(lowerFilter) ||
            scope.contains(lowerFilter);
      }).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
}
