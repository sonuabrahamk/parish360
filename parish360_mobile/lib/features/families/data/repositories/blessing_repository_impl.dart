import 'package:parish360_mobile/features/families/data/datasources/blessings_api.dart';
import 'package:parish360_mobile/features/families/domain/entities/blessing_info.dart';
import 'package:parish360_mobile/features/families/domain/repositories/blessing_repository.dart';

class BlessingRepositoryImpl implements BlessingRepository {
  final BlessingsApi blessingsApi;

  BlessingRepositoryImpl(this.blessingsApi);

  @override
  Future<BlessingInfo> addBlessing(
    String familyId,
    BlessingInfo blessingInfo,
  ) async {
    return await blessingsApi.addBlessing(familyId, blessingInfo);
  }

  @override
  Future<BlessingInfo> getBlessingInfo(
    String familyId,
    String blessingId,
  ) async {
    return await blessingsApi.getBlessingInfo(familyId, blessingId);
  }

  @override
  Future<List<BlessingInfo>> getBlessings(String familyId) async {
    return await blessingsApi.getBlessings(familyId);
  }

  @override
  Future<void> removeBlessing(String familyId, String blessingId) async {
    return await blessingsApi.removeBlessing(familyId, blessingId);
  }

  @override
  Future<BlessingInfo> updateBlessing(
    String familyId,
    String blessingId,
    BlessingInfo blessingInfo,
  ) async {
    return await blessingsApi.updateBlessing(
      familyId,
      blessingId,
      blessingInfo,
    );
  }
}
