import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/parish_year_info.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/py_association_request.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/py_association_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'parish_year_api.g.dart';

@RestApi()
abstract class ParishYearApi {
  factory ParishYearApi(Dio dio, {String baseUrl}) = _ParishYearApi;

  @GET('/configurations/parish-year')
  Future<List<ParishYearInfo>> getParishYearList();

  @POST('/configurations/parish-year')
  Future<ParishYearInfo> createParishYear(
    @Body() ParishYearInfo parishYearInfo,
  );

  @GET('/configurations/parish-year/{parishYearId}')
  Future<ParishYearInfo> getParishYear(
    @Path('parishYearId') String parishYearId,
  );

  @PATCH('/configurations/parish-year/{parishYearId}')
  Future<ParishYearInfo> updateParishYear(
    @Path('parishYearId') String parishYearId,
    @Body() ParishYearInfo parishYearInfo,
  );

  @DELETE('/configurations/parish-year/{parishYearId}')
  Future<void> deleteParishYear(@Path('parishYearId') String parishYearId);

  @POST('/configurations/parish-year/{parishYearId}/associations')
  Future<List<PyAssociationResponse>> mapAssociationsToParishYear(
    @Path('parishYearId') String parishYearId,
    @Body() PyAssociationRequest pyAssociationRequest,
  );

  @DELETE('/configurations/parish-year/{parishYearId}/associations')
  Future<List<PyAssociationResponse>> unMapAssociationsFromParishYear(
    @Path('parishYearId') String parishYearId,
    @Body() PyAssociationRequest pyAssociationRequest,
  );

  @GET('/configurations/parish-year/{parishYearId}/associations')
  Future<List<PyAssociationResponse>> getParishYearAssociations(
    @Path('parishYearId') String parishYearId,
  );

  @GET(
    '/configurations/parish-year/{parishYearId}/associations/{pyAssociationId}',
  )
  Future<PyAssociationResponse> getParishYearAssociation(
    @Path('parishYearId') String parishYearId,
    @Path('pyAssociationId') String pyAssociationId,
  );
}
