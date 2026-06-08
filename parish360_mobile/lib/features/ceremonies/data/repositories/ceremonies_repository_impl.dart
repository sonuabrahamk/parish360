import 'package:parish360_mobile/features/ceremonies/data/datasources/ceremonies_api.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/ceremony_info.dart';
import 'package:parish360_mobile/features/ceremonies/domain/repositories/ceremonies_repository.dart';

class CeremoniesRepositoryImpl implements CeremoniesRepository {
  final CeremoniesApi _ceremoniesApi;

  CeremoniesRepositoryImpl(this._ceremoniesApi);

  @override
  Future<CeremonyInfo> createCeremony(CeremonyInfo ceremonyInfo) async {
    return await _ceremoniesApi.createCeremony(ceremonyInfo);
  }

  @override
  Future<void> deleteCeremony(String ceremonyId) async {
    return await _ceremoniesApi.deleteCeremony(ceremonyId);
  }

  @override
  Future<List<CeremonyInfo>> getCeremonies() async {
    return await _ceremoniesApi.getCeremonies();
  }

  @override
  Future<CeremonyInfo> getCeremonyInfo(String ceremonyId) async {
    return await _ceremoniesApi.getCeremonyInfo(ceremonyId);
  }

  @override
  Future<CeremonyInfo> updateCeremony(
    String ceremonyId,
    CeremonyInfo ceremonyInfo,
  ) async {
    return await _ceremoniesApi.updateCeremony(ceremonyId, ceremonyInfo);
  }
}
