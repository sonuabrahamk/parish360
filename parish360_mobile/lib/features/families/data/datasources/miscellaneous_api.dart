import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/families/domain/entities/miscellaneous_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'miscellaneous_api.g.dart';

@RestApi()
abstract class MiscellaneousApi {
  factory MiscellaneousApi(Dio dio, {String baseUrl}) = _MiscellaneousApi;

  @GET('/family-records/{familyId}/miscellaneous')
  Future<List<MiscellaneousInfo>> getMiscellaneousInfoList(
    @Path('familyId') String familyId,
  );

  @GET('/family-records/{familyId}/miscellaneous/{miscellaneousId}')
  Future<MiscellaneousInfo> getMiscellaneousInfo(
    @Path('familyId') String familyId,
    @Path('miscellaneousId') String miscellaneousId,
  );

  @POST('/family-records/{familyId}/miscellaneous')
  Future<MiscellaneousInfo> addMiscellaneousInfo(
    @Path('familyId') String familyId,
    @Body() MiscellaneousInfo miscellaneousInfo,
  );

  @PATCH('/family-records/{familyId}/miscellaneous/{miscellaneousId}')
  Future<MiscellaneousInfo> updateMiscellaneousInfo(
    @Path('familyId') String familyId,
    @Path('miscellaneousId') String miscellaneousId,
    @Body() MiscellaneousInfo miscellaneousInfo,
  );

  @DELETE('/family-records/{familyId}/miscellaneous/{miscellaneousId}')
  Future<void> removeMiscellaneousInfo(
    @Path('familyId') String familyId,
    @Path('miscellaneousId') String miscellaneousId,
  );
}
