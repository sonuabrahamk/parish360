import 'package:parish360_mobile/features/families/domain/entities/sacrament_info.dart';

abstract class SacramentRepository {
  Future<SacramentInfo> createSacrament(String familyId, String memberId, SacramentInfo sacramentInfo);
  Future<SacramentInfo> updateSacrament(String familyId, String memberId, String sacramentId, SacramentInfo sacramentInfo);
  Future<void> deleteSacrament(String familyId, String memberId, String sacramentId);
  Future<List<SacramentInfo>> getSacraments(String familyId, String memberId);
  Future<SacramentInfo> getSacramentById(String familyId, String memberId, String sacramentId);
}