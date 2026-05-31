import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/families/data/providers/families_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/family_info.dart';
import 'package:parish360_mobile/core/app/app_navigator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_info_list_controller.g.dart';

@riverpod
class FamilyInfoListController extends _$FamilyInfoListController {
  @override
  Future<List<FamilyInfo>> build() async {
    try {
      return await ref.read(familyInfoRepositoryProvider).getAllFamilies();
    } catch (e, _) {
      if (e is DioException && e.response?.statusCode == 401) {
        await ref.read(authControllerProvider.notifier).logout();
        AppNavigator.popAllAndPush('/login');
        rethrow;
      }
      rethrow;
    }
  }

  /// Optional: manual refresh
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(familyInfoRepositoryProvider).getAllFamilies();
    });
  }
}
