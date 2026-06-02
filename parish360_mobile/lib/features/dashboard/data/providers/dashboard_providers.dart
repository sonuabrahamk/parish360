import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/dashboard/data/datasources/dashboard_api.dart';
import 'package:parish360_mobile/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:parish360_mobile/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_providers.g.dart';

@riverpod
DashboardApi dashboardApi(Ref ref) {
  return DashboardApi(ref.watch(dioProvider));
}

@riverpod
DashboardRepository dashboardRepository(Ref ref) {
  return DashboardRepositoryImpl(ref.watch(dashboardApiProvider));
}