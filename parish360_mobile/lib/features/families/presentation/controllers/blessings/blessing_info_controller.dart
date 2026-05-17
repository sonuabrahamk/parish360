import 'package:parish360_mobile/features/families/data/providers/blessings_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/blessing_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'blessing_info_controller.g.dart';

@riverpod
class BlessingInfoController extends _$BlessingInfoController {
  @override
  Future<BlessingInfo> build(String familyId, String blessingId) async {
    return ref
        .read(blessingRepositoryProvider)
        .getBlessingInfo(familyId, blessingId);
  }

  Future<BlessingInfo> createBlessingInfo(
    String familyId,
    BlessingInfo blessingInfo,
  ) async {
    return await ref
        .read(blessingRepositoryProvider)
        .addBlessing(familyId, blessingInfo);
  }

  Future<BlessingInfo> updateBlessingInfo(
    String familyId,
    BlessingInfo blessingInfo,
  ) async {
    return await ref
        .read(blessingRepositoryProvider)
        .updateBlessing(familyId, blessingInfo.id ?? '', blessingInfo);
  }

  Future<void> deleteBlessingInfo(String familyId, String blessingId) async {
    await ref
        .read(blessingRepositoryProvider)
        .removeBlessing(familyId, blessingId);
  }
}
