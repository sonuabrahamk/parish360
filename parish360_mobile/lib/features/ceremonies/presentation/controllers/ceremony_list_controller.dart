import 'package:parish360_mobile/features/ceremonies/data/providers/ceremony_providers.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/ceremony_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ceremony_list_controller.g.dart';

@riverpod
class CeremonyListController extends _$CeremonyListController {
  @override
  Future<List<CeremonyInfo>> build() async {
    return await ref.read(ceremoniesRepositoryProvider).getCeremonies();
  }
}

@riverpod
List<CeremonyInfo> filteredCeremonies(Ref ref, String filter) {
  final ceremoniesListAsync = ref.watch(ceremonyListControllerProvider);

  return ceremoniesListAsync.when(
    data: (ceremonies) {
      final lowerFilter = filter.toLowerCase();

      return ceremonies.where((ceremony) {
        final type = ceremony.type?.toLowerCase() ?? '';
        final date = ceremony.date?.toString().toLowerCase() ?? '';
        final name = ceremony.name?.toLowerCase() ?? '';
        final baptismName = ceremony.baptismName?.toLowerCase() ?? '';
        final father = ceremony.father?.toLowerCase() ?? '';
        final mother = ceremony.mother?.toLowerCase() ?? '';
        final remarks = ceremony.remarks?.toLowerCase() ?? '';
        final contact = ceremony.contact?.toLowerCase() ?? '';
        final address = ceremony.address?.toLowerCase() ?? '';

        return type.contains(lowerFilter) ||
            date.contains(lowerFilter) ||
            name.contains(lowerFilter) ||
            baptismName.contains(lowerFilter) ||
            father.contains(lowerFilter) ||
            mother.contains(lowerFilter) ||
            remarks.contains(lowerFilter) ||
            contact.contains(lowerFilter) ||
            address.contains(lowerFilter);
      }).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
}
