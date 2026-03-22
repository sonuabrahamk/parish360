import 'package:parish360_mobile/features/families/data/providers/families_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/family_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_info_controller.g.dart';

@riverpod
class FamilyInfoController extends _$FamilyInfoController {

  @override
  Future<FamilyInfo> build (String familyId) async {
    return ref.read(familyInfoRepositoryProvider).getFamilyById(familyId);
  }

  Future<FamilyInfo> createFamily(FamilyInfo familyInfo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(familyInfoRepositoryProvider).createFamily(familyInfo);
    });
    return state.value!;
  }

  Future<FamilyInfo> getFamilyById(String familyId) async {
    try {
      final response =
          await ref.read(familyInfoRepositoryProvider).getFamilyById(familyId);
      state = AsyncValue.data(response);
      return response;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<FamilyInfo> updateFamily(String familyId, FamilyInfo familyInfo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(familyInfoRepositoryProvider).updateFamily(familyId, familyInfo);
    });
    return state.value!;
  }

}