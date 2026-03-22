import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/families/data/datasources/families_api.dart';
import 'package:parish360_mobile/features/families/data/repositories/family_info_repository_impl.dart';
import 'package:parish360_mobile/features/families/domain/entities/family_info.dart';
import 'package:parish360_mobile/features/families/domain/repositories/family_info_repository.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/family/family_info_list_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'families_providers.g.dart';

@riverpod
FamiliesApi familiesApi(Ref ref) {
  return FamiliesApi(ref.watch(dioProvider));
}

@riverpod
FamilyInfoRepository familyInfoRepository(Ref ref) {
  return FamilyInfoRepositoryImpl(ref.watch(familiesApiProvider));
}

@riverpod
class FamilySearchQuery extends _$FamilySearchQuery {
  @override
  String build() => '';

  void update(String value) => state = value;
}

@riverpod
List<FamilyInfo> filteredFamilyInfoList(Ref ref, String filter) {
  final familiesAsync = ref.watch(familyInfoListControllerProvider);

  return familiesAsync.when(
    data: (families) {
      final lowerFilter = filter.toLowerCase();

      return families.where((family) {
        final familyCode = family.familyCode?.toLowerCase() ?? '';
        final familyName = family.familyName?.toLowerCase() ?? '';
        final contact = family.contact?.toLowerCase() ?? '';
        final address = family.address?.toLowerCase() ?? '';

        return familyCode.contains(lowerFilter) ||
            familyName.contains(lowerFilter) ||
            contact.contains(lowerFilter) ||
            address.contains(lowerFilter);
      }).toList();
    },
    loading: () => [],
    error: (_,_) => [],
  );
}
