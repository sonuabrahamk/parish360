import 'package:parish360_mobile/features/families/domain/entities/blessing_info.dart';

abstract class BlessingRepository {
  Future<BlessingInfo> addBlessing(String familyId, BlessingInfo blessingInfo);
  Future<BlessingInfo> updateBlessing(
    String familyId,
    String blessingId,
    BlessingInfo blessingInfo,
  );
  Future<List<BlessingInfo>> getBlessings(String familyId);
  Future<BlessingInfo> getBlessingInfo(String familyId, String blessingId);
  Future<void> removeBlessing(String familyId, String blessingId);
}
