import 'package:parish360_mobile/features/parish-year/data/providers/parish_year_providers.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/parish_year_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parish_year_list_controller.g.dart';

@riverpod
class ParishYearListController extends _$ParishYearListController {
  @override
  Future<List<ParishYearInfo>> build() async {
    return await ref.read(parishYearRepositoryProvider).getParishYearList();
  }
}

@riverpod
List<ParishYearInfo> filteredParishYearList(Ref ref, String filter) {
  final parishYearListAsync = ref.watch(parishYearListControllerProvider);

  return parishYearListAsync.when(
    data: (parishYearList) {
      final lowerFilter = filter.toLowerCase();

      return parishYearList.where((parishYear) {
        final name = parishYear.name?.toLowerCase() ?? '';
        final startDate = parishYear.startDate?.toString().toLowerCase() ?? '';
        final endDate = parishYear.endDate?.toString().toLowerCase() ?? '';
        final status = parishYear.status?.toLowerCase() ?? '';
        final locked = parishYear.locked?.toString().toLowerCase() ?? '';
        final comment = parishYear.comment?.toLowerCase() ?? '';

        return name.contains(lowerFilter) ||
            startDate.contains(lowerFilter) ||
            endDate.contains(lowerFilter) ||
            status.contains(lowerFilter) ||
            locked.contains(lowerFilter) ||
            comment.contains(lowerFilter);
      }).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
}
