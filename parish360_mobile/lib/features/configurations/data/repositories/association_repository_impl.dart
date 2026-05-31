import 'package:parish360_mobile/features/configurations/data/datasources/associations_api.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/association_info.dart';
import 'package:parish360_mobile/features/configurations/domain/repositories/association_repository.dart';

class AssociationRepositoryImpl implements AssociationRepository {
  final AssociationsApi _associationsApi;

  AssociationRepositoryImpl(this._associationsApi);

  @override
  Future<AssociationInfo> createAssociation(
    AssociationInfo associationInfo,
  ) async {
    return await _associationsApi.createAssociation(associationInfo);
  }

  @override
  Future<void> deleteAssociation(String associationId) async {
    await _associationsApi.deleteAssociation(associationId);
  }

  @override
  Future<List<AssociationInfo>> getAllAssociations() async {
    return await _associationsApi.getAllAssociations();
  }

  @override
  Future<AssociationInfo> getAssociationInfo(String associationId) async {
    return await _associationsApi.getAssociationInfo(associationId);
  }

  @override
  Future<AssociationInfo> updateAssociationInfo(
    String associationId,
    AssociationInfo associationInfo,
  ) async {
    return await _associationsApi.updateAssociation(
      associationId,
      associationInfo,
    );
  }
}
