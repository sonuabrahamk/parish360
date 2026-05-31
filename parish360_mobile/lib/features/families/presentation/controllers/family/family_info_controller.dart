import 'package:dio/dio.dart';
import 'package:parish360_mobile/core/app/app_navigator.dart';
import 'package:parish360_mobile/core/error/api_exception.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/families/data/providers/families_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/family_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_info_controller.g.dart';

@riverpod
class FamilyInfoController extends _$FamilyInfoController {

  @override
  Future<FamilyInfo> build (String familyId) async {
    try {
      return await ref.read(familyInfoRepositoryProvider).getFamilyById(familyId);
    } catch (e) {
      if(e is DioException && e.response?.statusCode == 401) {
        // Handle unauthorized error, e.g., by logging out the user
        await ref.read(authControllerProvider.notifier).logout();
        AppNavigator.popAllAndPush('/login');
        rethrow;
      } else {
        throw ApiException.fromDio(e as DioException); // Convert DioException to ApiException for better error handling
      }
    }
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
      if(e is DioException && e.response?.statusCode == 401) {
        // Handle unauthorized error, e.g., by logging out the user
        await ref.read(authControllerProvider.notifier).logout();
        AppNavigator.popAllAndPush('/login');
        rethrow;
      } 
      if(e is DioException) {
        // Handle unauthorized error, e.g., by logging out the user
        state = AsyncValue.error(e.response?.data['message'] ?? 'Unknown error', st);
        rethrow;
      } 
      state = AsyncValue.error('Unknown error', st);
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