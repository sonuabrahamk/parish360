import 'package:parish360_mobile/features/families/domain/entities/family_info.dart';

abstract class FamilyInfoRepository {
  Future<FamilyInfo> createFamily(FamilyInfo familyInfo);
  Future<FamilyInfo> updateFamily(String familyId, FamilyInfo familyInfo);
  Future<FamilyInfo> getFamilyById(String familyId);
  Future<List<FamilyInfo>> getAllFamilies();
}
