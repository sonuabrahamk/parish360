import 'package:parish360_mobile/features/families/data/datasources/member_api.dart';
import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';
import 'package:parish360_mobile/features/families/domain/repositories/member_repository.dart';

class MemberRepositoryImpl implements MemberRepository {
  final MemberApi api;

  MemberRepositoryImpl(this.api);
  
  @override
  Future<MemberInfo> createMember(String familyId, MemberInfo memberInfo) async{
    final dto = await api.createMember(familyId, memberInfo);
    return dto;
  }

  @override
  Future<void> deleteMember(String familyId, String memberId) async {
    await api.deleteMember(familyId, memberId);
    return;
  }

  @override
  Future<MemberInfo> getMemberById(String familyId, String memberId) async {
    final dto = await api.getMemberById(familyId, memberId);
    return dto;
  }

  @override
  Future<List<MemberInfo>> getMembers(String familyId) async {
    final dtoList = await api.getMembers(familyId);
    return dtoList;
  }

  @override
  Future<MemberInfo> updateMember(String familyId, String memberId, MemberInfo memberInfo) async {
    final dto = await api.updateMember(familyId, memberId, memberInfo);
    return dto;
  }
}