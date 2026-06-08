import 'package:parish360_mobile/features/parish-year/data/datasources/parish_year_api.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/parish_year_info.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/py_association_request.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/py_association_response.dart';
import 'package:parish360_mobile/features/parish-year/domain/repositories/parish_year_repository.dart';

class ParishYearRepositoryImpl implements ParishYearRepository {
  final ParishYearApi _parishYearApi;

  ParishYearRepositoryImpl(this._parishYearApi);

  @override
  Future<ParishYearInfo> createParishYear(ParishYearInfo parishYearInfo) async {
    return await _parishYearApi.createParishYear(parishYearInfo);
  }

  @override
  Future<void> deleteParishYear(String parishYearId) async {
    return await _parishYearApi.deleteParishYear(parishYearId);
  }

  @override
  Future<PyAssociationResponse> getParishYearAssociation(
    String parishYearId,
    String pyAssociationId,
  ) async {
    return await _parishYearApi.getParishYearAssociation(
      parishYearId,
      pyAssociationId,
    );
  }

  @override
  Future<List<PyAssociationResponse>> getParishYearAssociations(
    String parishYearId,
  ) async {
    return await _parishYearApi.getParishYearAssociations(parishYearId);
  }

  @override
  Future<ParishYearInfo> getParishYearInfo(String parishYearId) async {
    return await _parishYearApi.getParishYear(parishYearId);
  }

  @override
  Future<List<ParishYearInfo>> getParishYearList() async {
    return await _parishYearApi.getParishYearList();
  }

  @override
  Future<List<PyAssociationResponse>> mapAssociationsToParishYear(
    String parishYearId,
    PyAssociationRequest pyAssociationRequest,
  ) async {
    return await _parishYearApi.mapAssociationsToParishYear(
      parishYearId,
      pyAssociationRequest,
    );
  }

  @override
  Future<List<PyAssociationResponse>> unMapAssociationsFromParishYear(
    String parishYearId,
    PyAssociationRequest pyAssociationRequest,
  ) async {
    return await _parishYearApi.unMapAssociationsFromParishYear(
      parishYearId,
      pyAssociationRequest,
    );
  }

  @override
  Future<ParishYearInfo> updateParishYear(
    String parishYearId,
    ParishYearInfo parishYearInfo,
  ) async {
    return await _parishYearApi.updateParishYear(parishYearId, parishYearInfo);
  }
}
