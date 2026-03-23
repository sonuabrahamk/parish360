import 'package:parish360_mobile/features/families/data/providers/sacrament_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/sacrament_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sacrament_list_controller.g.dart';

@riverpod
class SacramentListController extends _$SacramentListController {
  
  @override
  Future<List<SacramentInfo>> build(String familyId, String memberId) async {
    return ref.read(sacramentRepositoryProvider).getSacraments(familyId, memberId);
  }

}