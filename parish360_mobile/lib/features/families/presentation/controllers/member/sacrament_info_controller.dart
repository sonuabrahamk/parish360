import 'package:parish360_mobile/features/families/data/providers/sacrament_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/sacrament_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sacrament_info_controller.g.dart';

@riverpod
class SacramentInfoController extends _$SacramentInfoController {

  @override
  Future<SacramentInfo?> build(String familyId, String memberId, String sacramentId) async {
    return ref.read(sacramentRepositoryProvider).getSacramentById(familyId, memberId, sacramentId);
  }

  Future<SacramentInfo> createSacrament(String familyId, String memberId, SacramentInfo sacramentInfo) async {
    final newSacrament = await ref.read(sacramentRepositoryProvider).createSacrament(familyId, memberId, sacramentInfo);
    state = AsyncValue.data(newSacrament);
    return newSacrament;
  }

  Future<SacramentInfo> updateSacrament(String familyId, String memberId, String sacramentId, SacramentInfo sacramentInfo) async {
    final updatedSacrament = await ref.read(sacramentRepositoryProvider).updateSacrament(familyId, memberId, sacramentId, sacramentInfo);
    state = AsyncValue.data(updatedSacrament);
    return updatedSacrament;
  }

  Future<void> deleteSacrament(String familyId, String memberId, String sacramentId) async {
    await ref.read(sacramentRepositoryProvider).deleteSacrament(familyId, memberId, sacramentId);
    state = AsyncValue.error('Sacrament deleted', StackTrace.current); // Clear the state after deletion
  }
}