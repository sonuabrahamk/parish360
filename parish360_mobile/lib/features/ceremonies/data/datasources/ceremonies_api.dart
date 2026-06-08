import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/ceremony_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'ceremonies_api.g.dart';

@RestApi()
abstract class CeremoniesApi {
  factory CeremoniesApi(Dio dio, {String baseUrl}) = _CeremoniesApi;

  @GET('/ceremonies')
  Future<List<CeremonyInfo>> getCeremonies();

  @GET('/ceremonies/{ceremonyId}')
  Future<CeremonyInfo> getCeremonyInfo(@Path('ceremonyId') String ceremonyId);

  @POST('/ceremonies')
  Future<CeremonyInfo> createCeremony(@Body() CeremonyInfo ceremonyInfo);

  @PATCH('/ceremonies/{ceremonyId}')
  Future<CeremonyInfo> updateCeremony(
    @Path('ceremonyId') String ceremonyId,
    @Body() CeremonyInfo ceremonyInfo,
  );

  @DELETE('/ceremonies/{ceremonyId}')
  Future<void> deleteCeremony(@Path('ceremonyId') String ceremonyId);
}
