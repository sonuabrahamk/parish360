import 'package:parish360_mobile/features/families/data/providers/miscellaneous_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/miscellaneous_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'miscellaneous_list_controller.g.dart';

@riverpod
class MiscellaneousListController extends _$MiscellaneousListController {
  @override
  Future<List<MiscellaneousInfo>> build(String familyId) async {
    return await ref
        .watch(miscellaneousRepositoryProvider)
        .getMiscellaneousInfoList(familyId);
  }
}
