import 'package:parish360_mobile/features/bookings/data/providers/service_intention_providers.dart';
import 'package:parish360_mobile/features/bookings/domain/entities/service_intention_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_intention_list_controller.g.dart';

@riverpod
class ServiceIntentionListController extends _$ServiceIntentionListController {
  @override
  Future<List<ServiceIntentionInfo>> build() async {
    return await ref
        .read(serviceIntentionRepositoryProvider)
        .getServiceIntentions();
  }
}

@riverpod
List<ServiceIntentionInfo> filteredServiceIntentionsList(
  Ref ref,
  String filter,
) {
  final serviceIntentionsAsync = ref.watch(
    serviceIntentionListControllerProvider,
  );

  return serviceIntentionsAsync.when(
    data: (serviceIntentions) {
      final lowerFilter = filter.toLowerCase();

      return serviceIntentions.where((serviceIntention) {
        final bookedBy = serviceIntention.bookedBy?.toLowerCase() ?? '';
        final familyCode = serviceIntention.familyCode?.toLowerCase() ?? '';
        final event = serviceIntention.event?.toLowerCase() ?? '';
        final intention = serviceIntention.intention?.toLowerCase() ?? '';
        final status = serviceIntention.status?.toLowerCase() ?? '';

        return bookedBy.contains(lowerFilter) ||
            familyCode.contains(lowerFilter) ||
            event.contains(lowerFilter) ||
            intention.contains(lowerFilter) ||
            status.contains(lowerFilter);
      }).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
}

@riverpod
class ServiceIntentionSearchQuery extends _$ServiceIntentionSearchQuery {
  @override
  String build() => '';

  void update(String value) => state = value;
}
