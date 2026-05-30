import 'package:parish360_mobile/core/network/cookie_jar_provider.dart';
import 'package:parish360_mobile/features/auth/data/providers/module_index_providers.dart';
import 'package:parish360_mobile/features/auth/domain/entities/login_request.dart';
import 'package:parish360_mobile/features/auth/domain/entities/login_response.dart';
import 'package:parish360_mobile/features/auth/domain/entities/permissions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user.dart';
import '../../data/providers/auth_providers.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AsyncValue<LoginResponse> build() {
    return AsyncValue.data(
      LoginResponse(
        accessToken: '',
        permissions: Permissions(
          dataOwner: DataOwner(diocese: [], parish: [], forane: []),
          modules: Modules(create: [], view: [], edit: [], delete: []),
        ),
        userInfo: User(
          id: '',
          firstName: '',
          lastName: '',
          username: '',
          isActive: false,
        ),
      ),
    );
  }

  Future<LoginResponse> login(LoginRequest request) async {
    state = const AsyncValue.loading();
    try {
      final response = await ref.watch(authRepositoryProvider).login(request);
      state = AsyncValue.data(response);
      return response;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> logout() async {
    await ref.watch(cookieJarProvider).deleteAll();

    ref.invalidate(parishProvider);
    ref.invalidate(modulesProvider);
    ref.invalidate(moduleIndexProvider);

    ref.invalidateSelf();
  }

  bool canCreate(String module) {
    final permissions = state.value?.permissions;
    if (permissions == null) return false;
    return permissions.modules.create.contains(module);
  }

  bool canView(String module) {
    final permissions = state.value?.permissions;
    if (permissions == null) return false;
    return permissions.modules.view.contains(module);
  }

  bool canEdit(String module) {
    final permissions = state.value?.permissions;
    if (permissions == null) return false;
    return permissions.modules.edit.contains(module);
  }

  bool canDelete(String module) {
    final permissions = state.value?.permissions;
    if (permissions == null) return false;
    return permissions.modules.delete.contains(module);
  }
}
