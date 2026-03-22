import 'package:parish360_mobile/features/families/data/datasources/families_api.dart';
import 'package:parish360_mobile/features/families/domain/entities/family_info.dart';
import 'package:parish360_mobile/features/families/domain/repositories/family_info_repository.dart';

class FamilyInfoRepositoryImpl implements FamilyInfoRepository {
  final FamiliesApi api;

  FamilyInfoRepositoryImpl(this.api);

  @override
  Future<FamilyInfo> createFamily(FamilyInfo familyInfo) async {
    final dto = await api.createFamily(familyInfo);
    return dto;
  }

  @override
  Future<FamilyInfo> getFamilyById(String familyId) async {
    final dto = await api.getFamilyById(familyId);
    return dto;
  }

  @override
  Future<List<FamilyInfo>> getAllFamilies() async {
    final dtoList = await api.getAllFamilies();
    return dtoList;
  }
  
  @override
  Future<FamilyInfo> updateFamily(String familyId, FamilyInfo familyInfo) async {
    final dto = await api.updateFamily(familyId, familyInfo);
    return dto;
  }
}