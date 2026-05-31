import 'package:flutter/material.dart';
import 'package:parish360_mobile/core/network/cookie_jar_provider.dart';
import 'package:parish360_mobile/features/auth/domain/entities/login_request.dart';
import 'package:parish360_mobile/features/auth/domain/entities/login_response.dart';
import 'package:parish360_mobile/features/auth/domain/entities/module_info.dart';
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
    ref.invalidateSelf();
  }

  bool get isLoggedIn {
    final token = state.value?.accessToken;
    return token != null && token.isNotEmpty;
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

  String getDefaultParish () {
    final permissions = state.value?.permissions;
    if (permissions == null) return '';
    return permissions.dataOwner.parish.isNotEmpty
        ? permissions.dataOwner.parish.first
        : '';
  }

  List<ModuleInfo> getAllowedModules() {
    final permissions = state.value?.permissions;
    if (permissions == null) return [];
    return _getModuleInfo(permissions.modules.view);
  }

  List<ModuleInfo> _getModuleInfo(List<String> allowedModules) {
    if (allowedModules.isEmpty) return [];

    List<ModuleInfo> modulesInfoList = [];

    for (var module in allowedModules) {
      switch (module) {
        case 'dashboard':
          modulesInfoList.add(
            ModuleInfo(
              label: 'Dashboard',
              icon: Icons.dashboard,
              route: '/dashboard',
              badgeCount: 1,
            ),
          );
          break;
        case "family-records":
          modulesInfoList.add(
            ModuleInfo(
              label: "Families",
              icon: Icons.verified_user_sharp,
              route: '/families',
              badgeCount: 2,
            ),
          );
          break;
        case "associations":
          modulesInfoList.add(
            ModuleInfo(
              label: "Associations",
              icon: Icons.person,
              route: '/dashboard',
              badgeCount: 5,
            ),
          );
          break;
        case "ceremonies":
          modulesInfoList.add(
            ModuleInfo(
              label: "Ceremonies",
              icon: Icons.person,
              route: '/dashboard',
              badgeCount: 6,
            ),
          );
          break;
        case "configurations":
          modulesInfoList.add(
            ModuleInfo(
              label: "Configurations",
              icon: Icons.settings,
              route: '/dashboard',
              badgeCount: 8,
            ),
          );
          break;
        case "payments":
          modulesInfoList.add(
            ModuleInfo(
              label: "Payments",
              icon: Icons.payment,
              route: '/dashboard',
              badgeCount: 4,
            ),
          );
          break;
        case "bookings":
          modulesInfoList.add(
            ModuleInfo(
              label: "Bookings",
              icon: Icons.person,
              route: '/dashboard',
              badgeCount: 3,
            ),
          );
          break;
        case "users":
          modulesInfoList.add(
            ModuleInfo(
              label: "Users",
              icon: Icons.person,
              route: '/dashboard',
              badgeCount: 9,
            ),
          );
          break;
        case "expenses":
          modulesInfoList.add(
            ModuleInfo(
              label: "Expenses",
              icon: Icons.person,
              route: '/dashboard',
              badgeCount: 7,
            ),
          );
          break;
        // Add more modules as needed
        default:
          break;
      }
    }

    modulesInfoList.sort((a,b){
      final aCount = a.badgeCount ?? double.infinity;
      final bCount = b.badgeCount ?? double.infinity;
      return aCount.compareTo(bCount);
    });

    return modulesInfoList;
  }
}
