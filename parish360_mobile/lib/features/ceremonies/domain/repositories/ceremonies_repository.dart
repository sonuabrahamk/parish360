import 'package:parish360_mobile/features/ceremonies/domain/entities/ceremony_info.dart';

abstract class CeremoniesRepository {
  Future<List<CeremonyInfo>> getCeremonies();
  Future<CeremonyInfo> getCeremonyInfo(String ceremonyId);
  Future<CeremonyInfo> createCeremony(CeremonyInfo ceremonyInfo);
  Future<CeremonyInfo> updateCeremony(
    String ceremonyId,
    CeremonyInfo ceremonyInfo,
  );
  Future<void> deleteCeremony(String ceremonyId);
}
