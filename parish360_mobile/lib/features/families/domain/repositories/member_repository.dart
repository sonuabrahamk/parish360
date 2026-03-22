import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';

abstract class MemberRepository {
  Future<MemberInfo> createMember(String familyId, MemberInfo memberInfo);
  Future<MemberInfo> updateMember(String familyId, String memberId, MemberInfo memberInfo);
  Future<void> deleteMember(String familyId, String memberId);
  Future<List<MemberInfo>> getMembers(String familyId);
  Future<MemberInfo> getMemberById(String familyId, String memberId);
}