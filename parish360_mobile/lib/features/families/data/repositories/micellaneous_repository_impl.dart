import 'package:parish360_mobile/features/families/data/datasources/miscellaneous_api.dart';
import 'package:parish360_mobile/features/families/domain/entities/miscellaneous_info.dart';
import 'package:parish360_mobile/features/families/domain/repositories/miscellaneous_repository.dart';

class MiscellaneousRepositoryImpl implements MiscellaneousRepository {
  final MiscellaneousApi miscellaneousApi;

  MiscellaneousRepositoryImpl(this.miscellaneousApi);

  @override
  Future<MiscellaneousInfo> addMiscellaneousInfo(
    String familyId,
    MiscellaneousInfo miscellaneousInfo,
  ) async {
    return await miscellaneousApi.addMiscellaneousInfo(
      familyId,
      miscellaneousInfo,
    );
  }

  @override
  Future<MiscellaneousInfo> getMiscellaneousInfo(
    String familyId,
    String miscellaneousId,
  ) async {
    return await miscellaneousApi.getMiscellaneousInfo(
      familyId,
      miscellaneousId,
    );
  }

  @override
  Future<List<MiscellaneousInfo>> getMiscellaneousInfoList(
    String familyId,
  ) async {
    return await miscellaneousApi.getMiscellaneousInfoList(familyId);
  }

  @override
  Future<void> removeMiscellaneousInfo(
    String familyId,
    String miscellaneousId,
  ) async {
    return await miscellaneousApi.removeMiscellaneousInfo(
      familyId,
      miscellaneousId,
    );
  }

  @override
  Future<MiscellaneousInfo> updateMiscellaneousInfo(
    String familyId,
    String miscellaneousId,
    MiscellaneousInfo miscellaneousInfo,
  ) async {
    return await miscellaneousApi.updateMiscellaneousInfo(
      familyId,
      miscellaneousId,
      miscellaneousInfo,
    );
  }
}
