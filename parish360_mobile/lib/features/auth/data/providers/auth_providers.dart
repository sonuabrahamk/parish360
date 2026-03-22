import 'package:flutter/material.dart';
import 'package:parish360_mobile/core/network/auth_dio_provider.dart';
import 'package:parish360_mobile/features/auth/domain/entities/module_info.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../datasources/auth_api.dart';
import '../repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

@riverpod
AuthApi authApi(Ref ref) {
  return AuthApi(ref.watch(authDioProvider));
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(authApiProvider));
}

@riverpod
String parish(Ref ref) {
  // Placeholder implementation; replace with actual logic to fetch parish info
  List<String> parishes = ref
      .watch(authControllerProvider)
      .maybeWhen(
        data: (loginResponse) => loginResponse.permissions.dataOwner.parish,
        orElse: () => [],
      );
  return parishes.isNotEmpty ? parishes.first : '';
}

@riverpod
List<ModuleInfo> modules(Ref ref) {
  // Placeholder implementation; replace with actual logic to fetch modules info
  return ref
      .watch(authControllerProvider)
      .maybeWhen(
        data: (loginResponse) =>
            _getModuleInfo(loginResponse.permissions.modules.view),
        orElse: () => [],
      );
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
            icon: Icons.person,
            route: '/dashboard',
            badgeCount: 8,
          ),
        );
        break;
      case "payments":
        modulesInfoList.add(
          ModuleInfo(
            label: "Payments",
            icon: Icons.person,
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
