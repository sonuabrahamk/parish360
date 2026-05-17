import 'package:parish360_mobile/features/families/data/providers/blessings_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/blessing_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'blessing_list_controller.g.dart';

@riverpod
class BlessingListController extends _$BlessingListController {
  @override
  Future<List<BlessingInfo>> build(String familyId) async {
    return ref.read(blessingRepositoryProvider).getBlessings(familyId);
  }
}
