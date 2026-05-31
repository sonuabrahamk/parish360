import 'package:parish360_mobile/features/configurations/data/providers/parish_providers.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/parish_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parish_info_controller.g.dart';

@riverpod
class ParishInfoController extends _$ParishInfoController {
  @override
  Future<ParishInfo> build() async {
    return await ref.read(parishRepositoryProvider).getParishInfo();
  }

  Future<ParishInfo> updateParishInfo(ParishInfo parishInfo) async {
    final updatedInfo = await ref
          .read(parishRepositoryProvider)
          .updateParishInfo(parishInfo);
      state = AsyncValue.data(updatedInfo);
      return updatedInfo;
  }
}
