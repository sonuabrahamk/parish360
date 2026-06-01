import 'package:parish360_mobile/features/configurations/data/providers/associations_providers.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/association_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'association_info_controller.g.dart';

@riverpod
class AssociationInfoController extends _$AssociationInfoController {
  @override
  Future<AssociationInfo> build(String associationId) async {
    return await ref
        .read(associationRepositoryProvider)
        .getAssociationInfo(associationId);
  }

  Future<AssociationInfo> createAssociation(
    AssociationInfo associationInfo,
  ) async {
    return await ref
        .read(associationRepositoryProvider)
        .createAssociation(associationInfo);
  }

  Future<AssociationInfo> updateAssociation(
    String associationId,
    AssociationInfo associationInfo,
  ) async {
    return await ref
        .read(associationRepositoryProvider)
        .updateAssociationInfo(associationId, associationInfo);
  }

  Future<void> deleteAssociation(String associationId) async {
    return await ref
        .read(associationRepositoryProvider)
        .deleteAssociation(associationId);
  }
}
