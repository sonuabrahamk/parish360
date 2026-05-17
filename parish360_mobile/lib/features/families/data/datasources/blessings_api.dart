import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/families/domain/entities/blessing_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'blessings_api.g.dart';

@RestApi()
abstract class BlessingsApi {
  factory BlessingsApi(Dio dio, {String baseUrl}) = _BlessingsApi;

  @POST('/family-records/{familyId}/blessings')
  Future<BlessingInfo> addBlessing(
    @Path('familyId') String familyId,
    @Body() BlessingInfo blessingInfo,
  );

  @PATCH('/family-records/{familyId}/blessings/{blessingId}')
  Future<BlessingInfo> updateBlessing(
    @Path('familyId') String familyId,
    @Path('blessingId') String blessingId,
    @Body() BlessingInfo blessingInfo,
  );

  @GET('/family-records/{familyId}/blessings')
  Future<List<BlessingInfo>> getBlessings(@Path('familyId') String familyId);

  @GET('/family-records/{familyId}/blessings/{blessingId}')
  Future<BlessingInfo> getBlessingInfo(
    @Path('familyId') String familyId,
    @Path('blessingId') String blessingId,
  );

  @DELETE('/family-records/{familyId}/blessings/{blessingId}')
  Future<void> removeBlessing(
    @Path('familyId') String familyId,
    @Path('blessingId') String blessingId,
  );
}
