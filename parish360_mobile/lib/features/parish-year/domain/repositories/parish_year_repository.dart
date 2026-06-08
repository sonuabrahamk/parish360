import 'package:parish360_mobile/features/parish-year/domain/entities/parish_year_info.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/py_association_request.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/py_association_response.dart';

abstract class ParishYearRepository {
  Future<List<ParishYearInfo>> getParishYearList();
  Future<ParishYearInfo> getParishYearInfo(String parishYearId);
  Future<ParishYearInfo> createParishYear(ParishYearInfo parishYearInfo);
  Future<ParishYearInfo> updateParishYear(
    String parishYearId,
    ParishYearInfo parishYearInfo,
  );
  Future<void> deleteParishYear(String parishYearId);
  Future<List<PyAssociationResponse>> mapAssociationsToParishYear(
    String parishYearId,
    PyAssociationRequest pyAssociationRequest,
  );
  Future<List<PyAssociationResponse>> unMapAssociationsFromParishYear(
    String parishYearId,
    PyAssociationRequest pyAssociationRequest,
  );
  Future<List<PyAssociationResponse>> getParishYearAssociations(
    String parishYearId,
  );
  Future<PyAssociationResponse> getParishYearAssociation(
    String parishYearId,
    String pyAssociationId,
  );
}
