import 'package:parish360_mobile/features/families/data/providers/member_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_info_controller.g.dart';

@riverpod
class MemberInfoController extends _$MemberInfoController {
  @override
  Future<MemberInfo> build(String familyId, String memberId) async {
    return ref.read(memberRepositoryProvider).getMemberById(familyId, memberId);
  }

  Future<MemberInfo> createMember(
    String familyId,
    MemberInfo memberInfo,
  ) async {
    final newMember = await ref
        .read(memberRepositoryProvider)
        .createMember(familyId, memberInfo);
    if (!ref.mounted) {
      return newMember;
    }
    state = AsyncValue.data(newMember);
    return newMember;
  }

  Future<MemberInfo> updateMember(
    String familyId,
    String memberId,
    MemberInfo memberInfo,
  ) async {
    final updatedMember = await ref
        .read(memberRepositoryProvider)
        .updateMember(familyId, memberId, memberInfo);
    if (!ref.mounted) {
      return updatedMember;
    }
    state = AsyncValue.data(updatedMember);
    return updatedMember;
  }

  Future<void> deleteMember(String familyId, String memberId) async {
    await ref.read(memberRepositoryProvider).deleteMember(familyId, memberId);
    if (!ref.mounted) {
      return;
    }
    state = AsyncValue.error(
      'Member deleted',
      StackTrace.current,
    ); // Clear the state after deletion
  }
}
