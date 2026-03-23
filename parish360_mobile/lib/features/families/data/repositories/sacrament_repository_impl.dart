import 'package:parish360_mobile/features/families/data/datasources/sacrament_api.dart';
import 'package:parish360_mobile/features/families/domain/entities/sacrament_info.dart';
import 'package:parish360_mobile/features/families/domain/repositories/sacrament_repository.dart';

class SacramentRepositoryImpl implements SacramentRepository {
  SacramentApi api;

  SacramentRepositoryImpl(this.api);

  @override
  Future<SacramentInfo> createSacrament(String familyId, String memberId, SacramentInfo sacramentInfo) async {
    final dto = await api.createSacrament(familyId, memberId, sacramentInfo);
    return dto;
  }

  @override
  Future<void> deleteSacrament(String familyId, String memberId, String sacramentId) async {
    await api.deleteSacrament(familyId, memberId, sacramentId);
    return;
  }

  @override
  Future<SacramentInfo> getSacramentById(String familyId, String memberId, String sacramentId) async {
    final dto = await api.getSacramentById(familyId, memberId, sacramentId);
    return dto;
  }

  @override
  Future<List<SacramentInfo>> getSacraments(String familyId, String memberId) async {
    final dto = await api.getSacraments(familyId, memberId);
    return dto;
  }

  @override
  Future<SacramentInfo> updateSacrament(String familyId, String memberId, String sacramentId, SacramentInfo sacramentInfo) async {
    final dto = await api.updateSacrament(familyId, memberId, sacramentId, sacramentInfo);
    return dto;
  }
  
}