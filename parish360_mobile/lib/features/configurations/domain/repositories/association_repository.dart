import 'package:parish360_mobile/features/configurations/domain/entities/association_info.dart';

abstract class AssociationRepository {
  Future<List<AssociationInfo>> getAllAssociations();
  Future<AssociationInfo> getAssociationInfo(String associationId);
  Future<AssociationInfo> updateAssociationInfo(
    String associationId,
    AssociationInfo associationInfo,
  );
  Future<AssociationInfo> createAssociation(AssociationInfo associationInfo);
  Future<void> deleteAssociation(String associationId);
}
