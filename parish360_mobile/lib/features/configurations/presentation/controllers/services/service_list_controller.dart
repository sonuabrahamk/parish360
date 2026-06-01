import 'package:parish360_mobile/features/configurations/data/providers/services_providers.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/service_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_list_controller.g.dart';

@riverpod
class ServiceListController extends _$ServiceListController {
  @override
  Future<List<ServiceInfo>> build() async {
    return await ref.read(serviceRepositoryProvider).getAllServices();
  }
}

@riverpod
List<ServiceInfo> filteredServicesInfoList(Ref ref, String filter) {
  final servicesListAsync = ref.watch(serviceListControllerProvider);
  return servicesListAsync.when(
    data: (services) {
      final lowerFilter = filter.toLowerCase();

      return services.where((service) {
        final name = service.name?.toLowerCase() ?? '';
        final type = service.type?.toLowerCase() ?? '';
        final date = service.date?.toString().toLowerCase() ?? '';

        return name.contains(lowerFilter) ||
            type.contains(lowerFilter) ||
            date.toString().contains(lowerFilter);
      }).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
}

@riverpod
class ServiceSearchQuery extends _$ServiceSearchQuery {
  @override
  String build() => '';

  void update(String value) => state = value;
}
