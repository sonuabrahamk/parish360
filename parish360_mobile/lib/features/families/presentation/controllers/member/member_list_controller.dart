import 'package:parish360_mobile/features/families/data/providers/member_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_list_controller.g.dart';

@riverpod
class MemberListController extends _$MemberListController {
  
  @override
  Future<List<MemberInfo>> build(String familyId) async {
    return ref.read(memberRepositoryProvider).getMembers(familyId);
  }

}
