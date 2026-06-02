import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/bookings/domain/entities/service_intention_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'service_intentions_api.g.dart';

@RestApi()
abstract class ServiceIntentionsApi {
  factory ServiceIntentionsApi(Dio dio, {String baseUrl}) =
      _ServiceIntentionsApi;

  @GET('/service-intentions')
  Future<List<ServiceIntentionInfo>> getServiceIntentions();

  @POST('/service-intentions')
  Future<ServiceIntentionInfo> createServiceIntention(
    @Body() ServiceIntentionInfo serviceIntentionInfo,
  );

  @GET('/service-intentions/{serviceIntentionId}')
  Future<ServiceIntentionInfo> getServiceIntentionInfo(
    @Path('serviceIntentionId') String serviceIntentionId,
  );

  @PATCH('/service-intentions/{serviceIntentionId}')
  Future<ServiceIntentionInfo> updateServiceIntention(
    @Path('serviceIntentionId') String serviceIntentionId,
    @Body() ServiceIntentionInfo serviceIntentionInfo,
  );

  @DELETE('/service-intentions/{serviceIntentionId}')
  Future<void> deleteServiceIntention(
    @Path('serviceIntentionId') String serviceIntentionId,
  );
}
