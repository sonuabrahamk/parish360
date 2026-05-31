import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/resource_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'resources_api.g.dart';

@RestApi()
abstract class ResourcesApi {
  factory ResourcesApi(Dio dio, {String baseUrl}) = _ResourcesApi;

  @GET('/configurations/resources')
  Future<List<ResourceInfo>> getAllResources();

  @POST('/configurations/resources')
  Future<ResourceInfo> createResource(@Body() ResourceInfo resourceInfo);

  @GET('/configurations/resources/{resourceId}')
  Future<ResourceInfo> getResourceInfo(@Path('resourceId') String resourceId);

  @PATCH('/configurations/resources/{resourceId}')
  Future<ResourceInfo> updateResource(
    @Path('resourceId') String resourceId,
    @Body() ResourceInfo resourceInfo,
  );

  @DELETE('/configurations/resources/{resourceId}')
  Future<void> deleteResource(@Path('resourceId') String resourceId);
}
