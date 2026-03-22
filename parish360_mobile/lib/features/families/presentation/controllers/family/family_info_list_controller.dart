import 'package:parish360_mobile/features/auth/data/providers/auth_providers.dart';
import 'package:parish360_mobile/features/families/data/providers/families_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/family_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_info_list_controller.g.dart';

@riverpod
class FamilyInfoListController extends _$FamilyInfoListController {
  @override
  Future<List<FamilyInfo>> build() async {
    final parishId = ref.watch(parishProvider);

    if (parishId == '') {
      throw Exception('Waiting for parish initialization');
    }

    return ref
        .read(familyInfoRepositoryProvider)
        .getAllFamilies();
  }

  /// Optional: manual refresh
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref
          .read(familyInfoRepositoryProvider)
          .getAllFamilies();
    });
  }
}
