import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/families/domain/entities/sacrament_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'sacrament_api.g.dart';

@RestApi()
abstract class SacramentApi {

  factory SacramentApi(Dio dio, {String baseUrl}) = _SacramentApi;

  @POST('/family-records/{familyId}/members/{memberId}/sacraments')
  Future<SacramentInfo> createSacrament(@Path('familyId') String familyId, @Path('memberId') String memberId, @Body() SacramentInfo sacramentInfo);

  @PATCH('/family-records/{familyId}/members/{memberId}/sacraments/{sacramentId}')
  Future<SacramentInfo> updateSacrament(@Path('familyId') String familyId, @Path('memberId') String memberId, @Path('sacramentId') String sacramentId, @Body() SacramentInfo sacramentInfo);

  @GET('/family-records/{familyId}/members/{memberId}/sacraments/{sacramentId}')
  Future<SacramentInfo> getSacramentById(@Path('familyId') String familyId, @Path('memberId') String memberId, @Path('sacramentId') String sacramentId);

  @GET('/family-records/{familyId}/members/{memberId}/sacraments')
  Future<List<SacramentInfo>> getSacraments(@Path('familyId') String familyId, @Path('memberId') String memberId);

  @DELETE('/family-records/{familyId}/members/{memberId}/sacraments/{sacramentId}')
  Future<void> deleteSacrament(@Path('familyId') String familyId, @Path('memberId') String memberId, @Path('sacramentId') String sacramentId);
  
}
