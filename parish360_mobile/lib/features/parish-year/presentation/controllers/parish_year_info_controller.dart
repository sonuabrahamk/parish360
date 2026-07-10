import 'package:parish360_mobile/features/parish-year/data/providers/parish_year_providers.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/parish_year_info.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/py_association_request.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/py_association_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parish_year_info_controller.g.dart';

@riverpod
class ParishYearInfoController extends _$ParishYearInfoController {
  @override
  Future<ParishYearInfo> build(String parishYearId) async {
    return await ref
        .read(parishYearRepositoryProvider)
        .getParishYearInfo(parishYearId);
  }

  Future<ParishYearInfo> createParishYear(ParishYearInfo parishYearInfo) async {
    return await ref
        .read(parishYearRepositoryProvider)
        .createParishYear(parishYearInfo);
  }

  Future<ParishYearInfo> updateParishYear(
    String parishYearId,
    ParishYearInfo parishYearInfo,
  ) async {
    return await ref
        .read(parishYearRepositoryProvider)
        .updateParishYear(parishYearId, parishYearInfo);
  }

  Future<void> deleteParishYear(String parishYearId) async {
    return await ref
        .read(parishYearRepositoryProvider)
        .deleteParishYear(parishYearId);
  }

  Future<List<PyAssociationResponse>> mapAssociationsToParishYear(
    String parishYearId,
    PyAssociationRequest pyAssociationRequest,
  ) async {
    return await ref
        .read(parishYearRepositoryProvider)
        .mapAssociationsToParishYear(parishYearId, pyAssociationRequest);
  }

  Future<List<PyAssociationResponse>> unMapAssociationsFromParishYear(
    String parishYearId,
    PyAssociationRequest pyAssociationRequest,
  ) async {
    return await ref
        .read(parishYearRepositoryProvider)
        .unMapAssociationsFromParishYear(parishYearId, pyAssociationRequest);
  }

  Future<List<PyAssociationResponse>> getParishYearAssociations(
    String parishYearId,
  ) async {
    return await ref
        .read(parishYearRepositoryProvider)
        .getParishYearAssociations(parishYearId);
  }
}
