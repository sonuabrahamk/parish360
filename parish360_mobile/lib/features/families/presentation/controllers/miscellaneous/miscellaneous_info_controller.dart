import 'package:parish360_mobile/features/families/data/providers/miscellaneous_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/miscellaneous_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'miscellaneous_info_controller.g.dart';

@riverpod
class MiscellaneousInfoController extends _$MiscellaneousInfoController {
  @override
  Future<MiscellaneousInfo> build(
    String familyId,
    String miscellaneousId,
  ) async {
    return await ref
        .watch(miscellaneousRepositoryProvider)
        .getMiscellaneousInfo(familyId, miscellaneousId);
  }

  Future<MiscellaneousInfo> updateMiscellaneousInfo(
    String familyId,
    String miscellaneousId,
    MiscellaneousInfo miscellaneousInfo,
  ) async {
    return await ref
        .watch(miscellaneousRepositoryProvider)
        .updateMiscellaneousInfo(familyId, miscellaneousId, miscellaneousInfo);
  }

  Future<void> deleteMiscellaneousInfo(
    String familyId,
    String miscellaneousId,
  ) async {
    await ref
        .watch(miscellaneousRepositoryProvider)
        .removeMiscellaneousInfo(familyId, miscellaneousId);
  }

  Future<MiscellaneousInfo> createMiscellaneousInfo(
    String familyId,
    MiscellaneousInfo miscellaneousInfo,
  ) async {
    return await ref
        .watch(miscellaneousRepositoryProvider)
        .addMiscellaneousInfo(familyId, miscellaneousInfo);
  }
}
