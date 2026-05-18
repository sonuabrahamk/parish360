import 'package:parish360_mobile/features/families/domain/entities/miscellaneous_info.dart';

abstract class MiscellaneousRepository {
  Future<MiscellaneousInfo> addMiscellaneousInfo(
    String familyId,
    MiscellaneousInfo miscellaneousInfo,
  );
  Future<MiscellaneousInfo> updateMiscellaneousInfo(
    String familyId,
    String miscellaneousId,
    MiscellaneousInfo miscellaneousInfo,
  );
  Future<List<MiscellaneousInfo>> getMiscellaneousInfoList(String familyId);
  Future<MiscellaneousInfo> getMiscellaneousInfo(
    String familyId,
    String miscellaneousId,
  );
  Future<void> removeMiscellaneousInfo(String familyId, String miscellaneousId);
}
